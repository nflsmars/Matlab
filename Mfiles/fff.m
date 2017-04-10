function [f,varargout]=fff(varargin)
input_num=nargin;
output_num=nargout;
if input_num==1
    f=abs(varargin{1});
    varargout{1}=varargin{1};
    varargout{2}=output_num;
elseif input_num==2
    f=varargin{1}+varargin{2};
    varargout{1}=varargin{1};
    varargout{2}=varargin{2};
    varargout{2}=output_num;
else
    error('too many input arguments')
end