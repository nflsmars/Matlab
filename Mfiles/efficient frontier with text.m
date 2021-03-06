data=load('portfolio.txt');
Rt=price2ret(data);
E_Rt=mean(Rt);
V=cov(Rt);
portopt(E_Rt,V,size(Rt,2))
[Risk,Return]=portopt(E_Rt,V)
GMVP=[min(Risk),min(Return)]
MAX_Rt=[max(Risk),max(Return)]
hold on
gmvp{1}='GMVP'
gmvp{2}=['risk=',num2str(min(Risk))]
gmvp{3}=['return=',num2str(min(Return))]
plot(min(Risk),min(Return),'*')
text(min(Risk),min(Return),gmvp)
MAX{1}='Max_Rt'
MAX{2}=['risk=',num2str(max(Risk))]
MAX{3}=['return=',num2str(max(Return))]
plot(max(Risk),max(Return),'*')
text(max(Risk),max(Return),MAX)