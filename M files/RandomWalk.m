p=0.5;
steps=5;
ntrials=20;
for i=1:ntrials-1;
y=[0,cumsum(2*(rand(1,steps)<p)-1)];
hold on;
plot(0:steps,y,'r');
end;
    