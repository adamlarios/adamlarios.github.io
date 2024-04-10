%% We solve a second-order initial value problem numerically.
%
%  Consider the IVP:
%    y'' + 5*y' + 6*t*y + y^2 = e^(-t)
%    y(0) = 7, y'(0) = 3
%
%  Since ode45 only works for first-order system, we use a little trick.
%  Set y1 = y and y2 = y'.  Then we have two first-order equations:
%    y1' = y2
%    y2' = -5*y2 - 6*t*y1 - y1^2 + e^(-t)
%
%  The initial conditions are now:
%    y1(0) = 7,   y2(0) = 3
%
%  In Matlab, we write y(1) instead of y1 and y(2) instead of y2.
%  Note that this does not "y at time 1" or "y and time 2".
%
%  Now, we can use ode45 on these two equations together by treating them
%  as a vector equation, or a "system of equations."

close all; clear all;

% Define the vector on the right-hand side (rhs):
rhs = @(t,y) [y(2); -5*(y(2)) - 6*t*(y(1)) - (y(1))^2 + exp(-t)];
% Here the "@(t,y)" tells Matlab that we want t and y to be variables.

% Solve the IVP with ode45 on the interval [0,4]:
[t_answer, y_answer] = ode45(rhs, [0,4], [3,7]);

% Remember, y(2) was made-up as a place-holder, so we are only interested
% in y(1) for now.  If we call y(:,1), we get all the values stored in
% y(1).
plot(t_answer, y_answer(:,1),'blue');


% On the other hand, y(2) stores the values of y', so we can plot the
% derivative of y for free.
hold on;
plot(t_answer, y_answer(:,2),'red');

legend('y', 'dy/dt');