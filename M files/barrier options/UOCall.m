function P = UOCall(S0,X,r,T,sigma,B)
a = (B/S0)^(-1 + (2*r / sigma^2));
b = (B/S0)^(1 + (2*r / sigma^2));
d1 = (log(S0/X) + (r+sigma^2 / 2)* T) / (sigma*sqrt(T));
d2 = (log(S0/X) + (r-sigma^2 / 2)* T) / (sigma*sqrt(T));
d3 = (log(S0/B) + (r+sigma^2 / 2)* T) / (sigma*sqrt(T));
d4 = (log(B/S0) + (r+sigma^2 / 2)* T) / (sigma*sqrt(T));
d5 = (log(B^2/S0/X) + (r+sigma^2 / 2)* T) / (sigma*sqrt(T));
P = S0*(normcdf(d1)-normcdf(d3)+b*(normcdf(-d5)-normcdf(-d4)))...
    +X*exp(-r*T)*(-normcdf(d2)+normcdf(d3-sigma*sqrt(T))-...
    a*(normcdf(-d5+sigma*sqrt(T))-normcdf(-d4+sigma*sqrt(T))));