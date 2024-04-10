% A script to test taking derivatives in Fourier space using the FFT.
% Author: Adam Larios.  Last modified: 2017-01-24.
clear all; close all;

% Domain size.  Domain is [0,L].  It is periodic, so we identify 0 and L.
L = 2*pi;

% Resolution (number of points).  Best for FFT to use a power of 2.
N = 2^8;

% Step size.  Should it be L/N or L/(N-1)?
% Consider N=4 points on [0,1]: [0.0, 0.25, 0.5, 0.75]. We need dx = 1/4.
dx = L/N;

% A vector to store all the x-values. 
% Due to the periodicity, we include 0, but not last point.
x = (0:(N-1))*dx;

% Store all the wave-numbers, based on the way Matlab orders them.
k = [0:N/2-1, 0, -N/2+1:-1]*(2*pi/L);
k_sq = [0:N/2, -N/2+1:-1].^2*(2*pi/L)^2; % Include Nyquist frequency N/2.

% A 2pi-periodic function to test, and its exact derivatives.
u    =  exp(sin(x));
u_x  =  cos(x).*u;
u_xx = -sin(x).*u + cos(x).*u_x;

% Compute the DFT (Discrete Fourier Transform).
u_hat = fft(u);

% Compute derivatives in Fourier space.
u_hat_x_approx  =    1i*k.*u_hat;  % Matlab likes "1i" instead of "i".
u_hat_xx_approx = (-k_sq).*u_hat;

% Go back to physical space using ifft, the inverse Fourier transform.
% Use "real" to kill off any round-off error in the imaginary part.
u_x_approx  = real(ifft(u_hat_x_approx));
u_xx_approx = real(ifft(u_hat_xx_approx));

% Compute L^2 and L^infinity errors.
L2Error_u_x    = norm(u_x - u_x_approx)*sqrt(dx);
LinfError_u_x  = max(abs(u_x - u_x_approx));
L2Error_u_xx   = norm(u_xx - u_xx_approx)*sqrt(dx);
LinfError_u_xx = max(abs(u_xx - u_xx_approx));

% Display errors on the command line in a fancy way.
display(sprintf('L2   error in u_x  = %g',L2Error_u_x));
display(sprintf('Linf error in u_x  = %g',LinfError_u_x));
display(sprintf('L2   error in u_xx = %g',L2Error_u_xx));
display(sprintf('Linf error in u_xx = %g',LinfError_u_xx));

% Plot u_x and its approximation.
subplot(1,2,1);
plot(x,u_x,'b-');
hold on;
plot(x,u_x_approx,'ro');
xlabel('x');
ylabel('u_x');
axis('tight');
legend('u_x exact','u_x approx','location','best');
title('FFT computation of u_x');

% Plot u_xx and its approximation.
subplot(1,2,2);
plot(x,u_xx,'b-');
hold on;
plot(x,u_xx_approx,'ro');
xlabel('x');
ylabel('u_{xx}');
axis('tight');
legend('u_{xx} exact','u_{xx} approx','location','best');
title('FFT computation of u_{xx}');
