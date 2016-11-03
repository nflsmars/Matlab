r=1.0125;
u=1.175;
d=0.85;
p=(r-d)/(u-d);
q=1-p;
n=1000;
for k=0:n;
    possibility(k+1)=nchoosek(n,k)*p^(k)*q^(n-k);
    s(k+1)=u^(k)*d^(n-k);
end;
possibility*s'
%plot(0:1000,possibility)
plot(log(s)),possibility)