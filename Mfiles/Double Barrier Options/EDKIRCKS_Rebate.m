%This is the function for Pricing rebate of a Double Knock in
%barrier options which pays 1 at maturity if break out event
%does not happen before maturity using Ritchken Modified Trinomial
%Model(1995)
function price=EDKIRCKS_Rebate(S0,r,T,sigma,U,L,N)
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
    value(i,N+1)=1;
end
for j=N:-1:1
   for i=max(n-j+2,2):min(n+j,n+n2)
       value(i,j)=exp(-r*deltaT)*(Pd*value(i+1,j+1)+Pm*value(i,j+1)+Pu*value(i-1,j+1));
   end
       value(n+n2,j)=exp(-r*deltaT)*(Pd2*value(n+n2+1,j+1)+Pm2*value(n+n2,j+1)+Pu2*value(n+n2-1,j+1));
end
price=value(n+1,1);