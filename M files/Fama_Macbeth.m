clear all;clc;
load('FF_factors.mat')
load('FF_25_portfolios.mat')
rf=FF_25_Portfolios(:,5)
portfolios=FF_25_Portfolios(:,2:end)-repmat(rf,1,25)
[T,N]=size(portfolios)
portfolios2=zeros(858,25);
factors=FF_Factors(:,2:4);
for i=1:25
portfolios2(:,i)=FF_25_Portfolios(:,i+1)-(rf); % Excess returns on the 25 portfolios
end
mean25p=mean(portfolios); % Time-Series average excess return std25p=std(portfolios); % Time-Series dispersion of excess returns
std25p=std(portfolios);
M=[];
S=[];
for i=1:5:N
M=[M;mean25p(i:i+4)];
S=[S;std25p(i:i+4)];
end
beta=[ ]; e=[ ]; se=[ ]; Rsquare=[ ];
X=[ones(T,1),factors]; % [Tx4]
Y=portfolios;
for i=1:N
beta=[beta,inv(X'*X)*X'*Y(:,i)];% [4xN]
e=[e,Y(:,i)-X*beta(:,i)]; % [TxN]
se=[se,sqrt(diag((e(:,i)'*e(:,i))/(T-4).*inv(X'*X)))]; % [4xN]
te=beta./se; % [4xN]
stde=std(e); % [1xN]
Rsquare=[Rsquare,1-(e(:,i)'*e(:,i))/((Y(:,i)-mean25p(:,i))'*(Y(:,i)-mean25p(:,i)))]; % [1xN]
end