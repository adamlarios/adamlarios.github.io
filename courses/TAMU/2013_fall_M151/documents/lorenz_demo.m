function lorenz_demo(time)
% Usage: lorenz_demo(time)
% time=end point of time interval
%
% This function integrates the lorenz attractor
% from t=0 to t=time
  [t,x] = ode45('g',[0 time],[1;2;3]);
  disp('press any key to continue ...')
  pause
  plot3(x(:,1),x(:,2),x(:,3))
  print -deps lorenz.eps
  pause
  plot(t,x(:,1))
  pause
  plot(t,x(:,2))
  pause
  plot(t,x(:,3))
