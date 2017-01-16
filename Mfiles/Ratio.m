clear all;clc;
%This is the HW for calc Funds Performance Ratios
%load data
rf_rate=load('r_free.txt');
ele=load('ELE.txt');
nsr=load('NSR.txt');
market=load('index.txt');
N=size(rf_rate,1); %number of observations
%step 1,since rf_rate are quoted annual interest rate, they should be
%converted to daily risk free return first
rf_daily=mean(rf_rate)/N;
%compute portfolio daily return
port_ele=mean(ele,2);
port_nsr=mean(nsr,2);
%Sharpe ratio
SPR_ele=(mean(port_ele)-rf_daily)/std(port_ele)
SPR_nsr=(mean(port_nsr)-rf_daily)/std(port_nsr)
SPR_mkt=(mean(market)-rf_daily)/std(market)
%Treyner Ratio&Jensen's Alpha
Y=[port_ele,port_nsr,market]-repmat(rf_rate,1,3);
X=[ones(N,1),market-rf_rate];
Beta=[];e=[];
for i=1:3
    Beta=[Beta,inv(X'*X)*X'*Y(:,i)];
    e=[e,Y(:,i)-X*Beta(:,i)];
end
TR_ele=(mean(port_ele)-rf_daily)/Beta(2,1)
TR_nsr=(mean(port_nsr)-rf_daily)/Beta(2,2)
TR_mkt=(mean(market)-rf_daily)/Beta(2,3)
JSA_ele=Beta(1,1)
JSA_nsr=Beta(1,2)
JSA_mkt=Beta(1,3)
%Appraisal Ratio
AR_ele=Beta(1,1)/std(e(:,1))
AR_nsr=Beta(1,2)/std(e(:,2))
%another way of calc unsystematic risk,then calc Appraisal Ratio
Beta(1,1)/(var(port_ele-rf_rate)-Beta(2,1)^2*var(market-rf_rate))^0.5
Beta(1,2)/(var(port_nsr-rf_rate)-Beta(2,2)^2*var(market-rf_rate))^0.5
%Thank you!