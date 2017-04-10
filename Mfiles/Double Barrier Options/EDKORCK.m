function price=EDKORCK(S0,X,r,T,sigma,U,L,CorP,N)
deltaT=T/N;
n=floor(log(U/S0)/(sigma*sqrt(deltaT)));
lambda=log(U/S0)/(n*sigma*sqrt(deltaT));
u=exp(lambda*sigma*sqrt(deltaT));
d=1/u;
a=(r-0.5*sigma^2)*sqrt(deltaT)/(2*sigma*lambda);
Pu=1/(2*lambda^2)+a;
Pd=1/(2*lambda^2)-a;
Pm=1-Pu-Pd;
n2=floor(log(S0/L)/(lambda*sigma*sqrt(deltaT)));
gamma=(log(S0/L))/(lambda*sigma*sqrt(deltaT))-n2+1;
b=(lambda)^(-2);
u2=u;
d2=exp(-gamma*lambda*sigma*sqrt(deltaT));
Pu2=(b+a*gamma)/(1+gamma);
Pd2=(b-a)/gamma/(1+gamma);
Pm2=1-Pu2-Pd2;
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
    stock(N+1-n,j)=U;
end
for j=n2+1:N+1
    stock(N+1+n2,j)=L;
end
%contruct option price tree
for i=1:(2*N+1)
    if (U-stock(i,N+1))*(stock(i,N+1)-L)>0
        value(i,N+1)=max(CorP*(stock(i,N+1)-X),0);
    else value(i,N+1)=0;
    end
end
for j=N:-1:1
    for i=N-j+2:N+j
        if (U-stock(i,N+1))*(stock(i,N+1)-L)>0
        value(i,j)=exp(-r*deltaT)*(Pd*value(i+1,j+1)+Pm*value(i,j+1)+Pu*value(i-1,j+1));
        else value(i,j)=0;
        end
    end
    value(N+n2,j)=exp(-r*deltaT)*(Pd2*value(N+n2+1,j+1)+Pm2*value(N+n2,j+1)+Pu2*value(N+n2-1,j+1));
end
price=value(N+1,1);
