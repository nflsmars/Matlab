clear all;clc;
N=[100,1000];
p=[];
s=[];
C=[];
tic
for i=1:4;
[price,std,CI]=KO_MC(50,50,0.1,1,0.4,80,1,N(i));
p=[p,price];
s=[s,std];
C=[C,CI];
end
toc
load train
sound(y,Fs)