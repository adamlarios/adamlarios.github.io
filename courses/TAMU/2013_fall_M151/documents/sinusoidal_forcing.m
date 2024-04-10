close all; clear all;
t = linspace(0,60,1000);
omega = 0.5;
% omega = 1.2;
% omega = 1.4;

subplot(1,2,1)

yh = (-cos(sqrt(2)*t))/(2-omega^2);
hold on;
yp = ( cos(omega  *t))/(2-omega^2);
plot(t,yh,'b');
plot(t,yp,'r');
legend('y_h','y_p','location','southeast');

subplot(1,2,2)
y = (-cos(sqrt(2)*t) + cos(omega*t))/(2-omega^2);
plot(t,y);
title('Sum')