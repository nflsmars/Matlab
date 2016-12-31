function P = DOPut(S0,X,r,T,sigma,B)
a = (B/S0)^(-1 + (2*r / sigma^2));
b = (B/S0)^(1 + (2*r / sigma^2));
d1 = (log(S0/X) + (r+sigma^2 / 2)* T) / (sigma*sqrt(T));
d2 = (log(S0/X) + (r-sigma^2 / 2)* T) / (sigma*sqrt(T));
d3 = (log(S0/B) + (r+sigma^2 / 2)* T) / (sigma*sqrt(T));
d4 = (log(S0/B) + (r-sigma^2 / 2)* T) / (sigma*sqrt(T));
d5 = (log(S0/B) - (r-sigma^2 / 2)* T) / (sigma*sqrt(T));
d6 = (log(S0/B) - (r+sigma^2 / 2)* T) / (sigma*sqrt(T));
d7 = (log(S0*X/B^2) - (r-sigma^2 / 2)* T) / (sigma*sqrt(T));
d8 = (log(S0*X/B^2) - (r+sigma^2 / 2)* T) / (sigma*sqrt(T));
P = X*exp(-r*T)*(normcdf(d4)-normcdf(d2) - ...
 a*(normcdf(d7)-normcdf(d5))) ...
 - S0*(normcdf(d3)-normcdf(d1) - ...
b*(normcdf(d8)-normcdf(d6)));