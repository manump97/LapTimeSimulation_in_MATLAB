% Rolling Resistance Tire Pressure Model %
close all;clear all;%clc;

p = 3;
vx = 120;
Fz = [0:500:15000];

p0 = 4.5; % [bar]
Fz0 = 15000;
alpha = 0.4; % [-]
beta = 0.9; % [-]
c0 = 0.03; % [-]
c1 = 6e-4; % [s/m]
c2 = 0; % [(s/m)^2]

p_index = (p0-p).^(alpha);
Fz_index = (Fz0-Fz).^(beta-1);
vx_index = c0+c1.*vx+c2.*vx.^2;

Crr = p_index.*Fz_index.*vx_index;
Rr = Crr.*Fz;

subplot(2,1,1)
plot(Fz,Crr);
subplot(2,1,2)
plot(Fz,Rr);

