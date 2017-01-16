function [price]=KOCRR(S0,X,r,T,sigma,B,CorP,N,EorA)
if nargin<9
    EorA=0;
end
deltaT=T/N;
u=exp(sigma*sqrt(deltaT));
d=1/u;
p=(exp(r*deltaT)-d)/(u-d);
stock=zeros(N+1,N+1);
value=zeros(N+1,N+1);
if S0<B
    sign=1;
else sign=-1;
end
%construct Stock Tree
for j=1:N+1
    for i=1:j
stock(i,j)=S0*(u^(j-i))*(d^(i-1));
    end
end
%calculate options value at maturity
for i=1:N+1
    if sign*(stock(i,N+1)-B)<0
        value(i,N+1)=max(CorP*(stock(i,N+1)-X),0);
    else value(i,N+1)=0;
    end
end
for j=N:-1:1
    for i=1:j
        if sign*(stock(i,j)-B)<0
        value(i,j)=max(exp(-r*deltaT)*((1-p)*value(i+1,j+1)+(p*value(i,j+1))),EorA*CorP*(stock(i,j)-X));
        else value(i,j)=0;
        end
    end
end
price=value(1,1);