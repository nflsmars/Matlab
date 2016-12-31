S0=40:1:80;
vol=0.05:0.01:0.40;
[VOL,S]=meshgrid(vol,S0);
value=zeros(size(S0,2),size(vol,2));
for i=1:size(S0,2);
    for j=1:size(vol,2);
        value(i,j)=UOCall(S0(i),50,0.1,1,vol(j),80);
    end
end
surf(VOL,S,value)