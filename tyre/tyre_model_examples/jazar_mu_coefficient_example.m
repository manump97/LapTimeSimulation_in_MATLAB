% Mu_coefficient equation % 
close all;clear all;%clc;
% K = 0.8 % For Radial Tires
K = 1; % For non-Radial Tires
vx = 120;
Fz = 1;
p = 101235;

% Jazar equation
mu = K/1000*(5.1+(5.5*10^5+90*Fz)/p+((1100+0.0388*Fz)*vx^2)/p);