x=0:0.5:4*pi;
h=plot(x, sin(x));		% Plot a sin curve
set(h, 'marker', 'o');		% Set marker to 'o'
set(h, 'markerSize', 15);	% Set marker size to 15
set(h, 'lineWidth', 5);		% Set line width to 5
set(h, 'lineStyle', ':');	% Set line style to dot
set(h, 'markerEdgeColor', 'g');	% Set marker edge color to green
set(h, 'markerFaceColor', 'y');	% Set marker face color to yellow

x=0:0.5:4*pi;
plot(x, sin(x), 'marker', 'o', 'markerSize', 15, 'lineWidth', 5, 'lineStyle', ':', 'markerEdgeColor', 'g', 'markerFaceColor', 'y');

x=0:0.5:4*pi;
opt.marker='o';
opt.markerSize=15;
opt.linewidth=5;
opt.linestyle=':';
opt.markerEdgeColor='g';
opt.markerFaceColor='y';
plot(x, sin(x), opt);