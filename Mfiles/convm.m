%this is a function for calculating multi-dimensional convolution
function [back,income]=convm(varargin)
back=varargin{1};
income=varargin;
celldisp(income)
if nargin>1
   for i=2:nargin
   back=conv(back,varargin{i});
   end
end