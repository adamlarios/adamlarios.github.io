% Multi-dimensional Runge-Kutta-4 with N gridpoints.
% Author: Adam Larios,  Date: 2012-11-21
function [x t]= rk4_ndim(f, t0, tf, x0, N)

dimension = length(x0); % Read the dimension from the size of the initial condition.
x = zeros(dimension,N);  x(:,1) = x0;
t = linspace(t0,tf,N);
h = (tf-t0)/(N-1); % step size (N grid-points means N-1 steps)

for i = 1:(N-1) % RK4 time stepping
    k1 = f(t(i),         x(:,i)); % We use Matlab's vector notation here.
    k2 = f(t(i) + 0.5*h, x(:,i) + 0.5*k1);
    k3 = f(t(i) + 0.5*h, x(:,i) + 0.5*k2);
    k4 = f(t(i) + h,     x(:,i) +     k3);   
    x(:,i+1) = x(:,i) + h*(k1 + 2*k2 + 2*k3 + k4)/6;
end
end

% Examples:
%
%% 1D: Logistic Population growth
% r = 0.3; K = 50;
% logistic = @(t,P) r*P*(1-P/K);
% [P t]=rk4_ndim(logistic,0,60,2,1000)
% plot(t,P);
%
%% 2D: Lotka-Volterra (Predator-Prey)
% % Instead of x, y variables, we use x(1), x(2) variables.
% % x(1) represents rabbits, x(2) represents foxes.
% alpha = 1; beta = 1; delta = 1; gamma = 1;
% LV = @(t,x) [alpha*x(1)-beta*x(1)*x(2);-gamma*x(2)+delta*x(1)*x(2)];
% [X t]=rk4_ndim(LV,0,6.7,[1;2],1000);
% plot(X(1,:),X(2,:)); 
% plot(t,X(2,:));  % Make sure to add title and labels to your plots.
%
%% 3D: Lorenz attractor (Chaotic)
% beta = 8/3;sigma = 10;rho = 28;
% lorenz = @(t,x)[sigma*(x(2)-x(1));x(1).*(rho-x(3))-x(2);x(1).*x(2)-beta*x(3)];
% [X t]=rk4_ndim(lorenz,0,30,[0;1;1],3000);
% plot3(X(1,:),X(2,:),X(3,:));
%
%% 4D: Double Pendulum (Chaotic)
% % x(1),x(2) = position of second mass
% % x(3),x(4) = generalized momentum components
% L1=2; L2=0.5; m1=1; m2=1; g = 9.81;
% DPendulum = @(t,x)[(L2*x(3)-L1*x(4)*cos(x(1)-x(2)))/(L1^2*L2*(m1+m2*(sin(x(1)-x(2)))^2));...
%     (L1*(m1+m2)*x(4)-L2*m2*x(3)*cos(x(1)-x(2)))/(L1*L2^2*m2*(m1+m2*(sin(x(1)-x(2)))^2));...
%     -(m1+m2)*g*L1*sin(x(1))-x(3)*x(4)*sin(x(1)-x(2))/(L1*L2*(m1+m2*(sin(x(1)-x(2)))^2))+...
%     (L2^2*m2*x(3)^2+L1^2*(m1+m2)*x(4)^2-L1*L2*m2*x(3)*x(4)*cos(x(1)-x(2)))*...
%     (sin(2*x(1)-2*x(2)))/(L1*L2*(m1+m2*(sin(x(1)-x(2)))^2))^2/2;...
%     m2*g*L2*sin(x(2))+x(3)*x(4)*sin(x(1)-x(2))/(L1*L2*(m1+m2*(sin(x(1)-x(2)))^2))-...
%     (L2^2*m2*x(3)^2+L1^2*(m1+m2)*x(4)^2-L1*L2*m2*x(3)*x(4)*cos(x(1)-x(2)))*...
%     (sin(2*x(1)-2*x(2)))/(L1*L2*(m1+m2*(sin(x(1)-x(2)))^2))^2/2];
% [X t]=rk4_ndim(DPendulum,0,10,[1;2;0;0],500);
% plot(L1*sin(X(1,:))+L2*sin(X(2,:)),-L1*cos(X(1,:))-L2*cos(X(2,:)));
