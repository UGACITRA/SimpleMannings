clc
clear
clf
% Plots specific energy
% --------------------------- Created by-----------------------------------
% Logan Bayer, BS 
% Compound Inundation Team for Resilient Applications
% University of Georgia
% Fall 2023

% Channel parameters
b = 10; % m
Q = 30; % cms
dy = 0.01; % m
y_max = 3.4; % m
i_max = 1 + y_max/dy;
g = 9.81;
alpha = 1; % 1 if prismatic channel

y = zeros(i_max,1);
s_energy = zeros(i_max,1);
V = zeros(i_max,1);

% Set up domain
for i = 2:i_max
    y(i) = y(i-1)+dy; 
end

% Find Critical depth
yc = (Q^2/(g*b^2))^(1/3);

% Find the specific energy for each y
for i = 1:i_max
    A = b*y(i); 
    V(i) = Q/A;
    s_energy(i) = y(i) + alpha*(V(i)^2/(2*g));
end

plot(s_energy,y);
hold on
y_c = zeros(i_max,1);
y_c(:) = yc;
Ac = b*yc;
Vc = Q/Ac;
s_energy_c = zeros(i_max,1);
s_energy_c(:) = yc + alpha*(Vc^2/(2*g));
plot(s_energy,y_c);
ylabel('Water Depth (m)')
xlabel('Specific Energy')
xlim([0 10])
legend('y','y_c')