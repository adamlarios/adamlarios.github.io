% Solve the wave equation, u_tt = c^2u_xx 
% using spectral methods and leap-frog time stepping.
% Author: Adam Larios.  Last modified: 2017-01-23.
clear all; close all;

%% Inputs =================================================================
% Resolution (number of points).  Best for FFT to use a power of 2.
N = 2^8;

% Viscosity. Must choose large enough for resolution, small enough for CFL.
c = 1;

% Initial time and final time.
t_0 = 0.0;
t_f = 6.2832;

% Domain is [x_left,x_right).  It is periodic, so we identify endpoints.
x_left = -pi;
x_right = pi;

% Initial condition: triangle wave
u_ic = @(x) max(0,1-abs(x));

% Initial Velocity
v_ic = @(x) 0*x;

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
k = [0:N/2-1, 0, -N/2+1:-1]*(2*pi/L);
k_sq = [0:N/2, -N/2+1:-1].^2*(2*pi/L)^2;

% Compute the c^2*(d/dx)^2 operator in Fourier space
c2Lap_hat = c^2*(-k_sq);

% Initialize u to initial data.
u = u_ic(x);
u(u == Inf) = 0; % 0*Inf = Inf, so zero-out those if they arise.
u(isnan(u)) = 0; % 0*NaN = NaN, so zero-out those too.

u_max = max(u);
u_min = min(u);

v = v_ic(x);

% Compute the DFT (Discrete Fourier Transform) of initial data.
u_hat = fft(u);
v_hat = fft(v);

% Initalize using Ghost-point method:
u_hat_nm1 = u_hat;
u_hat = (1+0.5*dt^2*c2Lap_hat).*u_hat + dt*v_hat;

%% Main time-stepping loop to solve the PDE ===============================
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
    
    % Main update using Leap Frog method
    u_hat_np1 = (2 + dt^2*c2Lap_hat).*u_hat - u_hat_nm1;
    u_hat_nm1 = u_hat;
    u_hat = u_hat_np1;
    
    t = t + dt;
end
