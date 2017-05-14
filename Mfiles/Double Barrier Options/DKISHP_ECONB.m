%This is the function for pricing Double Knock In 
%barrier options using Static Hedging Portfolios
%made up of european vanilla options and binary options
%1 for Call,-1 for Put
function price=DKISHP_ECONB(S0,X,r,T,sigma,U,L,CorP,N)
a=max(CorP*(U-X),0);
b=max(CorP*(L-X),0);
CXU=zeros(1,N);PXU=zeros(1,N);
CXL=zeros(1,N);PXL=zeros(1,N);
CUU=zeros(1,N);CUL=zeros(1,N);
PLU=zeros(1,N);PLL=zeros(1,N);
CUS=zeros(1,N);PLS=zeros(1,N);
BCUU=zeros(1,N);BCUL=zeros(1,N);
BPLU=zeros(1,N);BPLL=zeros(1,N);
for i=1:N
    [CXU(i),PXU(i)]=blsprice(U,X,r,T*((N+1-i)/N),sigma);
    [CXL(i),PXL(i)]=blsprice(L,X,r,T*((N+1-i)/N),sigma);
    CUU(i)=blsprice(U,U,r,T*((N+1-i)/N),sigma);
    CUL(i)=blsprice(L,U,r,T*((N+1-i)/N),sigma);
    PLU(i)=blsprice(U,L,r,T*((N+1-i)/N),sigma)-U+L*exp(-r*T*((N+1-i)/N));
    PLL(i)=blsprice(L,L,r,T*((N+1-i)/N),sigma)-L+L*exp(-r*T*((N+1-i)/N));
    CUS(i)=blsprice(S0,U,r,T*((N+1-i)/N),sigma);
    PLS(i)=blsprice(S0,L,r,T*((N+1-i)/N),sigma)-S0+L*exp(-r*T*((N+1-i)/N));
    BCUU(i)=ECONB(U,U,r,T*((N+1-i)/N),sigma,a,1);
    BCUL(i)=ECONB(L,U,r,T*((N+1-i)/N),sigma,a,1);
    BPLU(i)=ECONB(U,L,r,T*((N+1-i)/N),sigma,b,-1);
    BPLL(i)=ECONB(L,L,r,T*((N+1-i)/N),sigma,b,-1);
end
CX=reshape([CXU;CXL],2*N,1);
PX=reshape([PXU;PXL],2*N,1);
BCU=reshape([BCUU;BCUL],2*N,1);
BPL=reshape([BPLU;BPLL],2*N,1);
D=zeros(2*N);
D(1,:)=reshape([CUU;PLU],1,2*N);
D(2,:)=reshape([CUL;PLL],1,2*N);
for i=3:2*N
    for j=1:(2*N-round(i/2)*2+2)
        D(i,j)=D(i-2,j+2);
    end
end
if CorP==1
    hC=D\(CX-BCU-BPL);
    price=reshape([CUS;PLS],1,2*N)*hC+ECONB(S0,U,r,T,sigma,a,1)+ECONB(S0,L,r,T,sigma,b,-1);
    else
    hP=D\(PX-BCU-BPL);
    price=reshape([CUS;PLS],1,2*N)*hP+ECONB(S0,U,r,T,sigma,a,1)+ECONB(S0,L,r,T,sigma,b,-1);
end