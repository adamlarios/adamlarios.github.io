% A script to plot a direction field in Matlab.
% See Page 66 in the Hunt book.

% First, clear out any existing plots or variables:
clear all; close all;

% Define some coordinates:
[T,Y] = meshgrid(0:10,0:15);

% Define the function:
S = 10 - Y;

% Try this one later by "uncommenting" it (remove the % signs):
%[T,Y] = meshgrid(-2:0.2:3, -1:0.2:2);
%S = exp(-T) -2*Y.^2;

% Quiver is a collection of arrows (cute, I know).
% Here, we take arrows of length one, given by the "ones" function.
% The input gridpoints at T and Y, and the direction of each 
% arrow is determined by S, which we have determined above,
% based on coordinates T and Y.
quiver(T,Y,ones(size(S)), S,'AutoScaleFactor', 1,'MaxHeadSize',0);

% The next option just makes the plot have the right ranges.
axis tight;

% Next, we plot an integral curve useing the ode45 tool.
% In this case, we use the right-hand side of the ODE for the input
% function.  That is, we use f(x) = 10 -x to write the ODE as:
%           y' = f(y)
% We also use the "hold on" keyword to plot the two graphs on the same
% window.  
hold on; 
[t,y] = ode45(@(s,x) 10 - x, [0,10],2);
plot(t,y(:,1),'r-');

% Plot another curve with a different initial value:
hold on; 
[t,y] = ode45(@(s,x) 10 - x, [0,10],13);
plot(t,y(:,1),'b-');

% Exercise: Try to use ode45 to plot integral curves for the direction field
% given by:
% S = exp(-T) - 2*Y.^2
% Doing this means you are numericall solving the ode:
% y' = e^(-t) -2y^2
% In MATLAB, the right-hand side is written as
% @(s,x) exp(-s) - 2*x.^2
