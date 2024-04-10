function wave_equation(N,T)
% A program to compute and plot the solution to
% the 2-D wave equation on a square using the leapfrog scheme.
%    u_tt     = c^2*u_xx + f   on \Omega
%    u(x,0)   = g(x)
%    u_t(x,0) = h(x)
%    u(x,t)   = u_D(x,y)          on the boundary of \Omega

% Sample run:
% close all; wave_equation(40,1601);

% Note: To estimate u^1_j, we use the ghost point u^{-1}_j:
%  (u^1_j-u^{-1}_j)/(2\Delta t) = h(x_j) 
% and the original scheme:
%  u^{n+1}_j = 2u^n_j - u^{n-1}_j + (\Delta t)^2*((\Delta_h u^n)_j + f^n_j)
% which yields
%  u^1_j = u^0_j+\Delta t*h(x_j)+(\Delta t)^2*((\Delta_h u^0)_j + f^0_j)/2

%----------------------------Structures------------------------------

close all;

c = 1;

L = 1;

% Number of grid points on a sideof the square is N.
% Number of time steps is T.  

if (nargin == 0)
    close all;
N = 150;
T = 10*N +1;
end

% The length of time over which the simulation runs.
T_length = 60;
% Number of running time steps (used for shorting animation).
T_run = floor(T/1);

% Variable space.  Omega = (0,12)x(0,12).
x=linspace(0,L,N)';

% Step sizes.
Delta_x=L/N;
Delta_t=T_length/T;

% Note that stability requires Delta_t <= Delta_x.
if T<N
    sprintf('Warning! Must have Delta_t >= Delta_x for stability!');
end

lambda=Delta_t^2/Delta_x^2;

%--------------------------- Initialize -----------------------------------
e = ones(N,1);
Laplacian = spdiags([e -2*e e], -1:1, N, N);

uold=g(x);           % Initial position.
unew=Delta_t*h(x)+Delta_t^2*f(x,0)/2 ...
    +(speye(N)-(lambda/2)*Laplacian)*uold; % Next position.

% Set up the matrix.
A=2*speye(N)-lambda*Laplacian;

%aviobj = avifile('Heat_decay_on_a_square.avi','fps',15);

%--------------------------- Main loop ------------------------------------

for k=1:T_run % Run through time.
    
    % Plot the solution
    plot(x,unew);
    pause
    
    t = (k-1)*Delta_t;
    
    % Update forcing.   
    force = f(x,t);

    % Main calculation
    store = unew;                       % Store t-1 solution.
    unew = A*unew - uold + (Delta_t)^2*force; % Update the t solution to t+1.
    uold = store;                       % Update the t-1 solution to t.
    
    % Reset boundary data.
    unew(1)  = u_DL(t); % left
    unew(N)  = u_DR(t); % right
    

    title(sprintf('t = %2.2f',t));
    drawnow;
     
%     if (k<T_run/1) | (mod(k,3)==0)
%         frame = getframe(gcf);
%         aviobj = addframe(aviobj,frame);
%     end

end

%aviobj = close(aviobj);

unew=reshape(unew,N,N);

end

% ------------------- End main function -----------------------------------

% -------------------Functions called by main function --------------------

% Forcing function f.
function z=f(x,t)
%     a  = (pi/1.31)^2;
%     b  = 1.35;
%     xs = 6;
%     if (t<50)
%     z  =  exp(-7*abs((x-xs(1))))...
%             *2*a*(2*a*(t-b)^2-1)*exp(-a*(t-b)^2);
%     else
%         z = 0;
%     end
z = 0*t*x;
end

% Initial position.
function z=g(x)
   % z = zeros(length(x),1);
   mid = x(end)/2;
   z = mid-abs(x-mid);
end

% Initial velocity.
function z=h(x)
    z = zeros(length(x),1);
end

% Boundary Conditions.
function z=u_DL(t)  % Dirichlet left
    z = 0*t;
end

function z=u_DR(t) % Dirichlet right
    z = 0*t;
end


          
          
          
          
          
          


%