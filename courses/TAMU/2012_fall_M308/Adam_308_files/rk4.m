function [Y t]= rk4(f,t0,T,y0,N)
% Solve dy/dt = f(t,y), y(t0)=y0
% for t0 <= t <= T, with N data points,
% Using the Runge-Kutta-4 algorithm.
% Sample run: 
% [Y t]= rk4(@(t,y) sin(t*y), 0, 5, 0.2, 10);
% plot(t,Y,'-o');

Y = zeros(1,N);       % Preallocate Y for speed.
t = linspace(t0,T,N); % Compute all the time values beforehand.

h = (T - t0)/(N-1)   % Compute the step size (N points means N-1 steps).
Y(1) = y0;            % Start Y at the initial value.

for i = 1:(N-1)
    k1 = f(t(i)        , Y(i)           );
	k2 = f(t(i) + 0.5*h, Y(i) + 0.5*h*k1);
	k3 = f(t(i) + 0.5*h, Y(i) + 0.5*h*k2);
	k4 = f(t(i) +     h, Y(i) +     h*k3);
    Y(i+1) = Y(i) + h*(k1 + 2*k2 + 2*k3 + k4)/6; % Update approximation Y at t+h
end
