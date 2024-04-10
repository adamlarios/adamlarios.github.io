function burgers(N,T,nu)
% Created by Adam Larios. Last modified on 2015-07-31.
% Solve the 1D (viscous) Burgers equation,
%   u_t + uu_x = nu*u_xx
% Solution uses an explicit spectral method in space,
% 2/3's dealiasing rule used for the nonlinearity.
% RK4 time-stepping, products computed in physical space,

close all;

%Example:
% close all; Burgers_spectral(256,3,0.003,0);

%% =========== Handle Input Parameters ===========

% % Use these options if calling this code from BBM_blow_up.m
use_NL_term = 1; % 1 means include uu_x, otherwise do not include uu_x
dealias = 1; % 1 = yes, else = no (Leave this on unless you have good reason not to)
make_plots = 1; % 1= draw plot, else = don't draw plot
animate = 1; %  1 = yes, else = no

left_endpoint = 0;
right_endpoint = 1;%2*pi; % Currently only set up for [0,2*pi].
% Wave #'s need to be readjusted if another interval.
L = right_endpoint - left_endpoint;

% Preset options so you can just hit the "run" (aka "play") button in Matlab.
if ~(exist('N','var'))
    N = 2^8; % Number of gridpoints (uniform). Powers of 2 are most efficient for fft.
elseif mod(N,2)
    N = N+1;
    display('WARNING: Odd number of gridpoints not supported, adding one to make an even number.');
end
if ~(exist('T','var'))
    T = 2.3;
end
if ~(exist('nu','var'))
    nu=0.003;
end

dx = (right_endpoint - left_endpoint)/N; % Assume uniform grid.
x  = left_endpoint + (0:(N-1))*dx;

%% =========== Initial Conditions ===========
% Commment/Uncomment the initial condition you want

%--- Riemann Initial Conditions ---
% u = zeros(1,N);
% u(1:floor(2*N/3)) = 1;          %----_____
% u(floor(N/3):N) = 1;            %____-----
% u(floor(N/3):floor(2*N/3)) = 1;  %___---___
%---

%--- Cubic interpolation from 0 to 1 ---
% ic_smooth_shock = @(x) (x<-1) + (0.25*x.^3-0.75*x+0.5).*((-1< x) - (1<x));
% u = ic_smooth_shock(x);
%---

%--- Bump Function ---
amp = 12; % amp = 12 gives shock slightly before 1.1 seconds
shift = -2*(left_endpoint+right_endpoint)/L;
ic_bump = @(x) amp*0.25*(exp(1./((x*4/L+shift).^2-1))).*((-1< (x*4/L+shift)) - (1<(x*4/L+shift)));
u_init = ic_bump(x);
u_init(u_init == Inf) = 0; % 0*Inf = Inf, so zero those if they arise.
u_init(isnan(u_init)) = 0; % 0*NaN = NaN, so zero those too.
u = u_init;
%---

%--- Square wave ---
% ic_square = @(x) ((-1< x) - (1<x));
% u = ic_square(x);
%---

%--- Calculus-type initial conditions ---
% u = sin((2*pi/L)*x); % Blow up slightly after T = 0.165
%u = max(0,1-abs(x)); % hat function
%u = x.^2;
%u = exp(sin(x));
%  u = sin((2*pi/L)*x);
%---

u_hat = fft(u); % FFT of initial condition.

% Save initial condition data to set the plotting axes.
ic_min = min(u);
ic_max = max(u);
%ic_norm = norm(u);
%ic_grad = norm(diff(u)./diff(x));

%% =========== Initialization and Setup ===========

% Set time step, respecting both the viscous CFL and the advective CFL.
cfl_adv = 0.4;
cfl_visc = 0.25;
dt_adv = cfl_adv*dx/ic_max;
dt_visc = cfl_visc*dx.^2/nu;
if (nu>0) && (use_NL_term == 1) % Viscosity and nonlinear term
    dt = min([dt_visc dt_adv]);
elseif (nu==0) && (use_NL_term == 1) % Inviscid
    dt = dt_adv;
elseif (nu>0) && (use_NL_term ~= 1) % Heat equation
    dt = dt_visc;
end

t = 0:dt:T;
nT_steps = length(t);

if make_plots == 1
    % Initialize a storage place for the solution.
    u_all = zeros(length(t),N);
end

% wave numbers
wn    = 1i*[0:N/2-1 0 -N/2+1:-1]*(2*pi/L);
wn_sq =   -[0:N/2-1 0 -N/2+1:-1].^2*(2*pi/L)^2;
%k3rd = floor(N/3); % Used for 2/3's dealiasing

energy = zeros(1,length(t));
enstrophy = zeros(1,length(t));

%% =========== Main Time-Stepping Loop ===========

for ti = 1:nT_steps
    % Runge-Kutta-4:
    k1 = compute_rhs_hat(u_hat            ,nu,wn,wn_sq,use_NL_term,dealias,N);
    k2 = compute_rhs_hat(u_hat + 0.5*dt*k1,nu,wn,wn_sq,use_NL_term,dealias,N);
    k3 = compute_rhs_hat(u_hat + 0.5*dt*k2,nu,wn,wn_sq,use_NL_term,dealias,N);
    k4 = compute_rhs_hat(u_hat +     dt*k3,nu,wn,wn_sq,use_NL_term,dealias,N);
    u_hat = u_hat + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);
    
    if make_plots == 1
        % Back to physical space
        u  = real(ifft(u_hat));
        %u_x = real(ifft(wn.*u_hat));
        u_all(ti,:) = u;
    end
    
    energy(ti) = norm(u_hat)^2/N^2;
    enstrophy(ti) = norm(wn.*u_hat)^2/N^2;
end



%% =========== Plotting ============
if make_plots == 1
    m=2;n=2; %sc = 1; % subplot count, plot rows, plot columns
    
    fh = figure;
    %set(fh,'units','normalized','position',[0.5 0.1 .5 0.5 ]); %[x y width height]
    set(fh,'units','normalized','position',[0 0 .9 .9]); %[x y width height]
    
    sc = 2;subplot(m,n,sc);
    title('Energy');
    plot(t,energy,'g','LineWidth',2);
    legend('||u||^2_{L^2}');
%     set(lh,'units','normalized','position',[0.7 0.3 .2 0.2]);

    sc = 4;subplot(m,n,sc);
    title('Enstrophy');
     plot(t,enstrophy,'r','LineWidth',2);
    legend('||u_x||^2_{L^2}');
    
    skip = floor(length(t)/20); % Skip waterfall contours in plot
    sc = 3;subplot(m,n,sc);
    waterfall(x,t(1:skip:end),u_all(1:skip:end,:)), view(10,70), colormap(1e-6*[1 1 1]);
    axis([x(1) x(end) t(1) t(end) 1.1*ic_min 1.1*ic_max]), ylabel t, zlabel u, grid off
    
    sc = 1;subplot(m,n,sc);
    if animate == 1
        skip = 5; % Skip animation frames
        for ti = 1:skip:(length(t)-1)
            plot(x,u_all(ti,:));
            %hold on; plot(x,u_exact(:,ti)); hold off;
            axis([x(1) x(end) 1.1*ic_min 2.1*ic_max]);
            title(sprintf('Solution u(%1.3f)',t(ti)));
            drawnow;
        end
    end
    plot(x,u_all(1,:),'r');
    axis([x(1) x(end) 1.1*ic_min 1.1*ic_max]);
    hold on;
    plot(x,u_all(end,:),'b');
    axis([x(1) x(end) 1.1*ic_min 1.1*ic_max]);
    title(sprintf('nu = %g, T = %g, dt = %g, N = %g',nu,T,dt,N));
end


end % =========== End function BBM_spectral ============

function rhs_hat = compute_rhs_hat(u_hat,nu,wn,wn_sq,use_NL_term,dealias,N)
% Compute the right-hand side, nu*u_xx - uu_x
% in spectral space.  Since this function is called in each iteration of the loop,
% many operators are passed, so they don't need to be computed again.

% The code is set up so these aren't needed, but in case you want to out put
% them, here is how to compute them:
%u_hat = fft(u);
%u_x_hat = wn.*u_hat;
%u_x = real(ifft(u_x_hat));

if nu>0
    u_xx_hat = wn_sq.*u_hat;
    % Here is how to compute u_xx in case you want to output it:
    %u_xx = real(ifft(u_xx_hat));
else
    u_xx_hat = 0;
end

% Compute nonlinear term by 2/3's dealiasing and going back to physical space
if use_NL_term == 1

    if dealias == 1
        u_hat(ceil(N/3):(N - floor(N/3)+1)) = 0;
    end
    
    u  = real(ifft(    u_hat));
    Du = real(ifft(wn.*u_hat));
    
    uDu_hat = fft(u.*Du);
    
else
    uDu_hat = 0;
end

rhs_hat = nu*u_xx_hat - uDu_hat;

%rhs = ifft(rhs_hat); % Not needed, but it's here in case you want to output it.
end % =========== End function BBM_spectral ============