close all; clear all;
% A program to plot the Fourier Sine series of the constant function:
%   f(x) = 50  on the interval [0,L]
% The result converges to the odd periodic extension of f(x), 
% except at the jumps.

L = 3; % Length
x = linspace(-2*L,2*L,10000); % x ranging from -2L to 2L with 1000 points.
N = 100; % Number of iterations

f = 0; % Initialize the variable so we can use it later.

% Loop starting with 1 and stepping up by 2 each time
for n = 1:2:N   %n = 1, 3, 5, 7, ... , N
    
    % The coefficients B_n were found by computing the integral by hand
    Bn = 200/(n*pi);
    % Compute the n_th term of the Fourier Sine series.  
    n_th_term = Bn*sin(n*pi*x/L);
    
    % Add n_th term
    f = f + n_th_term;
    
    plot(x,f,'b'); hold on;  % Plot the partial sums of the Fourier series
    plot(x,n_th_term,'r'); hold on; % Plot the n_th term being added on.
    
    pause;% Slow down the plotting by pausing
end
