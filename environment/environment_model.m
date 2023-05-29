% ----- % Environment Model % ----- %
clear environment;%clc;

env.g = 9.81; %[m/s2] Gravity
env.T0 = 20; %[ºC] Origin Atmospheric Temperature
env.P0 = 101325; %[Pa] Origin Atmospheric Pressure
env.d0 = 1.225; %[kg/m3] Origin Air Density
env.Tr = 25; %[ºC] Relative Atmospheric Temperature
env.Pr = 101325; %[Pa] Relative Atmospheric Pressure
env.R = 287.058; % [J/Kg·K] Dry air constant

env.d = env.Pr/((env.Tr+273)*env.R);