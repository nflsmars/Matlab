%This is the function for pricing Double Knock In 
%barrier options using Static Hedging Portfolios
%made up of only european vanilla options
%1 for Call,-1 for Put
function price=DKISHP_Crude(S0,X,r,T,sigma,U,L,CorP,N)
CXU=zeros(1,N);PXU=zeros(1,N);
CXL=zeros(1,N);PXL=zeros(1,N);
CUU=zeros(1,N);CUL=zeros(1,N);
PLU=zeros(1,N);PLL=zeros(1,N);
CUS=zeros(1,N);PLS=zeros(1,N);
for i=1:N
    [CXU(i),PXU(i)]=blsprice(U,X,r,T*((N+1-i)/N),sigma);
    [CXL(i),PXL(i)]=blsprice(L,X,r,T*((N+1-i)/N),sigma);
    CUU(i)=blsprice(U,U,r,T*((N+1-i)/N),sigma);
    CUL(i)=blsprice(L,U,r,T*((N+1-i)/N),sigma);
    PLU(i)=blsprice(U,L,r,T*((N+1-i)/N),sigma)-U+L*exp(-r*T*((N+1-i)/N));
    PLL(i)=blsprice(L,L,r,T*((N+1-i)/N),sigma)-L+L*exp(-r*T*((N+1-i)/N));
    CUS(i)=blsprice(S0,U,r,T*((N+1-i)/N),sigma);
    PLS(i)=blsprice(S0,L,r,T*((N+1-i)/N),sigma)-S0+L*exp(-r*T*((N+1-i)/N));
end
CX=reshape([CXU;CXL],2*N,1);
PX=reshape([PXU;PXL],2*N,1);
D=zeros(2*N);
D(1,:)=reshape([CUU;PLU],1,2*N);
D(2,:)=reshape([CUL;PLL],1,2*N);
for i=3:2*N
    for j=1:(2*N-round(i/2)*2+2)
        D(i,j)=D(i-2,j+2);
    end
end
if CorP==1
    hC=D\(CX);
    price=reshape([CUS;PLS],1,2*N)*hC;
    else
    hP=D\(PX);
    price=reshape([CUS;PLS],1,2*N)*hP;
end