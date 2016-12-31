function P = DICall(S0,X,r,T,sigma,B)
a = (B/S0)^(-1 + (2*r / sigma^2));
b = (B/S0)^(1 + (2*r / sigma^2));
d1 = (log(B^2/S0/X) + (r+sigma^2 / 2)* T) / (sigma*sqrt(T));
d2 = (log(B^2/S0/X) + (r-sigma^2 / 2)* T) / (sigma*sqrt(T));
P = S0*b*normcdf(d1)-X*exp(-r*T)*a*normcdf(d2);