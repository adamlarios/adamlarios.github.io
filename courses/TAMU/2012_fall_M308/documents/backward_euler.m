function [Y t]= backward_euler(f,dfdy,t0,T,y0,N)
% Solve dy/dt = f(t,y), y(t0)=y0, for t0 <= t <= T, with N time steps.
% We use backward Euler with a Newton's method to solve.
% dfdy is the derivative of f with respect to y.
% You should implement your own Newton solver to use this program.
% Sample run: 
% [Y t] = backward_euler(@(t,y) 0.5*(1-y/100)*y+10*sin(t),@(t,y) 0.5-y/100,0,40,10,80);
% plot(t,Y,'-o');
close all;

tolerence = 10^(-12);

% Calulate and store the step-size:
if (~exist('h','var')); h = (T - t0)/N; end
% Calulate and store the number of steps:
if (~exist('N','var')); N = ceil((T - t0)/h); end
 % Calulate and store the final time:
if (~exist('T','var')); T = t0 + h*N; end

Y = zeros(1,N); % Initialize the solution vector.

%sprintf('t0=%g, T=%g, y0=%g, N=%g, h=%g',t0,T,y0,N,h)

t = linspace(t0,T,N); % A vector to store the time values.
Y(1) = y0; % Start Y at the initial value.

for n = 1:(N-1)
    F = @(y) Y(n) + h*f(t(n+1),y) - y;
    dF = @(y) h*dfdy(t(n+1),y) - 1;
    Y(n+1) = Newton(F,dF,Y(n),tolerence); % Y(n) is used as a seed value.
end












