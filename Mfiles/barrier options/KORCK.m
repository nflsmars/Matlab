function price=KORCK(S0,X,r,T,sigma,B,CorP,N,EorA)
if nargin<9
    EorA=0;
end
deltaT=T/N;
if S0<B
    sign=1;
    n=floor(log(B/S0)/(sigma*sqrt(deltaT)));
    lambda=log(B/S0)/(n*sigma*sqrt(deltaT));
else sign=-1;
    n=floor(log(S0/B)/(sigma*sqrt(deltaT)));
    lambda=log(S0/B)/(n*sigma*sqrt(deltaT));
end
u=exp(lambda*sigma*sqrt(deltaT));
d=1/u;
a=(r-0.5*sigma^2)*sqrt(deltaT)/(2*sigma*lambda);
Pu=1/(2*lambda^2)+a;
Pd=1/(2*lambda^2)-a;
Pm=1-Pu-Pd;
stock=zeros(2*N+1,N+1);
value=zeros(2*N+1,N+1);
%construct stock price tree
stock(N+1,1)=S0;
for j=2:N+1
    for i=N-j+2:N+j
stock(i,j)=S0*(d^(i-N-1));
    end
end
for j=n+1:N+1
    stock(N+1-sign*n,j)=B;
end
%contruct option price tree
for i=1:(2*N+1)
    if sign*(stock(i,N+1)-B)<0
        value(i,N+1)=max(CorP*(stock(i,N+1)-X),0);
    else value(i,N+1)=0;
    end
end
for j=N:-1:1
    for i=N-j+2:N+j
        if sign*(stock(i,j)-B)<0
        value(i,j)=max(exp(-r*deltaT)*(Pd*value(i+1,j+1)+Pm*value(i,j+1)+Pu*value(i-1,j+1)),EorA*CorP*(stock(i,j)-X));
        else value(i,j)=0;
        end
    end
end
price=value(N+1,1);
