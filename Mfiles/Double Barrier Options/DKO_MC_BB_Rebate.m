%This is the function for Pricing rebate of a Double Knock out
%barrier options which pays 1 at maturity if break out event
%happens before maturity using Monte Carlo simulation with Brownian Bridge
%No Variance Reduction involved in this program
function [price,std,CI]=DKO_MC_BB_Rebate(S0,r,T,sigma,H,L,N_path)
N=64;
deltaT=T/N;
Stock=zeros(N_path,N+1);
Stock(:,1)=S0;
epsilon=randn(N_path,N);
for i=2:N+1;
    Stock(:,i)=Stock(:,i-1).*exp((r-0.5*sigma^2)*deltaT+...
    sigma*sqrt(deltaT)*epsilon(:,i-1));
end;
value(1:N_path,1)=1;
Stock_BB=Stock((max(Stock,[],2)<H)&(min(Stock,[],2)>L),:);
log_HS=log(H./Stock_BB);
log_LS=log(L./Stock_BB);
PH_matrix=exp((log_HS(:,1:N).*log_HS(:,2:N+1))*(-2)/(sigma^2*deltaT));
PL_matrix=exp((log_LS(:,1:N).*log_LS(:,2:N+1))*(-2)/(sigma^2*deltaT));
Uniform_matrix1=rand(size(Stock_BB,1),N);
Uniform_matrix2=rand(size(Stock_BB,1),N);
value((max(Stock,[],2)<H)&(min(Stock,[],2)>L),:)=...
    1.*~((all(Uniform_matrix1-PH_matrix>0,2))...
    &(all(Uniform_matrix2-PL_matrix>0,2)));
[price,std,CI]=normfit(exp(-r*T)*value);