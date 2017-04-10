%This is the function for Double Knock Out options
function price=DKISHP(S0,X,r,T,sigma,U,L,CorP,N)%CX+Dh=0 thus h=inv(D)*(CX)
for i=1:N
    [CXU(i),PXU(i)]=blsprice(U,X,r,T*((N+1-i)/N),sigma);%calculate option premiums with exercise price X and stock price U
    [CXL(i),PXL(i)]=blsprice(L,X,r,T*((N+1-i)/N),sigma);%calculate option premiums with exercise price X and stock price L
    CUU(i)=blsprice(U,U,r,T*((N+1-i)/N),sigma);%calculate call premiums with exercise price U and stock price U
    CUL(i)=blsprice(L,U,r,T*((N+1-i)/N),sigma);%calculate call premiums with exercise price U and stock price L
    PLU(i)=blsprice(U,L,r,T*((N+1-i)/N),sigma)-U+L*exp(-r*T*((N+1-i)/N));%calculate call premiums with exercise price L and stock price U
    PLL(i)=blsprice(L,L,r,T*((N+1-i)/N),sigma)-L+L*exp(-r*T*((N+1-i)/N));%calculate call premiums with exercise price L and stock price L
    CUS(i)=blsprice(S0,U,r,T*((N+1-i)/N),sigma);%calculate call premiums with exercise price U and stock price S
    PLS(i)=blsprice(S0,L,r,T*((N+1-i)/N),sigma)-S0+L*exp(-r*T*((N+1-i)/N));%calculate call premiums with exercise price L and stock price S
end
CX=reshape([CXU;CXL],2*N,1);
PX=reshape([PXU;PXL],2*N,1);
%choose N time points,using 2N options,construct D from CUU,CUL,PLU,PLL
D=zeros(2*N);
D(1,:)=reshape([CUU;PLU],1,2*N);
D(2,:)=reshape([CUL;PLL],1,2*N);
for i=3:2*N
    for j=1:(2*N-round(i/2)*2+2)
        D(i,j)=D(i-2,j+2);
    end
end
hC=inv(D)*(CX);
hP=inv(D)*(PX);
if CorP==1
    price=reshape([CUS;PLS],1,2*N)*hC;
    else
    price=reshape([CUS;PLS],1,2*N)*hP;
end