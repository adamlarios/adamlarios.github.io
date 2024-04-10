cc2plot(1,-3,2,1,1,0,10) 
xlabel 'real, distinct, one positive, to inf'
pause

cc2plot(1,-3,2,1,-2,0,10) 
xlabel 'real, distinct, one positive, to -inf'
pause

cc2plot(1,3,2,1,1,0,10) 
xlabel 'real, distinct, both negative'
pause

cc2plot(1,3,0,1,1,0,10) 
xlabel 'real, distinct, negative-and-zero'
pause

cc2plot(16,-8,145,-2,1,0,10) 
xlabel 'complex, unstable oscillation'
pause

cc2plot(1,0,9,1,1,0,10) 
xlabel 'complex, stable oscillation (pure imaginary)'
pause

cc2plot(2,1,4,1,1,0,10)
xlabel 'complex, asymptocially stable oscillation'
pause

cc2plot(1,4,4,1,1,0,10)
xlabel 'repeated root negative'
pause

cc2plot(1,-2,1,1,1,0,3)
xlabel 'repeated root positive, y(0)=1'
pause

cc2plot(1,-2,1,2,1,0,3)
xlabel 'same as previous, but y(0)=2'
pause

cc2plot(1,-2,1,2,2,0,3)
xlabel 'same as previous, but y''(0)=2'
pause

cc2plot(1,0,0,1,1,0,10) 
xlabel 'repeated root, zero'

