% An implementation of Euler's method to solve the ODE problem
%    y' = 10 - y
%    y(0) = y_initial

% Input variables.
y_initial = 2;

t_initial = 0;
t_final = 10;
number_steps =5; % <--- Change this to about 5 to see instability in Forward Euler.

% initialize vectors to hold the solution.
t = zeros(1,number_steps);   % Time
yf = zeros(1,number_steps);  % Forward Euler solution
yb = zeros(1,number_steps);  % Backward Euler solution

% Initialize variables.
Delta_t = (t_final - t_initial)/number_steps;
t(1) = t_initial;
yf(1) = y_initial;
yb(1) = y_initial;

% Run the main loop.
for i = 1:number_steps
    t(i+1) = t(i) + Delta_t;
    % The next line is the only place where the equation appears:
    % Forward Euler: 
    yf(i+1) = yf(i) + Delta_t*(10 - yf(i));
    % Backward Euler:
    yb(i+1) = (yb(i)+10*Delta_t)/(1+Delta_t);
end

% Plot the forward solution in red.
plot(t,yf,'r-o');
hold on; 

% Plot the backward solution in black.
plot(t,yb,'k-*');


% Plot the ode45 ("exact") solution in blue.
[t_ode45,y_ode45] = ode45(@(tt,yy) 10 - yy, linspace(0,t_final,1000),y_initial);
plot(t_ode45,y_ode45(:,1),'b-');


% Plot the direction field.
[T,Y] = meshgrid(0:t_final,0:20);
S = 10 - Y;
quiver(T,Y,ones(size(S)), S);
axis tight;

% Make a legend.
legend('Forward Euler','Backward Euler','ode45 Solution');
