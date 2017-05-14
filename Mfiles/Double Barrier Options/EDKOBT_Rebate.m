%This is the function for Pricing rebate of a Double Knock out
%barrier options which pays 1 at maturity if break out event
%happens before maturity using Dai&Lyuu Bino-trinomial
%Model(2010)
function price=EDKOBT_Rebate(S0,r,T,sigma,U,L,N)
price=exp(-r*T)-EDKIBT_Rebate(S0,r,T,sigma,U,L,N);
