%% A program to compute the mandelbrot set.  
%  For a fixed complex number c, we iterate as follows:
%      z = 0
%      z = z.^2 + c
%  The Mandelbrot set is the set of c values for which 
%  the orbit of the seed value z = 0 is bounded.

%% Set the resolution and number of iterations.
close all; clear all;
total_iter = 20;
N=1000;

%% Fully Zoomed out:
x_center = -0.6;
y_center = 0.0;
x_length = 1.5;
y_length = 1.5;

%% Zoomed in at a particular location:
% x_center = -0.9090;
% y_center = 0.2940;
% x_length = 0.1;
% y_length = 0.1;

%% Set up a grid of complex numbers, which will be used to
%  iterate over many different choices of c at the same time.
x = linspace(x_center - x_length,x_center + x_length,N);
y = linspace(y_center - y_length,y_center + y_length,N);
[X,Y]=meshgrid(x,y);
c = X + i*Y;

%% The iteration is initially seeded with value 0.
%  Of course, we want one z for each c.
z = zeros(size(c));

%% The idea is to iterate, and color points by how large
%  they get under iteration.  We measure the size of a
%  complex number by using abs(c), which is just its distance 
%  from the origin.
for k = 1:total_iter
    % Here is the main computation.
    z = z.^2+c;
end  
    % To get sharper color definition, we "bend" the abs(z) values
    % before plotting them.  There are many different ways 
    % to do this.
%     w = log(abs(z));
     w = exp(-abs(z)); 
    
    % Plot using colormap, for example.
%     colormap autumn(256);
    pcolor(w);
    shading flat;
    axis('square','equal','off');
    
    
    % We are only interested in the final picture, 
    % but pausing the iteration gives some nice pictures.
%     pause(0.2);
% end


%   Optional color maps.
%     hsv        - Hue-saturation-value color map.
%     hot        - Black-red-yellow-white color map.
%     gray       - Linear gray-scale color map.
%     bone       - Gray-scale with tinge of blue color map.
%     copper     - Linear copper-tone color map.
%     pink       - Pastel shades of pink color map.
%     white      - All white color map.
%     flag       - Alternating red, white, blue, and black color map.
%     lines      - Color map with the line colors.
%     colorcube  - Enhanced color-cube color map.
%     vga        - Windows colormap for 16 colors.
%     jet        - Variant of HSV.
%     prism      - Prism color map.
%     cool       - Shades of cyan and magenta color map.
%     autumn     - Shades of red and yellow color map.
%     spring     - Shades of magenta and yellow color map.
%     winter     - Shades of blue and green color map.
%     summer     - Shades of green and yellow color map.

            
        