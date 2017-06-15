function [price]=DKOCRR(S0,X,r,T,sigma,H,L,CorP,N)
deltaT=T/N;
u=exp(sigma*sqrt(deltaT));
d=1/u;
p=(exp(r*deltaT)-d)/(u-d);
stock=zeros(N+1,N+1);
value=zeros(N+1,N+1);
%construct Stock Tree
for j=1:N+1
    for i=1:j
stock(i,j)=S0*(u^(j-i))*(d^(i-1));
    end
end
%calculate options value at maturity
for i=1:N+1
    if (stock(i,N+1)<H)&&(stock(i,N+1)>L)
        value(i,N+1)=max(CorP*(stock(i,N+1)-X),0);
    else value(i,N+1)=0;
    end
end
for j=N:-1:1
    for i=1:j
        if (stock(i,j)<H)&&(stock(i,j)>L)
        value(i,j)=exp(-r*deltaT)*((1-p)*value(i+1,j+1)+(p*value(i,j+1)));
        else value(i,j)=0;
        end
    end
end
price=value(1,1);