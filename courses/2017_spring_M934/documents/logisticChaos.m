% Examine the end behavior of the logistic map
%    P_(n+1) = r*P(n)*(1-P(n))
% as it depends on r, using random initial values.

% This always converges to same number:
% P = rand(1); r = 2.5; for n = 1:300; P = r*P*(1-P); end

% This always converges to one of two numbers:
% P = rand(1); r = 3.2; for n = 1:300; P = r*P*(1-P); end

% This always converges to one of four numbers:
% P = rand(1); r = 3.4; for n = 1:300; P = r*P*(1-P); end

% What is going on?

clear all; close all

r = 2:0.001:4; % Let's just test a bunch of r values.
n_runs = length(r);

P_vals = zeros(1,n_runs);
for i = 1:n_runs
    P = rand; % Just choose a random initial condition between 0 and 1.
    for k = 1:300
        P = r(i)*P*(1-P);
    end
    P_vals(i) = P;
end

scatter(r,P_vals,1);
xlabel('r');
ylabel('lim P');

