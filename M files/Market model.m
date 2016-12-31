stock=load('MAR.TXT');
market=load('M.TXT');
for i=1:10
[B(:,i),BINT,R(:,i),RINT,STATS]=regress(stock(:,i),[ones(24,1),market],0.05);
end
Beta=B(2,:)
Var=var(R)