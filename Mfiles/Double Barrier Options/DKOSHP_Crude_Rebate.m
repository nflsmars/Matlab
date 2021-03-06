%This is the function for Pricing rebate of a Double Knock out
%barrier options which pays 1 at maturity if break out event
%happens before maturity using Static Hedging Portfolios
%made up of only european vanilla options
function price=DKOSHP_Crude_Rebate(S0,r,T,sigma,U,L,N)
CUU=zeros(1,N);CUL=zeros(1,N);
PLU=zeros(1,N);PLL=zeros(1,N);
CUS=zeros(1,N);PLS=zeros(1,N);
for i=1:N
    CUU(i)=blsprice(U,U,r,T*((N+1-i)/N),sigma);
    CUL(i)=blsprice(L,U,r,T*((N+1-i)/N),sigma);
    PLU(i)=blsprice(U,L,r,T*((N+1-i)/N),sigma)-U+L*exp(-r*T*((N+1-i)/N));
    PLL(i)=blsprice(L,L,r,T*((N+1-i)/N),sigma)-L+L*exp(-r*T*((N+1-i)/N));
    CUS(i)=blsprice(S0,U,r,T*((N+1-i)/N),sigma);
    PLS(i)=blsprice(S0,L,r,T*((N+1-i)/N),sigma)-S0+L*exp(-r*T*((N+1-i)/N));
end
V=exp(-r*linspace(T,T/N,N));
V=reshape([V;V],2*N,1);
D=zeros(2*N);
D(1,:)=reshape([CUU;PLU],1,2*N);
D(2,:)=reshape([CUL;PLL],1,2*N);
for i=3:2*N
    for j=1:(2*N-round(i/2)*2+2)
        D(i,j)=D(i-2,j+2);
    end
end
h=D\V;
price=reshape([CUS;PLS],1,2*N)*h;