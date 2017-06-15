U=[150:-10:110];
L=[60:10:100];
sigma=[0.1,0.15,0.25,0.35];
for i=1:5
    for j=1:4
        result3m(i,j)=IKEDA_DKIP(110,110,0.05,0.25,sigma(j),U(i),L(i));
        result6m(i,j)=IKEDA_DKIP(110,110,0.05,0.5,sigma(j),U(i),L(i));
    end
end