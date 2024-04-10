% Examine the end behavior of the logistic map
%    P_(n+1) = r*P(n)*(1-P(n))
% as it depends on r, using a range of seed values.

clear all; close all

res = 1200; % resolution
r_vals=linspace(2,5,res);
P= zeros(1,res);

hold on; 
for seed = 0.1:0.01:0.9
% for seed = 0.877:0.001:0.880
     i=1;
      for r = r_vals
        P(i) = seed;
        for n = 1:250
          P(i) = r*P(i)*(1-P(i));
        end
 %       scatter(r,P(i),1)
         i = i+1;
     end
      scatter(r_vals,P,1)
       pause(0.1);
end
