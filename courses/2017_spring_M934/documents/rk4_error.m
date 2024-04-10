% Calculate the maximum global error for increasing numbers of grid points.
% Author: Adam Larios
% To make a test IVP, we start with a function
%    y(t) = exp(-t)*sin(t^2)
% Then, use this to build an ODE:
%     y' = -exp(-t)*sin(t^2) + 2*t*exp(-t)*cos(t^2) = -y + 2*t*exp(-t)*cos(t^2)
% Notice that y(t) = exp(-t)*sin(t^2) is automatically a solution.  
% To get the initial condition, we plug in t=0 (for example) to y(t): y(0)=0.

close all;

f = @(t,y) -y + 2*t*exp(-t)*cos(t^2); % Right-hand side of y'=f(t,y).
y_exact = @(t) exp(-t).*sin(t.^2); % The exact solution.

resolutions = [100 200 400 800 1600 3200 6400 12800 25600];

error = zeros(1,length(resolutions)); % Preallocate error vector for speed.

i=1; % Use a counter to index the error properly.  
for N = resolutions
    [y_approx,t] = rk4_ndim(f,0,pi,0,N); %Calculate the approximation. Store the time as well.
    error(i) = max(abs(y_approx - y_exact(t)));
    i = i+1; % Increase counter by one.
end

loglog(resolutions,error,'k-o');
title('Log-log plot of error for Runge-Kutta 4');
xlabel('Number of gridpoints'); 
ylabel('Maximum Error');
axis('tight')

% Display some extra slopes (uses silly plotting tricks to make it look nice).
hold on;
x = linspace(resolutions(4),resolutions(6),100);
loglog(x,x.^-1*(resolutions(4))^1*error(3),'r');
loglog(x,x.^-2*(resolutions(4))^2*error(3),'g');
loglog(x,x.^-3*(resolutions(4))^3*error(3),'b');
loglog(x,x.^-4*(resolutions(4))^4*error(3),'c');
loglog(x,x.^-5*(resolutions(4))^5*error(3),'m');
legend('rk4 error','slope of -1','slope of -2','slope of -3','slope of -4','slope of -5','location','northeast');


% Calculate the power of the error,  error = C*N^(-p).
slopes=diff(log(error))./(diff(log(resolutions)));
display(slopes);