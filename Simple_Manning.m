clc
clear
clf

% Solves for normal depth using Manning's equation via newton's method. 
% --------------------------- Created by-----------------------------------
% Logan Bayer, BS 
% Compound Inundation Team for Resilient Applications
% University of Georgia
% Fall 2023

% Channel Parameters
b = 10; % m
z = 4; % side slope
Q = 5; % cms
n = 0.025; % mannings roughness
Phi = 1; % phi = 1 if working in meters and 1.49 if working in feet
So = 0.02;
Fb = 0.2;

% Iterate to find a solution for water depth using Newton's method
y = 10;
LHS = 1;
RHS = 0;
iter = 0;
maxi = 100000;
tol = 1e-2;
yInc = 1e-4;
while abs(LHS-RHS) > tol
    A = b*y + z*(y^2);
    R = A/(b + 2*y*sqrt(z^2+1));
    LHS = A*R^(2/3);
    RHS = (Q*n)/(Phi*sqrt(So));
    y = y - yInc;
    iter = iter + 1;

    if y < 0
        error('y is negative')
    end

    if iter > maxi
        error('maximum iteration reached without convergence')
    end
end

% After convergence, display the solution and plot the channel cross section:
fprintf('y = %d m \n ',y);
H = y*(1+Fb);

%% Figure
a = b + 2*z*H;  % top side
%%Frame vertices
a1 = [0 0] ;
a2 = [b 0] ;
a3 = [0.5*(b-a)+a H] ;
a4 = [0.5*(b-a) H] ;  
coor = [a1 ; a2; a3; a4] ;  
patch(coor(:,1), coor(:,2),'white')

a = b + 2*z*y;  % top side
%% Frame vertices
a3 = [0.5*(b-a)+a y] ;
a4 = [0.5*(b-a) y] ;  
coor = [a1 ; a2; a3; a4] ;  
patch(coor(:,1), coor(:,2),'cyan')

title('Channel Cross Section using normal depth')