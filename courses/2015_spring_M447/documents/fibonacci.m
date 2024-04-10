% Compute the first N Fibonacci numbers.

N = 10;

x = zeros(1,N);

x(1) = 1;
x(2) = 1;
for i = 3:N
    x(i) = x(i-1) + x(i-2);
end

display(x);