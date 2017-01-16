clc;clear all;
data=csvread('total.csv',1,1);
r2=diff(data)./data(1:(end-1),:);%simple daily return
r1=price2ret(data);%logarithmic daily return 
[rmean,rcov]=ewstats(r1);%compute sample mean and covariance
cov2corr(rcov)

%compute the effcient frontier
portopt(rmean,rcov,100);               
%[PortRisk, PortReturn, PortWts] = portopt(ExpReturn, ExpCovariance,NumPorts, PortReturn)%


%simulate the portfolio's feasible zone
pweight=rand(4000,100);
norm=sum(pweight,2);%for normalization
norm=repmat(norm,[1,100]);%for normalization
%or norm=norm(:,ones(100,1)); ?norm matrix??row,?1,?1,?1,column?100?
pweight=pweight./norm;%for normalization
[portrisk,portreturn]=portstats(rmean,rcov,pweight);
hold on
plot(portrisk,portreturn,'.r');
hold off

%compute the optimal risky asset allocation by maximize sharp ratio
%using fmincon
%assume risk-free rate=3%(annual),242 trading days per year
Aeq=ones(1,100);
Beq=1;
VLB=zeros(1,100);
VUB=[];
x0=ones(1,100)/100;
f=@(x)(-(rmean*x'-0.03/242)/sqrt(x*rcov*x'));
[x,fval]=fmincon(f,x0,[],[],Aeq,Beq,VLB,VUB);






