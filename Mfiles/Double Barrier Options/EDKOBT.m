%This is the function for pricing Double Knock Out
%barrier options using Dai&Lyuu Bino-trinomial
%Model(2010),1 for Call,-1 for Put
function price=EDKOBT(S0,X,r,T,sigma,U,L,CorP,N)
k=ceil(log(U/L)/(2*sigma*sqrt(T/N)));
deltaT=(log(U/L)/(2*sigma*k))^2;
u=exp(sigma*sqrt(deltaT));
d=1/u;
pucrr=(exp(r*deltaT)-d)/(u-d);
NCRR=floor(T/deltaT)-1;
Ttrinomial=T-NCRR*deltaT;
mu=r-sigma^2/2;
if mod(NCRR,2)==1
    Loc_B=round((mu*Ttrinomial-log(L/S0)-sigma*sqrt(deltaT))/(2*sigma*sqrt(deltaT)));
    SlogB=(2*sigma*sqrt(deltaT))*Loc_B+sigma*sqrt(deltaT)+log(L/S0);
else
    Loc_B=round((mu*Ttrinomial-log(L/S0))/(2*sigma*sqrt(deltaT)));
    SlogB=(2*sigma*sqrt(deltaT))*Loc_B+log(L/S0);
end
SlogA=SlogB+2*sigma*sqrt(deltaT);
SlogC=SlogB-2*sigma*sqrt(deltaT);
SlogA_adj=SlogA-mu*Ttrinomial;
SlogB_adj=SlogB-mu*Ttrinomial;
SlogC_adj=SlogC-mu*Ttrinomial;
PuPmPd=[SlogA_adj,SlogB_adj,SlogC_adj;SlogA_adj^2,SlogB_adj^2,SlogC_adj^2;1,1,1]\[0;sigma^2*Ttrinomial;1];
Pu=PuPmPd(1);Pm=PuPmPd(2);Pd=PuPmPd(3);
NA=(SlogA-log(L/S0))/(sigma*sqrt(deltaT));
NB=(SlogB-log(L/S0))/(sigma*sqrt(deltaT));
NC=(SlogC-log(L/S0))/(sigma*sqrt(deltaT));
pA=zeros(k-1,1);
VT=zeros(k-1,1);
for i=1:(k-1)
    pA(i,1)=(NCRR+2*i-NA)/2*log(pucrr)+(NCRR-2*i+NA)/2*log(1-pucrr);
    VT(i,1)=max(CorP*(L*u^(2*i)-X),0);
end
pB=pA-log(1-pucrr)+log(pucrr);
pC=pB-log(1-pucrr)+log(pucrr);
logpath=zeros(NCRR+1,1);
for i=1:floor(NCRR/2)
    logpath(i+1,1)=logpath(i,1)+log(NCRR-i+1)-log(i);
end
for i=(floor(NCRR/2)+1):NCRR
     logpath(i+1,1)=logpath(NCRR-i+1,1);
end
PA=zeros(k-1,1);PB=zeros(k-1,1);PC=zeros(k-1,1);
NtotalA=zeros(k-1,1);NtotalB=zeros(k-1,1);NtotalC=zeros(k-1,1);
N1A=zeros(k-1,1);N1B=zeros(k-1,1);N1C=zeros(k-1,1);
N2A=zeros(k-1,1);N2B=zeros(k-1,1);N2C=zeros(k-1,1);
N3A=zeros(k-1,1);N3B=zeros(k-1,1);N3C=zeros(k-1,1);
N4A=zeros(k-1,1);N4B=zeros(k-1,1);N4C=zeros(k-1,1);
for i=1:(k-1)
    if (NCRR+2*i-NA)/2>=0&&(NCRR+2*i-NA)/2<=NCRR
        NtotalA(i,1)=logpath((NCRR+2*i-NA)/2+1,1);
    end
    if (NCRR+2*i-NB)/2>=0&&(NCRR+2*i-NB)/2<=NCRR
        NtotalB(i,1)=logpath((NCRR+2*i-NB)/2+1,1);
    end
    if (NCRR+2*i-NC)/2>=0&&(NCRR+2*i-NC)/2<=NCRR
        NtotalC(i,1)=logpath((NCRR+2*i-NC)/2+1,1);
    end
    if (NCRR+2*i+NA)/2>=0&&(NCRR+2*i+NA)/2<=NCRR
        N1A(i,1)=logpath((NCRR+2*i+NA)/2+1,1);
    end
    if (NCRR+2*i+NB)/2>=0&&(NCRR+2*i+NB)/2<=NCRR
        N1B(i,1)=logpath((NCRR+2*i+NB)/2+1,1);
    end
    if (NCRR+2*i+NC)/2>=0&&(NCRR+2*i+NC)/2<=NCRR
        N1C(i,1)=logpath((NCRR+2*i+NC)/2+1,1);
    end
    if (NCRR+4*k-2*i-NA)/2>=0&&(NCRR+4*k-2*i-NA)/2<=NCRR
        N2A(i,1)=logpath((NCRR+4*k-2*i-NA)/2+1,1);
    end
    if (NCRR+4*k-2*i-NB)/2>=0&&(NCRR+4*k-2*i-NB)/2<=NCRR
        N2B(i,1)=logpath((NCRR+4*k-2*i-NB)/2+1,1);
    end
    if (NCRR+4*k-2*i-NC)/2>=0&&(NCRR+4*k-2*i-NC)/2<=NCRR
        N2C(i,1)=logpath((NCRR+4*k-2*i-NC)/2+1,1);
    end
    if (NCRR+4*k+2*i-NA)/2>=0&&(NCRR+4*k+2*i-NA)/2<=NCRR
        N3A(i,1)=logpath((NCRR+4*k+2*i-NA)/2+1,1);
    end
    if (NCRR+4*k+2*i-NB)/2>=0&&(NCRR+4*k+2*i-NB)/2<=NCRR
        N3B(i,1)=logpath((NCRR+4*k+2*i-NB)/2+1,1);
    end
    if (NCRR+4*k+2*i-NC)/2>=0&&(NCRR+4*k+2*i-NC)/2<=NCRR
        N3C(i,1)=logpath((NCRR+4*k+2*i-NC)/2+1,1);
    end
    if (NCRR+4*k-2*i+NA)/2>=0&&(NCRR+4*k-2*i+NA)/2<=NCRR
        N4A(i,1)=logpath((NCRR+4*k-2*i+NA)/2+1,1);
    end
    if (NCRR+4*k-2*i+NB)/2>=0&&(NCRR+4*k-2*i+NB)/2<=NCRR
        N4B(i,1)=logpath((NCRR+4*k-2*i+NB)/2+1,1);
    end
    if (NCRR+4*k-2*i+NC)/2>=0&&(NCRR+4*k-2*i+NC)/2<=NCRR
        N4C(i,1)=logpath((NCRR+4*k-2*i+NC)/2+1,1);
    end
end
for i=1:(k-1)
    PA(i,1)=exp(NtotalA(i,1)+pA(i,1))-exp(N1A(i,1)+pA(i,1))-exp(N2A(i,1)+pA(i,1))+exp(N3A(i,1)+pA(i,1))+exp(N4A(i,1)+pA(i,1));
    PB(i,1)=exp(NtotalB(i,1)+pB(i,1))-exp(N1B(i,1)+pB(i,1))-exp(N2B(i,1)+pB(i,1))+exp(N3B(i,1)+pB(i,1))+exp(N4B(i,1)+pB(i,1));
    PC(i,1)=exp(NtotalC(i,1)+pC(i,1))-exp(N1C(i,1)+pC(i,1))-exp(N2C(i,1)+pC(i,1))+exp(N3C(i,1)+pC(i,1))+exp(N4C(i,1)+pC(i,1));
end
VA=(PA'*VT)*exp(-r*NCRR*deltaT);
VB=(PB'*VT)*exp(-r*NCRR*deltaT);
VC=(PC'*VT)*exp(-r*NCRR*deltaT);
price=(Pu*VA+Pm*VB+Pd*VC)*exp(-r*Ttrinomial);
