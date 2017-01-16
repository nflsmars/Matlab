function value =Geo(a,r,n,option)
if nargin < 3 
    error('notEnoughInputs')
end;
if nargin < 4 option=0;
end;    
if r >=1
    error('r must < 1')
end;
if n < 1
    error('n must >= 1')
end;
if option==0
   value=a*(1-r^(n+1))/(1-r);
end;
if option==1
   value=r*a*(1-r^(n+1))/(1-r);
end;