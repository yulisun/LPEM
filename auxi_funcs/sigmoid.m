function y = sigmoid(x,c,a)
% sigmoid evaluates a simple sigmoid function along x: 
% 
%         ______1________
%     y =        -a(x-c)
%          1 + e^
% 
%%
narginchk(1,3) 
if nargin<3
    a = 1; 
else
    assert(isscalar(a)==1,'a must be a scalar.') 
end
if nargin<2
    c = 0; 
else
    assert(isscalar(c)==1,'c must be a scalar.') 
end
y = 1./(1 + exp(-a.*(x-c)));
