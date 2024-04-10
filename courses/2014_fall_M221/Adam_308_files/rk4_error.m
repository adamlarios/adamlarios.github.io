% Calculate the maximum global error for increasing numbers of grid points.
% To make a test IVP, we start with a function
%    y(t) = exp(-t)*sin(t^2)
% Then, use this to build an ODE:
%     y' = -exp(-t)*sin(t^2) + 2*t*exp(-t)*cos(t^2) = -y + 2*t*exp(-t)*cos(t^2)
% Notice that y(t) = exp(-t)*sin(t^2) is automatically a solution.  
% To get the initial condition, we plug in t=0 (for example) to y(t):
%     y(0) = exp(-0)*sin(0^2) = 0.
close all;clear all;
y_exact = @(t) exp(-t).*sin(t.^2); % The exact solution.
f = @(t,y) -y + 2*t*exp(-t)*cos(t^2); % Right-hand side of y'=f(t,y).
error = zeros(1,5); % Preallocate error vector for speed.

i=1; % Use a counter to index the error properly.  
for N = [100 200 400 800 1600]
    [Y_approx t] = rk4(f,0,pi,0,N); %Calculate the approximation. Store the time as well.
    error(i) = max(abs(Y_approx - y_exact(t)));
    i = i+1; % Increase counter by one.
end

loglog([100 200 400 800 1600],error,'-o');
title('Log-log plot of error for Runge-Kutta 4');
xlabel('Number of gridpoints'); ylabel('Error');

% Calculate the power of the error,  error = C*N^(-p).
slopes=diff(log(error))./(diff(log([100 200 400 800 1600])));
display(slopes); % A fancy way to output without Matlab complaining.
