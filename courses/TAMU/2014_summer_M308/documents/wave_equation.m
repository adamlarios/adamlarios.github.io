function unew=wave_equation(N,T)
% close all
% A program to compute and plot the solution to
% the 2-D wave equation on a square using the leapfrog scheme.
%    u_tt     = Laplacian u + f   on \Omega
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

if (nargin == 0)
    N=64;
    T=N^2+1;
end

%----------------------------Structures------------------------------

% Number of grid points on a side of the square is N.
% Number of time steps is T.  

% The length of time over which the simulation runs.
T_length = 60;
% Number of running time steps (used for shorting animation).
T_run = floor(T/1);

% Variable space.  Omega = (0,12)x(0,12).
x=linspace(0,12,N);
y=linspace(0,12,N);
[X,Y] = meshgrid(x,y);

% Step sizes.
Delta_x=12/N;
Delta_t=T_length/T;

% Note that stability requires Delta_t <= Delta_x.
if T<N
    sprintf('Warning! Must have Delta_t >= Delta_x for stability!');
end

lambda=Delta_t^2/Delta_x^2;

%--------------------------- Initialize -----------------------------------

uold=reshape(g(X,Y),N^2,1);            % Initial position.
unew=Delta_t*reshape(h(X,Y),N^2,1)+Delta_t^2*reshape(f(X,Y,0),N^2,1)/2 ...
    +(speye(N^2)-(lambda/2)*delsq(numgrid('S',N+2)))*uold; % Next position.

% Set up the matrix.
A=2*speye(N^2)-lambda*delsq(numgrid('S',N+2));

%aviobj = avifile('Heat_decay_on_a_square.avi','fps',15);

%--------------------------- Main loop ------------------------------------

for k=1:T_run % Run through time.
    
    t = (k-1)*Delta_t;
    
    % Update forcing.   
    force = reshape(f(X,Y,t),N^2,1);

    % Main calculation
    store = unew;                       % Store t-1 solution.
    unew = A*unew - uold + (Delta_t)^2*force; % Update the t solution to t+1.
    uold = store;                       % Update the t-1 solution to t.
    
    % Reset boundary data.
    unew(1:N)            = u_D(x(1),y   ,t); % bottom
    unew((1:N) +N*(N-1)) = u_D(x(N),y   ,t); % top
    unew(1+N*((1:N)-1))  = u_D(x   ,y(1),t); % left
    unew(N+N*((1:N)-1))  = u_D(x   ,y(N),t); % right
    
    % Plot the solution
    % Put u back into matrix form, calling it u_mat.
    u_mat=reshape(uold,N,N);
    surf(x,y,u_mat);
    %shading interp;
    axis([0,12,0,12,-0.1,0.1]);
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
function z=f(x,y,t)
    a  = (pi/1.31)^2;
    b  = 1.35;
    xs = [6 6];
    z  =  exp(-7*sqrt((x-xs(1)).^2+(y-xs(2)).^2))...
            *2*a*(2*a*(t-b)^2-1)*exp(-a*(t-b)^2);
end

% Initial position.
function z=g(x,y)
    z = zeros(length(x),length(y));
end

% Initial velocity.
function z=h(x,y)
    z = zeros(length(x),length(y));
end

% Boundary Conditions.
function z=u_D(x,y,t)
    z = zeros(length(x),length(y))*t;
end


          
          
          
          
          
          


%
