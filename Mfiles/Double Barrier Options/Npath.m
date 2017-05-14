%This function calculates the number of paths from node(0,x) to node(n,y)
%which hits either of the two barriers(y=0 and y=h) at least once
%The node moves either (1,1) or (1,-1) for every time step. 
function N=Npath(x,y,n,h)
N1=gnchoosek(n,(n+x+y)/2);
N2=gnchoosek(n,(n+2*h-x-y)/2);  
N3=gnchoosek(n,(n+2*h-x+y)/2);
N4=gnchoosek(n,(n+2*h+x-y)/2);
N=N1+N2-N3-N4;
%S0=50,X=50,r=0.1,T=1,sigma=0.4,U=80,L=40,CorP=1,N=500