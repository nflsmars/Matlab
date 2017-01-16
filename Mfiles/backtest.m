clear all;clc;
data=csvread('3008.csv',1,4);
len=length(data);
for i=1:len;
    data(i,4)=1*exp(sum(data(1:i,1)));
    data(i,5)=1*exp(sum(data(1:i,2)));
    data(i,6)=1*exp(sum(data(1:i,3)));
end
plot(1:len,data(:,4),'red')
hold on;
plot(1:len,data(:,5),'green')
plot(1:len,data(:,6),'blue')
legend('Benchmark','Strategy1','Strategy4')
xlabel('Year')
ylabel('Wealth')
title('3008_Performance','interpreter', 'none')
set(gca, 'XTick', 0:130:1300)
set(gca, 'XTickLabel', {'','2012','','2013','','2014','','2015','','2016',''})