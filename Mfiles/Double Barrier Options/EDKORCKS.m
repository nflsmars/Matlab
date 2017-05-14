%This is the function for pricing Double Knock Out
%barrier options using Ritchken Modified Trinomial
%Model(1995),1 for Call,-1 for Put
function price=EDKORCKS(S0,X,r,T,sigma,U,L,CorP,N)
if (X<=L&&CorP==-1)||(X>=U&&CorP==1)
    price=0;
else
    deltaT=T/N;
    n=floor(log(U/S0)/(sigma*sqrt(deltaT)));
    lambda=log(U/S0)/(n*sigma*sqrt(deltaT));
    a=(r-0.5*sigma^2)*sqrt(deltaT)/(2*sigma*lambda);
    b=(lambda)^(-2);
    u=exp(lambda*sigma*sqrt(deltaT));
    d=1/u;
    Pu=1/(2*lambda^2)+a;
    Pd=1/(2*lambda^2)-a;
    Pm=1-Pu-Pd;
    n2=floor(log(S0/L)/(lambda*sigma*sqrt(deltaT)));
    gamma=(log(S0/L))/(lambda*sigma*sqrt(deltaT))-n2+1;
    Pu2=(b+a*gamma)/(1+gamma);
    Pd2=(b-a)/gamma/(1+gamma);
    Pm2=1-Pu2-Pd2;
    value=zeros(n+n2+1,N+1);
    %contruct option price tree
    for i=2:n+n2
        value(i,N+1)=max(CorP*(S0*(d^(i-n-1))-X),0);
    end
    for j=N:-1:1
        for i=max(n-j+2,2):min(n+j,n+n2)
            value(i,j)=exp(-r*deltaT)*(Pd*value(i+1,j+1)+Pm*value(i,j+1)+Pu*value(i-1,j+1));
        end
        value(n+n2,j)=exp(-r*deltaT)*(Pd2*value(n+n2+1,j+1)+Pm2*value(n+n2,j+1)+Pu2*value(n+n2-1,j+1));
    end
    price=value(n+1,1);
end