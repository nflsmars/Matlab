function price=Hui_DKOR(S,r,T,sigma,H,L)
price=exp(-r*T)-Hui_DKIR(S,r,T,sigma,H,L);