clear all;clc; %CX+Bh=0 thus h=inv(B)*(-CX)
S=120; %knock out price for call option
X=100; %exercise price
r=log(1.05); %convert annual compounding to continuous compounding
q=log(1.03); %convert annual compounding to continuous compounding
vol=0.15; %annualized volatility
N=365; %number of points chosen to ensure boundary condition is satisfied
for i=1:N
CX(i,1)=blsprice(S,X,r,((N+1-i)/N),vol,q);%calculate option premiums with exercise price X
CB(i,1)=blsprice(S,S,r,((N+1-i)/N),vol,q);%calculate option premiums with boundary exercise price
end
for i=1:N            %choose N time points,using N+1 options,construct B from CB
for j=1:N+1-i
    B(i,j)=CB(i+j-1); %B is a diagonal matrix,thus invertible
end
end
h=inv(B)*(-CX);
    t=0:0.01:1;
    sp=90:1:120; %stock price
    [T,SP]=meshgrid(t,sp);
    for j=1:31 %number of stock price
    for k=1:101 %number of time period
        value(j,k)=blsprice(sp(j),100,r,t(k),vol,q);
        for i=1:N %N+1 options in SHP
        value(j,k)=value(j,k)+h(i)*blsprice(sp(j),120,r,max(t(k)+(1-i)/N,0),vol,q);
        end
    end
    end
surf(T,SP,value)
set(gca,'XDir','rev');
title('SHP value');
xlabel('time to maturity');
ylabel('Stock price')
zlabel('SHP value')
colorbar