clear all;
clc;
NC=50000;
tic
[p(1),s(1),c(:,1)]=DKO_MC(50,50,0.1,1,0.4,80,40,1,NC);
toc
tic
[p(2),s(2),c(:,2)]=DKO_MC(50,50,0.1,1,0.4,80,40,-1,NC);
toc
tic
[p(3),s(3),c(:,3)]=DKI_MC(50,50,0.1,1,0.4,80,40,1,NC);
toc
tic
[p(4),s(4),c(:,4)]=DKI_MC(50,50,0.1,1,0.4,80,40,-1,NC);
toc