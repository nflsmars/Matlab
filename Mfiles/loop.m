x(1)=1;a=0.05;b=0.95;
for t=2:100;
  x(t)=a+b*x(t-1)+randn(1);
end;
plot([1:100],x,'r','linewidth',2);
text(50,2,'x(t)=b*x(t-1)+e','fontweight','bold');
ylabel('x')
