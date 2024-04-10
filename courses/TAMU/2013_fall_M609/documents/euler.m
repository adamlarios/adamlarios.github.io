%% FILE forward_euler.m %%

function [Y t]= forward_euler(f,t0,T,y0,N)
% Solve dy/dt = f(t,y), y(t0)=y0
% for t0 <= t <= T, with N time steps.
% Sample run: 
% [Y t]= euler(@(t,y) sin(t*y), 0, 5, 0.2, 10);
% plot(t,Y,'-o');
close all;

h = (T - t0)/(N-1);
Y = zeros(1,N);

t = linspace(t0,T,N); % A vector to store the time values.
Y(1) = y0; % Start Y at the initial value.

for i = 1:(N-1)
  Y(i+1) = Y(i) + h*f(t(i),Y(i)); % Update approximation Y at t+h
end
   
%%% END FILE %%%