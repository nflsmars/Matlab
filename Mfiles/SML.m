stock=load('MAR.TXT');
market=load('M.TXT');
rf=load('RF.TXT');
for i=1:10
[B(:,i)]=regress(stock(:,i)-rf/12,[ones(24,1),market-rf/12],0.05);
end;
SML=regress(mean(stock)',[ones(10,1),B(2,:)']);
slope=SML(2)