%This is a generalized nchoosek function
function N=gnchoosek(a,b)
if b>=0&&b<=a
    N=nchoosek(a,b);
else
    N=0;
end