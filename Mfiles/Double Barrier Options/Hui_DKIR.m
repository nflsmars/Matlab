function price=Hui_DKIR(S,r,T,sigma,H,L)
a=0.5-r/sigma^2;
b=-r^2/sigma^4-1/4-r/sigma^2;
for i=1:10000
    x(i)=2*pi*i/(log(H)-log(L))^2*((S/L)^a-(-1)^i*(S/H)^a)/(a^2+(i*pi)^2/(log(H)-log(L))^2)*...
        sin(i*pi/(log(H)-log(L))*log(S/L))*exp(-0.5*((i*pi/(log(H)-log(L)))^2-b)*sigma^2*T);
end
price=sum(x);