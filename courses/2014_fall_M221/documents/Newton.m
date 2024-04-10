function x= Newton(F,dF,seed,tolerence);
% Solve F(x) = 0 using Newton's method:
%     x_0 = seed;
%     x_{n+1} = x_n - F(x_n)/F'(x_n);
% Until |x_{n+1} - x_n| < tolerence.
% We calculate F' by hand and input it as dF.
%
% Example run:
% Newton(@(x) x^2 -2, @(x)2*x, 4, 10^(-15))

max_count = 200;

% Do one iteration to set things up.
x_old = seed;
x = x_old - F(x_old)/dF(x_old);

count = 2;

while (abs(x-x_old) >= tolerence)
    x_old = x;
    x = x - F(x)/dF(x); 

    % Prevent an infinite loop: exit if too many iterations:
    count = count + 1;
    if (count > max_count)
        warning('Exceeded max number of iterations!  Output may be incorrect!');
        break % Break the while loop.
    end
end