%This is the function for pricing European Cash or Nothing Binary options
%payoff is set to Payoff,CorP=1 for call,-1 for Put
function price=ECONB(S0,X,r,T,sigma,Payoff,CorP)
d2=(log(S0/X)+(r-sigma^2/2)*T)/(sigma*sqrt(T));
price=Payoff*exp(-r*T)*normcdf(CorP*d2);