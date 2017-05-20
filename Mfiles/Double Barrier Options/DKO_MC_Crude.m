%Crude Monte Carlo for Double Knock Out Barrier Options
%1 for Call,-1 for Put
function [price,std,CI]=DKO_MC_Crude(S0,X,r,T,sigma,U,L,CorP,N_path)
N=10000;
deltaT=T/N;
Stock=zeros(N_path,N+1);
Stock(:,1)=S0;
epsilon=randn(N_path,N);
if (X<=L&&CorP==-1)||(X>=U&&CorP==1)
    value=zeros(1,N_path);
else
    value=zeros(1,N_path);
    for i=2:N+1;
        Stock(:,i)=Stock(:,i-1).*exp((r-0.5*sigma^2)*deltaT+...
        sigma*sqrt(deltaT)*epsilon(:,i-1));
    end;
    for i=1:N_path;
        if max(Stock(i,:))<U&&min(Stock(i,:))>L
            value(i)=max(0,CorP*(Stock(i,end)-X));
        else value(i)=0;
        end
    end
end
[price,std,CI]=normfit(exp(-r*T)*value);