tic
sigma=[0.1;0.15;0.25;0.35];
U=[150;140;130;120];
L=[60;70;80;90];
result=zeros(4);
result2=zeros(4);
for j=1:4
    for i=1:4
    result(j,i)=EDKORCKS(110,110,0.05,0.5,sigma(i),U(j),L(j),1,300000);
    end
end
for j=1:4
    for i=1:4
    result2(j,i)=EDKORCKS(110,110,0.05,0.25,sigma(i),U(j),L(j),1,300000);
    end
end
toc