%% Car Model PORSCHE911_2012 %%
clear car;%clc;

name = 'Porsche911';

% General
car.L = 2.5; %[m] Wheelbase
car.mc = 1472; %[kg] Mass car
car.md = 80; %[kg] Mass driver
    car.m = car.mc+car.md; % [kg] Total mass
car.xCG = 0.8; %[m] X Center of Gravity
car.yCG = 0; %[m] Y Center of Gravity
car.zCG = 0.9; %[m] Z Center of Gravity
car.Rg = 14; %[inch] Wheel Radius
    car.Rg = car.Rg*25.4/1000; % [m] Wheel Radius
% Suspension
car.camber = 1; %[deg] Camber
% Aerodynamics
car.xCP = 1; %[m] X Center of Pressure
car.yCP = 0; %[m] Y Center of Pressure
car.zCP = 1; %[m] Z Center of Pressure
car.Af = 2.04; %[m2] Frontal Area
car.Cl = 0.15; %[-] Lift Coefficient 
car.Clc = 0.5; %[-] Lift Coefficient in corners
car.DRS = 0; %[0,1] Drag Reduction System
car.Cd = 0.29; %[-] Drag Coefficient
car.Cddrs = 0.23; %[-] Drag Coefficient with DRS on
% Brakes
car.MbrakingF = 1250; %[Nm] Front braking momentum
car.MbrakingR = 1250; %[Nm] Rear braking momentum
car.Reg_enable = 0; %[-] Regenerative braking = 1;
% % Traction
car.traction = 'FWD'; %[-] Traction wheels (FWD,RWD,AWD)

