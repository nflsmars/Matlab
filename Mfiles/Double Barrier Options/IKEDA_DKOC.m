function price=IKEDA_DKOC(S,X,r,T,sigma,H,L)
mu1=2*r/sigma^2+1;
for N=1:51
    n=N-26;
d1=(log(S*H^(2*n)/(X*L^(2*n)))+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d2=(log(S*H^(2*n-1)/(L^(2*n)))+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d3=(log(L^(2*n+2)/(X*S*H^(2*n)))+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d4=(log(L^(2*n+2)/(S*H^(2*n+1)))+(r+sigma^2/2)*T)/(sigma*sqrt(T));
first(N)=S*((H/L)^(n*mu1)*(normcdf(d1)-normcdf(d2))-(L^(n+1)/(H^n*S))^mu1*(normcdf(d3)-normcdf(d4)));
second(N)=X*exp(-r*T)*((H/L)^(n*(mu1-2))*(normcdf(d1-sigma*sqrt(T))-normcdf(d2-sigma*sqrt(T)))-(L^(n+1)/(H^n*S))^(mu1-2)*(normcdf(d3-sigma*sqrt(T))-normcdf(d4-sigma*sqrt(T))));
x(N)=first(N)-second(N);
end
price=sum(x);