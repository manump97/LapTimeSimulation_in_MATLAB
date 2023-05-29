% Monte carlo equation Tyre_Mode %
clear all;


Fz_range = [2:0.5:4]; % Normal Force per tyre [kN]
slip_range = [-100:2:100]; % Slip ratio [%]
slip_angle = [-25:0.2:25]; % Slip angle [deg]
cmb = 2; % Camber [deg]

% LONGITUDINAL
% Independent parameters
b0 = 1.65;
b2 = 1490;
b4 = 276;
b8 = 1.2;
b10 = -0.176;
b11 = 0;
% Dependent parameters
b1 = -9.46;
b3 = 130;
b5 = 0.0886;
b6 = 0.000402;
b7 = -0.0615;
b9 = 0.03;
b12 = 0;

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
        E = (b6*Fz^2+b7*Fz+b8);
        Bx = B*(slip+H);
        
        Fx(i,j) = D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+V;
        j = j+1;
    end
    j = 1;
    i = i+1;
end

% LATERAL
% Independent parameters
a0 = 1.3; % 1.551
a2 = 1262;
a3 = 2683;
a4 = 12.8;
a7 = 0.057;
a9 = -0.012;
a11 = -14;
% a17 = 0;
% Dependent parameters
a1 = -42;
a6 = -0.11;
a8 = -0.019;
a12 = 4.6;
% Camber dependent-parameters
a5 = 0.014;
a10 = -0.082;
a13 = 0.35;
% a14 = 10;
% a15 = -0.005;
% a16 = -0.05;

i = 1;
j = 1;
while i <= length(slip_angle)
    slip = slip_angle(i);
    while j <= length(Fz_range)
        Fz = Fz_range(j);
        
        C = a0;
        D = Fz*(a1*Fz+a2);
        BCD = a3*sin(atan(Fz/a4)*2)*(1-a5*abs(cmb));
        B = BCD/(C*D);
        H = a8*cmb+a9*Fz+a10;
        V = a11*Fz*cmb+a12*Fz+a13;
        E = (a6*Fz+a7);
        Bx = B*(slip+H);
        
        Fy(i,j) = D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+V;
        j = j+1;
    end
    j = 1;
    i = i+1;
end

% ALIGNING MOMENT
% Aligning coeff
c0 = 2.4;
c1 = -3.1;
c2 = -5.21;
c3 = -1.35;
c4 = -5.4;
c5 = 0;
c6 = 0;
c7 = 0.037;
c8 = -0.284;
c9 = -1.86;
c10 = -0.052;
c11 = 0.029;
c12 = -0.0042;
c13 = -0.14;
c14 = 0.04;
c15 = -0.884;
c16 = -0.19;
c17 = 0.4;


i = 1;
j = 1;
while i <= length(slip_angle)
    slip = slip_angle(i);
    while j <= length(Fz_range)
        Fz = Fz_range(j);
        
        C = c0;
        D = Fz*(c1*Fz+c2);
        BCD = (c3*Fz^2+c4^Fz)*(1-c6*abs(cmb))*exp(-c5*Fz);
        B = BCD/(C*D);
        H = c11*cmb+c12*Fz+a13;
        V = (c14*Fz^2+c15*Fz)*cmb+c16*Fz+c17;
        E = (c7*Fz^2+c8*Fz+c9)*(1-c10*abs(cmb));
        Bx = B*(slip+H);
        
        Mz(i,j) = D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+V;
        j = j+1;
    end
    j = 1;
    i = i+1;
end


% GRAPHS
figure('Name','Tyre.P2002 Montecarlo','NumberTitle','off')
subplot(3,1,1)
i = 1;
while i <= length(Fx(1,:))
    plot(slip_range,Fx(:,i));hold on;
    i = i+1;
end
grid minor
title('P2002. Montecarlo Fx-SR MF')
legend('2000 N','2500 N','3000 N','3500 N','4000 N','location','southeast')
xlabel('Slip ratio [%]');ylabel('Longitudinal Force [N]')

subplot(3,1,2)
i = 1;
while i <= length(Fy(1,:))
    plot(slip_angle,Fy(:,i));hold on;
    i = i+1;
end
grid minor
title('P2002. Montecarlo Fy-SA MF')
legend('2000 N','2500 N','3000 N','3500 N','4000 N','location','southeast')
xlabel('Slip angle [deg]');ylabel('Lateral Force [N]')

subplot(3,1,3)
i = 1;
while i <= length(Fy(1,:))
    plot(slip_angle,Mz(:,i));hold on;
    i = i+1;
end
grid minor
title('P2002. Montecarlo Mz-SA MF')
legend('2000 N','2500 N','3000 N','3500 N','4000 N','location','southeast')
xlabel('Slip angle [deg]');ylabel('Aligning Torque [Nm]')

