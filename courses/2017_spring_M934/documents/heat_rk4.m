function heat_rk4
% Solve the heat equation, 
%    u_t = nu*u_xx + f(x,t),  
%    u(x,0) = u_ic(x),
% with periodic boundary conditions using spectral methods and
% fully explicit Runge-Kutta-4 (rk4) time stepping.
% Author: Adam Larios.  Last modified: 2017-01-23.
close all;

%% User Inputs ============================================================
% Resolution (number of points).  Best for FFT to use a power of 2.
N = 2^8;

% Viscosity. Must choose large enough for resolution, small enough for CFL.
nu = 0.01;

% Initial time and final time.
t_0 = 0.0;
t_f = 4.0;

% Domain is [x_left,x_right).  It is periodic, so we identify endpoints.
x_left = -pi;
x_right = pi;

% Initial Condition
u_ic = @(x) sin(x) + 0.2*cos(5*x) + 0.1*sin(33*x);

% Forcing on right-hand side.
f = @(x,t) 0.5*cos(x)/(1+t^2);

% CFL number for viscous term, used to determine time step.
CFL = 2/pi^2; % Need something less than or equal to 2/pi^2.

%% Grid Setup =============================================================
% Domain length
L = x_right - x_left;

% Step size.  Should it be L/N or L/(N-1)?
% Consider 4 points on [0,1]: [0.0, 0.25, 0.5, 0.75].  Thus, need dx = 1/4.
dx = L/N;
x = x_left + (0:(N-1))*dx;

% Compute time step respecting the viscous CFL (required for stability).
dt = CFL*dx^2/nu;
num_times = length(t_0:dt:t_f); % Number of time steps.
t = t_0; % Initialize time.

% Store all the wave-numbers, based on the way Matlab orders them.
k = [0:N/2-1, 0, -N/2+1:-1]*(2*pi/L);
k_sq = [0:N/2, -N/2+1:-1].^2*(2*pi/L)^2;

% Pre-compute the Laplacian operator in Fourier space, times nu.
nu_Lap_hat = nu*(-k_sq);

% Initialize u to initial data.
u = u_ic(x);

% Capture extreme values of u for setting axes in plot.
u_min = min(u);
u_max = max(u);

% Compute the DFT (Discrete Fourier Transform) of initial data.
u_hat = fft(u);

%% Main time-stepping loop to solve the PDE. ==============================
for ti = 1:num_times
    % Plot by returning to physical space.
    u = real(ifft(u_hat));
    plot(x,u);
    title(sprintf('u(x,%1.3f)',t));
    axis([x_left, x_right, u_min, u_max]); % Keep plot window fixed.
    xlabel('x');
    ylabel('u');
    drawnow; % Make Matlab dump the graphics immediately for animation.
    
    % Main update to right-hand side (rhs), using rk4.
    k1 = rhs(t         ,u_hat            ,nu_Lap_hat,f(x,t         ));
    k2 = rhs(t + 0.5*dt,u_hat + 0.5*dt*k1,nu_Lap_hat,f(x,t + 0.5*dt));
    k3 = rhs(t + 0.5*dt,u_hat + 0.5*dt*k2,nu_Lap_hat,f(x,t + 0.5*dt));
    k4 = rhs(t +     dt,u_hat +     dt*k3,nu_Lap_hat,f(x,t +     dt));
    u_hat = u_hat + (k1 + 2*k2 + 2*k3 + k4)*dt/6;
    
    t = t + dt;
end

end % End function "heat_rk4"

function z = rhs(t,u_hat,nu_Lap_hat,force)
z = nu_Lap_hat.*u_hat + fft(force);
end
