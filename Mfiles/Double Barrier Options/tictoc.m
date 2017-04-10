clear all;
clc;
tic
N=20000;
result(1)=DKOSHP(50,50,0.1,1,0.4,80,40,1,N);
result(2)=DKOSHP(50,50,0.1,1,0.4,80,40,-1,N);
result(3)=DKISHP(50,50,0.1,1,0.4,80,40,1,N);
result(4)=DKISHP(50,50,0.1,1,0.4,80,40,-1,N);
result(5)=result(1)+result(3);
result(6)=result(2)+result(4);
toc