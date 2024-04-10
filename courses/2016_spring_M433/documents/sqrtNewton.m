function x = sqrtNewton(a,numIter)
% A function to compute the square root of 'a'
% using Newton's method (i.e., the Babylonian method).

if ( a < 0 )
   error('Input must be non-negative');
elseif (a == 0)
   x = 0;
   return;
end

x = a;
for k = 1:numIter
   x = 0.5*(x + a/x);
end

display(sprintf('error = %g',abs(x-sqrt(a))));