clear all;clc; %CX+Bh=0 thus h=inv(B)*(-CX)
S=120; %knock out price for call option
X=100; %exercise price
r=log(1.1); %convert annual compounding to continuous compounding
q=log(1.05); %convert annual compounding to continuous compounding
vol=0.25 %annualized volatility
N=6 %number of points chosen to ensure boundary condition is satisfied
for i=1:N
CX(i,1)=blsprice(S,X,r,((N+1-i)/N),0.25,q)%calculate option premiums with exercise price X
CB(i,1)=blsprice(S,S,r,((N+1-i)/N),0.25,q)%calculate option premiums with boundary exercise price
end
for i=1:N            %choose N time points,using N+1 options,construct B from CB
for j=1:N+1-i
    B(i,j)=CB(i+j-1) %B is a diagonal matrix,thus invertible
end
end
h=inv(B)*(-CX)
    t=0:0.01:1;
    value=blsprice(120,100,r,t,0.25,q)+...
    h(1)*blsprice(120,120,r,t,0.25,q)+...
    h(2)*blsprice(120,120,r,max(t-1/6,0),0.25,q)+...
    h(3)*blsprice(120,120,r,max(t-2/6,0),0.25,q)+...
    h(4)*blsprice(120,120,r,max(t-3/6,0),0.25,q)+...
    h(5)*blsprice(120,120,r,max(t-4/6,0),0.25,q)+...
    h(6)*blsprice(120,120,r,max(t-5/6,0),0.25,q)
plot(t,value,'blue')
set(gca,'XDir','rev')
xlabel('Time to expiration');
ylabel('Value')
tit(1)={'Value of SHP at knockout price'}
tit(2)={'Using 7 options for 6 time points'}
title(tit)
grid on