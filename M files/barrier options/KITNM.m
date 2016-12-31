function [price]=KITNM(S0,X,r,T,sigma,B,CorP,N,EorA)
if nargin<9
    EorA=0;
end
deltaT=T/N;
u=exp(sigma*sqrt(3*deltaT));
d=1/u;
a=exp(r*deltaT);
b=a^2*(exp(sigma^2*deltaT)-1);
Pu=(u*(b+a^2-a)-(a-1))/(u-1)/(u^2-1);
Pd=(u^2*(b+a^2-a)-u^3*(a-1))/(u-1)/(u^2-1);
Pm=1-Pu-Pd;
stock=zeros(2*N+1,N+1);
value=zeros(2*N+1,N+1);
vanilla=zeros(2*N+1,N+1);
if S0<B
    sign=1;
else sign=-1;
end
%construct stock price tree
stock(N+1,1)=S0;
for j=2:N+1
    for i=N-j+2:N+j
stock(i,j)=S0*(d^(i-N-1));
    end
end
%calculate vanilla options value first
for i=1:(2*N+1)
    vanilla(i,N+1)=max(CorP*(stock(i,N+1)-X),0);
end
for j=N:-1:1
    for i=N-j+2:N+j
        vanilla(i,j)=max(exp(-r*deltaT)*(Pd*vanilla(i+1,j+1)+Pm*vanilla(i,j+1)+Pu*vanilla(i-1,j+1)),EorA*CorP*(stock(i,j)-X)); 
    end
end
%contruct option price tree
for i=1:(2*N+1)
    if sign*(stock(i,N+1)-B)<0
        value(i,N+1)=0;
    else value(i,N+1)=max(CorP*(stock(i,N+1)-X),0);
    end
end
for j=N:-1:1
    for i=N-j+2:N+j
        if sign*(stock(i,j)-B)<0
        value(i,j)=exp(-r*deltaT)*(Pd*value(i+1,j+1)+Pm*value(i,j+1)+Pu*value(i-1,j+1));
        else value(i,j)=vanilla(i,j);
        end
    end
end
price=value(N+1,1);
