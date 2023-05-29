% COMPLEX PACEJKA MAGIC FORMULA TYRE MODEL
clear all;
% http://white-smoke.wikifoundry.com/page/Tyre+curve+fitting+and+validation

Fz_range = [2:0.5:4]; % Normal Force per tyre [kN]
slip_range = [-100:2:100]; % Slip ratio [%]
slip_angle = [-25:0.2:25]; % Slip angle [deg]
cmb = 2; % Camber [deg]

% LONGITUDINAL
% Independent parameters
b0 = 1.65;
b2 = 1200;
b4 = 350;
b8 = -10;
b10 = 0;
b11 = 0;
b13 = 0.5;
% Dependent parameters
b1 = 20;
b3 = 10;
b5 = -0.5;
b6 = -0.05;
b7 = 0;
b9 = 0;
b12 = 0;

% C = b0;
% D = Fz*(b1*Fz+b2);
% BCD = (b3*Fz^2+b4*Fz)*exp(-b5*Fz);
% B = BCD/(C*D);
% H = b9*Fz+b10;
% V = b11*Fz+b12;
% E = (b6*Fz^2+b7*Fz+b8)*(1-b13*sign(slip+H));
% Bx = B*(slip+H);

% Fx = D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+V;
i = 1;
j = 1;
while i <= length(slip_range)
    slip = slip_range(i);
    while j <= length(Fz_range)
        Fz = Fz_range(j);
        
        C = b0;
        D = Fz*(b1*Fz+b2);
        BCD = (b3*Fz^2+b4*Fz)*exp(-b5*Fz);
        B = BCD/(C*D);
        H = b9*Fz+b10;
        V = b11*Fz+b12;
        E = (b6*Fz^2+b7*Fz+b8)*(1-b13*sign(slip+H));
        Bx = B*(slip+H);
        
        Fx(i,j) = D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+V;
        j = j+1;
    end
    j = 1;
    i = i+1;
end


% LATERAL
% Independent parameters
a0 = 1.3;
a2 = 250;
a3 = 2700;
a4 = 25;
a7 = -10;
a9 = 0;
a11 = 0;
a17 = 0;
% Dependent parameters
a1 = 20;
a6 = 0;
a8 = -0.5;
a12 = -5;
% Camber dependent-parameters
a5 = -0.05;
a10 = 0.05;
a13 = 5;
a14 = 10;
a15 = -0.005;
a16 = -0.05;

i = 1;
j = 1;
while i <= length(slip_angle)
    slip = slip_angle(i);
    while j <= length(Fz_range)
        Fz = Fz_range(j);
        
        C = a0;
        D = Fz*(a1*Fz+a2)*(2-a15*cmb^2);
        BCD = a3*sin(atan(Fz/a4)*2)*(1-a5*abs(cmb));
        B = BCD/(C*D);
        H = a8*Fz+a9+a10*cmb;
        V = a11*Fz+a12+(a13*Fz+a14)*cmb*Fz;
        E = (a6*Fz+a7)*(1-(a16*cmb+a17)*sign(slip+H));
        Bx = B*(slip+H);
        
        Fy(i,j) = D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+V;
        j = j+1;
    end
    j = 1;
    i = i+1;
end


% GRAPHS
figure('Name','Tyre.Complex MF','NumberTitle','off')
subplot(2,1,1)
i = 1;
while i <= length(Fx(1,:))
    plot(slip_range,Fx(:,i));hold on;
    i = i+1;
end
grid minor
title('Complex MF Longitudinal Force per tyre')
legend('2000 N','2500 N','3000 N','3500 N','4000 N','location','southeast')
xlabel('Slip ratio [%]');ylabel('Longitudinal Force [N]')

subplot(2,1,2)
i = 1;
while i <= length(Fy(1,:))
    plot(slip_angle,Fy(:,i));hold on;
    i = i+1;
end
grid minor
title('Complex MF Lateral Force per tyre')
legend('2000 N','2500 N','3000 N','3500 N','4000 N','location','southeast')
xlabel('Slip angle [deg]');ylabel('Lateral Force [N]')
