clear all;clc; %CX+Bh=0 thus h=inv(B)*(-CX)
S=120; %knock out price for call option
X=100; %exercise price
r=log(1.1); %convert annual compounding to continuous compounding
q=log(1.05); %convert annual compounding to continuous compounding
vol=0.25; %annualized volatility
N=6; %number of points chosen to ensure boundary condition is satisfied
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
    value=blsprice(120,100,r,t,vol,q);
    for i=1:N
    value=value+h(i)*blsprice(120,120,r,max(t+(1-i)/N,0),vol,q);
    end
plot(t,value)
set(gca,'XDir','rev')
xlabel('Time to expiration');
ylabel('Value')
tit(1)={'Value of SHP at knockout price'}
tit(2)={'Using 7 options for 6 time points'}
title(tit)
grid on