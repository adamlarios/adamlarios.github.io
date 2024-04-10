% Solve the transport equation, u_t +cu_x = 0
% using spectral methods and fully explicit Euler time stepping.
% This method is unstable.
% Author: Adam Larios.  Last modified: 2017-01-23.
clear all; close all;

%% Inputs =================================================================
% Resolution (number of points).  Best for FFT to use a power of 2.
N = 2^8;

% Viscosity. Must choose large enough for resolution, small enough for CFL.
c = 1;

% Initial time and final time.
t_0 = 0.0;
t_f = 3.0;

% Domain is [x_left,x_right).  It is periodic, so we identify endpoints.
x_left = -pi;
x_right = pi;

% Initial Condition
u_ic = @(x) sin(x) + 0.1*cos(33*x);

% Forcing on right-hand side.
f = @(x,t) 0;

% CFL number for advective term, used to determine time step.
CFL = 0.1; 

%% Grid Setup =============================================================
% Domain length
L = x_right - x_left;

% Step size.  Should it be L/N or L/(N-1)?
% Consider 4 points on [0,1]: [0.0, 0.25, 0.5, 0.75].  Thus, need dx = 1/4.
dx = L/N;
x = x_left + (0:(N-1))*dx;

% Compute time step respecting the advective CFL (required for stability).
dt = CFL*dx/c;
num_times = length(t_0:dt:t_f); % Number of time steps.
t = t_0; % Initialize time.

% Store all the wave-numbers, based on the way Matlab orders them.
k = [0:N/2-1 0 -N/2+1:-1]*(2*pi/L);

% Compute the transport operator in Fourier space
cik = c*1i*k;

% Initialize u to initial data.
u = u_ic(x);
u_max = 2*max(u);
u_min = 2*min(u);

% Compute the DFT (Discrete Fourier Transform) of initial data.
u_hat = fft(u);

%% Main time-stepping loop to solve the PDE.
for ti = 0:num_times
    % Plot by returning to physical space.
    if (mod(ti,10)==1)
        u = real(ifft(u_hat));
        plot(x,u);
        title(sprintf('u(x,%1.3f)',t));
        axis([x_left, x_right, u_min, u_max]); % Fix plot window.
        xlabel('x');
        ylabel('u');
        drawnow;
    end
    
    % Main update using Forward Euler, which is unstable for any dt.
    u_hat = u_hat - dt*(cik.*u_hat);
    
    t = t + dt;
end