close all; clear all;
N =100;

v = zeros(N,N);
k=1;
for a = linspace(-3,2,N)
    j=1;
    for b = linspace(-3,2,N)
        c = a + b*i;
        x = 0;
        for nn = 1:20
            x  =x^2 +c;
            if abs(x) > 2
                v(j,k) = 1;
                break
            end
        end
        j = j+1;
    end
    k = k+1;
end

spy(v)