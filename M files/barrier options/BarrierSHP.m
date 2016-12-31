%This is the function for Knock Out options
%IorO%%Input 1 for knock in,input -1 for knock out
%BarrierSHP(S0,X,r,T,vol,B,IorO,N)
function [call,put]=BarrierSHP(S0,X,r,T,vol,B,IorO,N)%CX+Dh=0 thus h=inv(D)*(-CX)
for i=1:N
    [CX(i),PX(i)]=blsprice(B,X,r,T*((N+1-i)/N),vol);%calculate option premiums with exercise price X
    [CB(i),PB(i)]=blsprice(B,B,r,T*((N+1-i)/N),vol);%calculate option premiums with boundary exercise price
    [CS(i),PS(i)]=blsprice(S0,B,r,T*((N+1-i)/N),vol);%calculate option premiums with boundary exercise price
end
for i=1:N            %choose N time points,using N+1 options,construct D from CB
   for j=1:N+1-i
        if B>S0
        D(i,j)=CB(i+j-1);
        else    D(i,j)=PB(i+j-1); %D is a diagonal matrix,thus invertible
        end
   end
end
hC=IorO*inv(D)*(CX)';
hP=IorO*inv(D)*(PX)';
if IorO==-1
[a,b]=blsprice(S0,X,r,T,vol);
else a=0;b=0;
end
 if B>S0
    put=b+CS*hP;
    call=a+CS*hC;
    else
    put=b+PS*hP;
    call=a+PS*hC;
 end