function price=IKEDA_DKOP(S,X,r,T,sigma,H,L)
mu1=2*r/sigma^2+1;
for N=1:51
    n=N-26;
d1=(log(S*H^(2*n)/(X*L^(2*n)))+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d5=(log(S*H^(2*n)/(L^(2*n+1)))+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d3=(log(L^(2*n+2)/(X*S*H^(2*n)))+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d6=(log(L^(2*n+1)/(S*H^(2*n)))+(r+sigma^2/2)*T)/(sigma*sqrt(T));
first(N)=X*exp(-r*T)*((H/L)^(n*(mu1-2))*(normcdf(d5-sigma*sqrt(T))-normcdf(d1-sigma*sqrt(T)))-(L^(n+1)/(H^n*S))^(mu1-2)*(normcdf(d6-sigma*sqrt(T))-normcdf(d3-sigma*sqrt(T))));
second(N)=S*((H/L)^(n*mu1)*(normcdf(d5)-normcdf(d1))-(L^(n+1)/(H^n*S))^mu1*(normcdf(d6)-normcdf(d3)));
x(N)=first(N)-second(N);
end
price=sum(x);