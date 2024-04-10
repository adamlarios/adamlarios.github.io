% GMRES Demo
clear all
close all
clc
scrnsz = get(0, 'Screensize');
m = 200;
% Clustered eigenvalues
A = 2*eye(m) + 0.5*randn(m)/sqrt(m);
b = ones(m,1);
for iter = 1 : 30
    [x, flag, relres] = gmres(A,b,[],1e-8,iter);
    r(iter) = relres;
end
figure('Position', [5 10 scrnsz(3)-5 scrnsz(4)-60])
semilogy(r,'g+','Linewidth',2)
xlabel('Number of GMRES iterations','Fontsize',14);
ylabel('Relative residual','Fontsize',14);
title('Convergence of GMRES Algorithm (accuracy 1e-8)','Fontsize',18);
legend('A=2I+0.5*randn(200)/sqrt(200)',3)
drawnow;
% Eigenvalues spread out
for k = 0 : m-1
    theta = k*pi/(m-1);
    d(k+1) = -2 + 2*sin(theta) + sqrt(-1)*cos(theta);
end
B = A + diag(d);
for iter = 1 : 30
    [x, flag, relres] = gmres(B,b,[],1e-8,iter);
    r(iter) = relres;
end
hold on;
semilogy(r,'ro','Linewidth',2)
legend('A=2I+0.5*randn(200)/sqrt(200)','B=A+diag(-2 + 2*sin(\theta) + i*cos(\theta))',3)
drawnow;
% Random matrix (eigenvalues loosley clustered around zero)
C = randn(m)/sqrt(m);
for iter = 1 : 30
    [x, flag, relres] = gmres(C,b,[],1e-8,iter);
    r(iter) = relres;
end
semilogy(r,'bx','Linewidth',2)
legend('A=2I+0.5*randn(200)/sqrt(200)','B=A+diag(-2 + 2*sin(\theta) + i*cos(\theta))','C=randn(200)/sqrt(200)',3)
drawnow;
% Random symmetric positive definite
D = C'*C;
for iter = 1 : 30
    [x, flag, relres] = gmres(D,b,[],1e-8,iter);
    r(iter) = relres;
end
semilogy(r,'m*','Linewidth',2)
legend('A=2I+0.5*randn(200)/sqrt(200)','B=A+diag(-2 + 2*sin(\theta) + i*cos(\theta))','C=randn(200)/sqrt(200)','D=C^TC (symmetric positive definite)',3)
drawnow;
% Random matrix (eigenvalues more closely clustered, but still around zero)
E = 0.5*C;
for iter = 1 : 30
    [x, flag, relres] = gmres(E,b,[],1e-8,iter);
    r(iter) = relres;
end
semilogy(r,'cs','Linewidth',2)
legend('A=2I+0.5*randn(200)/sqrt(200)','B=A+diag(-2 + 2*sin(\theta) + i*cos(\theta))','C=randn(200)/sqrt(200)','D=C^TC (symmetric positive definite)','E=0.5*C',3)
drawnow;
hold off;
% Find eigenvalues
eA = eig(A);
eB = eig(B);
eC = eig(C);
eD = eig(D);
eE = eig(E);
pause
figure('Position', [5 10 scrnsz(3)-5 scrnsz(4)-60])
plot(real(eA),imag(eA),'g+',real(eB),imag(eB),'ro',real(eC),imag(eC),'bx',real(eD),imag(eD),'m*',real(eE),imag(eE),'cs','Linewidth',2)
title('Eigenvalue Distributions in the Complex Plane','Fontsize',18);
xlabel('Re(\lambda)','Fontsize',14);
ylabel('Im(\lambda)','Fontsize',14);
legend('A=2I+0.5*randn(200)/sqrt(200)','B=A+diag(-2 + 2*sin(\theta) + i*cos(\theta))','C=randn(200)/sqrt(200)','D=C^TC (symmetric positive definite)','E=0.5*C')
kA = cond(A);
kB = cond(B);
kC = cond(C);
kD = cond(D);
kE = cond(E);
pause
disp(sprintf('Condition numbers:'))
disp(sprintf('cond(A) = %e', kA))
disp(sprintf('cond(B) = %e', kB))
disp(sprintf('cond(C) = %e', kC))
disp(sprintf('cond(D) = %e', kD))
disp(sprintf('cond(E) = %e', kE))
