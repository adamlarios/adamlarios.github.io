function [Y t]= forward_euler(f,t0,T,y0,N)
% Solve dy/dt = f(t,y), y(t0)=y0
% for t0 <= t <= T, with N time steps.
% Sample run: 
%[Y t] = forward_euler(@(t,y) 0.5*(1-y/100)*y+10*sin(t),0,40,10,80);
% plot(t,Y,'-o');
close all;

% Calulate and store the step-size:
if (~exist('h','var')); h = (T - t0)/N; end
% Calulate and store the number of steps:
if (~exist('N','var')); N = ceil((T - t0)/h); end
 % Calulate and store the final time:
if (~exist('T','var')); T = t0 + h*N; end

Y = zeros(1,N); % Initialize the solution vector.

sprintf('t0=%g, T=%g, y0=%g, N=%g, h=%g',t0,T,y0,N,h)

t = linspace(t0,T,N); % A vector to store the time values.
Y(1) = y0; % Start Y at the initial value.

for n = 1:(N-1)
  Y(n+1) = Y(n) + h*f(t(n),Y(n)); % Update approximation Y at t+h
end