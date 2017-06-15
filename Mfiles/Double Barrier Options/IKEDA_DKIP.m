function price=IKEDA_DKIP(S,X,r,T,sigma,H,L)
price=blsprice(S,X,r,T,sigma)-S+X*exp(-r*T)-IKEDA_DKOP(S,X,r,T,sigma,H,L);