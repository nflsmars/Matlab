%This is the function for pricing Double Knock In
%barrier options using Dai&Lyuu Bino-trinomial
%Model(2010),1 for Call,-1 for Put
function price=EDKIBT(S0,X,r,T,sigma,U,L,CorP,N)
[a,b]=blsprice(S0,X,r,T,sigma);
total=a*(0.5*CorP+0.5)+b*(-0.5*CorP+0.5);
price=total-EDKOBT(S0,X,r,T,sigma,U,L,CorP,N);