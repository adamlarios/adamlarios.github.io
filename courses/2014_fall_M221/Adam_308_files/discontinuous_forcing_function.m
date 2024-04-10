%% A graph of the solution to the example we saw in class on 2012 March 7
%
%    y''+2y'+26y = dirac(t-4)
%    y(0)  = 1
%    y'(0) = 0
%

clear all ; close all;

% First, put t on the interval from [0,4].  
% I used 4000 points, since it is easy to stop the index at 4000.
t = linspace(0,4,4000);

% Use M
y(1:4000) = exp(-t).*cos(5*t) + (1/5)*exp(-t).*sin(5*t);

% Resume t on the interval from [4,5].  
% I used 4000 points, since it is easy to stop the index at 4000.
t = linspace(4,5,1000);

y(4001:5000) = exp(-t).*cos(5*t) + (1/5)*exp(-t).*sin(5*t) + (1/5)*exp(-(t-4)).*sin(5*t);

% Make t cover the whole interval for plotting.
t = linspace(0,5,5000);
plot(t,y,'b');
axis([0 5 -15 11]);

% dy = diff(y)/(1/5000);
% hold on;
% plot(t(1:4999),dy,'c');
% 
% legend('y','dy/dt');