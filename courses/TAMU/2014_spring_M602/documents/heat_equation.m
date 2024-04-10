function error=heat_equation(N,T)
% A program to compute and plot the solution to
% the 2-D heat equation on the unit square.
%    u_t=Laplacian u + f on \Omega
%      u=g               on the boundary of \Omega
%    u(x,y,0)=u_0(x,y)
% using the backward Euler method.
%-----------------------------------------------------------------

% Sample run (remember to preserve cfl condition: N^2 < T):
% close all; heat_equation(20,401);

close all; 

%----------------------------Structures------------------------------

% Number of grid points on a side is N.
% Number of time steps is T.  

if (nargin == 0)
    close all;
N = 40;
T = N^2 +1;
end

% Running time (used for shorter runs).
T_run = 100*T;%floor(T/5);

% Variable space.
x=linspace(0,1,N);
y=linspace(0,1,N);
[X,Y] = meshgrid(x,y);

% Step sizes.
h=1/N;
Delta_t=1/T;

lambda=Delta_t/h^2;

% Initialize error vector.
e=zeros(1,T_run);                      

%% ------------------------- Initial Data ---------------------------------

%u=u_ex(X,Y,0);     % Initial condition given by the function below.
u = 2*rand(N,N)-1;     % Random initial condition.                 

u=reshape(u,N^2,1); 

%% Boundary Conditions
% g_bot=@(x) 0;
% g_top=@(x) 0;
% g_left=@(y) 0;
% g_right=@(y) 0;

g_bot=@(x) -sin(8*pi*x);
g_top=@(x) sin(2*pi*x);
g_left=@(y) sin(2*pi*y);
g_right=@(y) -sin(2*pi*y);

%% Forcing (This can also use the forcing defined below).
f=@(x,y,t) 0*sin(2*pi*x).*sin(2*pi*y);

% We use the parabolic maximum principle to determine the plot range.
f_max=max(f(x,y,0));
f_min=min(f(x,y,0));
u_max=max([1,f_max,g_bot(x),g_top(x),g_left(y),g_right(y)]);
u_min=min([-1,f_min,g_bot(x),g_top(x),g_left(y),g_right(y)]);

% Set up the matrix.
A=speye(N^2)+lambda*delsq(numgrid('S',N+2));

%% Main loop.  Runs through time.

for k=1:T_run 
    %% Reset boundary data.
%     u(1:N)            = u_ex(x(1),y   ,t); % bottom
%     u((1:N) +N*(N-1)) = u_ex(x(N),y   ,t); % top
%     u(1+N*((1:N)-1))  = u_ex(x   ,y(1),t); % left
%     u(N+N*((1:N)-1))  = u_ex(x   ,y(N),t); % right

    for i=1:N
        u(i,:)=g_bot(x(i));
        u(i+N*(N-1),:)=g_top(x(i));
    end
    for j=1:N
        u(1+N*(j-1),:)=g_left(y(j));
        u(N+N*(j-1),:)=g_right(y(j));
    end
    
    %% Plot the solution.
    surf(X,Y,reshape(u,N,N));
    shading interp;
    colormap('copper');
    axis([0,1,0,1,u_min,u_max]);
    pause(0.1);
    drawnow;
    
    %% Update.
    
    % Update time.
    t=(k-1)*Delta_t;
    
    % Update forcing.   
    force=reshape(f(X,Y,t),N^2,1);
    
    % Main calculation: Update the solution.
    u=A\(u+Delta_t*force);
        
    % Record error at current time step.
    e(k)=max(max(u-reshape(u_ex(X,Y,t),N^2,1)));
end
%error_max=max(e);
error_final=e(T_run);
error=error_final;

end

% ------------------- End main function -----------------------------------

% ------------------- Exact functions (May not be needed.) ----------------

% Forcing function f.
% function z=f(x,y,t)
%     z = exp(-25*(x-t+0.5).^2-25*(y-t+0.5).^2).*(...
%     +(20*t-10)*exp(-100*(t-0.5).^2)...
%     +(1-exp(-100*(t-0.5)^2))*(...
%     10+0.1*(50*x-100*t+50+50*y-(-50*x+50*t-25).^2-(-50*y+50*t-25).^2)...
%     ));
% end

% Exact solution.
function z=u_ex(x,y,t)
    z = (0.1*(1-exp(-100*(t-0.5).^2)))*...
         exp(-25*((x-t+0.5).^2+(y-t+0.5).^2));
end



          
          
          
          
          
          


%
