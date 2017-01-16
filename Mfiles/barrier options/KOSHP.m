%This is the function for Knock Out options
function [call,put]=KOSHP(S0,X,r,T,vol,B,N)%CX+Dh=0 thus h=inv(D)*(-CX)
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
hC=inv(D)*(-CX)';
hP=inv(D)*(-PX)';
[a,b]=blsprice(S0,X,r,T,vol);
 if B>S0
    put=b+CS*hP;
    call=a+CS*hC;
    else
    put=b+PS*hP;
    call=a+PS*hC;
end