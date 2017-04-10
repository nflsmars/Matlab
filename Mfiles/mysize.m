function [sizeVector,varargout] = mysize(x)
   sizeVector = size(x);
   varargout = cell(1,nargout-1);
   for k = 1:length(varargout)
      varargout{k} = sizeVector(k);
   end