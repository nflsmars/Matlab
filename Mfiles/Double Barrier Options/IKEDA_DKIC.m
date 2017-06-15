function price=IKEDA_DKIC(S,X,r,T,sigma,H,L)
price=blsprice(S,X,r,T,sigma)-IKEDA_DKOC(S,X,r,T,sigma,H,L);