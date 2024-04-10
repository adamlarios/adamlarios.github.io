% A program to solve the Helmholtz equation
%   E_xx + E_yy + (k^2/n^2)*E = f
% in a square room with a separating wall and a source ("wifi router") in one corner.
% Numerical method is a centered finite difference scheme.
%
% Written in 2015 by Adam Larios.  Inspired by a post at:
%   http://jasmcole.com/2014/08/25/helmhurts/
% Some code inspired by the "delsqdemo" in Matlab

close all; clear all;

N = 200; % Use an NxN square grid.
L = 5; % Assume a 5 meter by 5 meter room.
dx = L/(N-1);

grid = numgrid('S',N);
NZ = sum(grid(:)>0); % number of non-zero points.

signal = spalloc(NZ,1,10);
signal([1 2 N-1 N]) = 1; % Represent the wireless router as four pizels in the corner.
% Try setting the signal to zero everywhere to see the effect it has.

k = 2*pi/0.12; % Wavelength of 2.5 GHz signal is ~12cm
n = 1; % Refractive index of air.
lambda = (k/n)^2*ones(NZ,1);

wallThickness = round(0.15/dx); % Assume 15cm wall.
doorLength = 0; % Assume no door.
% doorLength = round(0.75/dx); % Assume 75cm door. (Try this too!)

% Fins indices of where the wall is.  
% The wall looks a little wonky for some reasons, but it is good enough.
wallExtent = (ceil((N-2)/2)*(N-2)+1):(ceil((N-2)/2)*(N-2)+N-2-doorLength);
NwallExtent = length(wallExtent);
wallIndex = zeros(1,NwallExtent*wallThickness);
for ii = 0:(wallThickness-1)
    wallIndex((1 + ii*NwallExtent):(NwallExtent + ii*NwallExtent)) = wallExtent + ii*(N-2);
end
lambda(wallIndex) = (k/(4.75))^2; % Adjust for different wall permeativity using refractive index of concrete. 

% Set up Helmholtz matrix using Matlab's sparse matrix tools
H = sparse(delsq(grid))/dx^2 - spdiags(lambda,0,NZ,NZ);
subplot(1,2,1); spy(H); title(sprintf('Non-zero entries of the %d x %d matrix.',size(H)))

% Solve for electromagnetic strength.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
% Insert you linear solver here to solve HE = f for the unknown E  %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %

% Assign the values back to the grid.
Eplot = zeros(size(grid));
Eplot(grid>0) = full(E(grid(grid>0)));
Eplot(wallIndex)=0; % Set wall index entries to zero to see the wall easier.

subplot(1,2,2);
surf(abs(Eplot));
shading interp;
%shading flat;
light('color',[1 1 1]);
lighting phong;
colorbar;
axis tight square;
view(2);
title('Signal Strength in room');