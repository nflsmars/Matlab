data=load('data40.txt');
Rt=price2ret(data);
for i=1:40
    avgrt(:,i)=sum(Rt(:,1:i),2)/i; %assume equal weight in portfolio
end
var=diag(cov(avgrt));
var=var.*270;
stdev=var.^0.5;
plot(1:40,stdev) %portfolio stdev for Number of Stocks from 1 to 40
hold on
plot([1,5,10,20,40],stdev([1,5,10,20,40])) 
%portfolio stdev for first 1,5,10,20,40 Stocks
legend('1to40','1,5,10,20,40')
xlabel('Number of Stocks')
ylabel('Portfolio Standard deviation')
title('Stdev of Naive Diversification')
