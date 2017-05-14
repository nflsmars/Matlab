%This is a function for calculating values from
%log(nchoosek(n,0)) to log(nchoosek(n,n))
function X=lognchk(n)
X=zeros(n+1,1);
for i=1:n
    X(i+1,1)=X(i,1)+log(n-i+1)-log(i);
end
end