%Crude Monte Carlo for Double Knock Out Barrier Options
%1 for Call,-1 for Put
%S0=50;X=50;r=0.1;T=1;sigma=0.4;H=80;L=40;CorP=1;N_path=10000;
function [price,std,CI]=DKO_MC_new(S0,X,r,T,sigma,H,L,CorP,N_path)
N=10000;
deltaT=T/N;
Stock=zeros(N_path,N+1);
Stock(:,1)=S0;
epsilon=randn(N_path,N);
for i=2:N+1;
    Stock(:,i)=Stock(:,i-1).*exp((r-0.5*sigma^2)*deltaT+...
    sigma*sqrt(deltaT)*epsilon(:,i-1));
end;
value=max(0,CorP*(Stock(:,end)-X)).*((max(Stock,[],2)<H)&(min(Stock,[],2)>L));
[price,std,CI]=normfit(exp(-r*T)*value);