function cc2plot(a,b,c,y0,yp0,t0,tend,g)
% cc2plot(a,b,c,y0,yp0,t0,tend,g) -- Plot the solution to the second
% order linear constant coefficient ODE ay'' +by' + cy =g(t), with
% y(t0)=y0, y'(t0)=yp0 from t=t0 upto t=tend. 
% (The function g is optional, and is '0' by default)
%
% Homogeneous Examples:
%
% cc2plot(1,1,-2,1,1,0,10)     % real, distinct, positive
% cc2plot(1,4,3,1,1,0,10)      % real, distinct, negative
% cc2plot(1,3,0,1,1,0,10)      % zero and negative roots
%
% cc2plot(16,-8,145,-2,1,0,10) % unstable oscillation
% cc2plot(1,0,9,1,1,0,10)      % stable oscillation (pure imaginary)
% cc2plot(1,1,1,1,1,0,10)      % asymptocially stable oscillation
%
% cc2plot(1,4,4,1,1,0,10)      % repeated root negative
% cc2plot(1,-2,1,1,1,0,3)      % repeated root positive, y(0)=1
% cc2plot(1,-2,1,2,1,0,3)      % same as previous, but y(0)=2
% cc2plot(1,-2,1,2,2,0,3)      % same as previous, but y'(0)=2
%
% Non-homogeneous Examples:
%
% cc2plot(1,3,0,1,1,0,10,'sin(5*t)')  % zero and negative roots
% cc2plot(1,0,9,1,1,0,10,'cos(3*t)')  % stable oscillation with resonance
% cc2plot(1,4,4,1,1,0,10,'t')         % repeated root negative with
                                      %   linear forcing
  
  if nargin < 8
    gs='0';
    g=@(t) 0*t;
  else
      gs=g; 
      g=inline(g);
  end
  
  set(0,'DefaultAxesLineWidth',2);
  set(0,'DefaultLineLineWidth',2);
  get(0,'Default');
  options = odeset('OutputFcn',@odeplot,'OutputSel',1);
  ode45(@(t,y) ode(t,y,a,b,c,g) ,[t0 tend],[y0 yp0],options);
  set(gca,'FontSize',18)
  xlabel('t','FontSize',18)
  ylabel('y','FontSize',18)
  r=roots([a b c]);
  tol=1e-3;
  r(1)=r(1)-imag(r(1))*(abs(imag(r(1)))<tol)*sqrt(-1);
  r(2)=r(2)-imag(r(2))*(abs(imag(r(2)))<tol)*sqrt(-1);
  r1=num2str(r(1)); r2=num2str(r(2));
  title(sprintf('%g y" + %g y'' + %g y = %s\nroots=%s,%s,y(0)=%g,y''(0)=%g',...
		a,b,c,gs,r1,r2,y0,yp0),'FontSize',18);
  
function dydt=ode(t,y,a,b,c,g)

  gv=feval(g,t);
  dydt = [y(2); -b*y(2)/a-c*y(1)/a+gv/a];
