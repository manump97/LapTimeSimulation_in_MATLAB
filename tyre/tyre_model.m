% ----- % Tyre Model % ----- %
clear tyre;%clc;

% Neumático 235/45/R18
% Pacejka MF (Monte Carlo Version)

% Pressure
tyre.p = 3; % [bar] Actual tyre pressure
% Stiffness
tyre.Kz = 220000; %[N/mm] Tyre Fz Stiffness

% Rolling resistance
tyre.p0 = 4.5; % [bar] Maximum pressure
tyre.p_exp = 0.3; % [] Pressure exponent
tyre.Fz0 = 15000; % [N] Maximum load Fz
tyre.Fz_exp = 0.85; % [] Load Fz exponent
tyre.v0 = 0.018; % [] Speed term 0
tyre.v1 = 6e-5; % [] Speed term 1
tyre.v2 = 0; % [] Speed term 2

% Lateral MF
tyre.a0 = 1.3;
tyre.a1 = -42;
tyre.a2 = 4500;
tyre.a3 = 3900;
tyre.a4 = 12.8;
tyre.a5 = 0.014;
tyre.a6 = -0.11;
tyre.a7 = 0.057;
tyre.a8 = -0.019;
tyre.a9 = -0.012;
tyre.a10 = -0.082;
tyre.a11 = -14;
tyre.a12 = 4.6;
tyre.a13 = 0.35;
% Longitudinal MF
tyre.b0 = 1.65;
tyre.b1 = -9.46;
tyre.b2 = 1490;
tyre.b3 = 130;
tyre.b4 = 276;
tyre.b5 = 0.0886;
tyre.b6 = 0.000402;
tyre.b7 = -0.0615;
tyre.b8 = 1.2;
tyre.b9 = 0.03;
tyre.b10 = -0.176;
tyre.b11 = 0;
tyre.b12 = 0;
% Aligning Moment MF
tyre.c0 = 2.3;
tyre.c1 = -3.13;
tyre.c2 = -5.21;
tyre.c3 = -1.35;
tyre.c4 = -5.4;
tyre.c5 = 0;
tyre.c6 = 0;
tyre.c7 = 0.037;
tyre.c8 = -0.284;
tyre.c9 = -1.86;
tyre.c10 = -0.052;
tyre.c11 = 0.029;
tyre.c12 = -0.0042;
tyre.c13 = -0.14;
tyre.c14 = 0.04;
tyre.c15 = -0.884;
tyre.c16 = -0.19;
tyre.c17 = 0.4;

% Magic Formula
% Y = D*sin(C*atan(Sh-E*(Sh-atan(Sh))))+Sv;

% Equations for Longitudinal
% C = b0;
% D = Fz*(b1*Fz+b2);
% BCD = (b3*Fz^2+b4*Fz)*exp(-b5*Fz);
% B = BCD/(C*D);
% H = b9*Fz+b10;
% Sv\ = b11*Fz+b12;
% E = (b6*Fz^2+b7*Fz+b8);
% Sh = B*(Fz+H);

% Equations fot Lateral
% C = a0;
% D = Fz*(a1*Fz+a2);
% BCD = a3*sin(atan(Fz/a4)*2)*(1-a5*abs(camber));
% B = BCD/(C*D);
% H = a8*camber+a9*Fz+a10;
% Sv = a11*Fz*camber+a12*Fz+a13;
% E = (a6*Fz+a7);
% Sh = B*(Fz+H);

% Equations fot Aligning Moment
% C = c0;
% D = Fz*(c1*Fz+c2);
% BCD = (c3*Fz^2+c4^Fz)*(1-c6*abs(camber))*exp(-c5*Fz);
% B = BCD/(C*D);
% H = c11*camber+c12*Fz+a13;
% Sv = (c14*Fz^2+c15*Fz)*camber+c16*Fz+c17;
% E = (c7*Fz^2+c8*Fz+c9)*(1-c10*abs(camber));
% Sh = B*(Fz+H);

% Rolling resistance
% p_index = (p0-p).^(p_exp);
% Fz_index = (Fz0-Fz).^(Fz_exp-1);
% vx_index = v0+v1.*vx+v2.*vx.^2;
% 
% Crr = p_index.*Fz_index.*vx_index;
% Rr = Crr.*Fz;

% GRAPHS
Fz_range = [2:0.5:4]; % Normal Force per tyre [kN]
slip_range = [-100:1:100]; % Slip ratio [%]
slip_angle = [-25:0.2:25]; % Slip angle [deg]
cmb = 2; % Camber [deg]
% LONG
i = 1;
j = 1;
while i <= length(slip_range)
    slip = slip_range(i);
    while j <= length(Fz_range)
        Fz = Fz_range(j);
        
        C = tyre.b0;
        D = Fz*(tyre.b1*Fz+tyre.b2);
        BCD = (tyre.b3*Fz^2+tyre.b4*Fz)*exp(-tyre.b5*Fz);
        B = BCD/(C*D);
        H = tyre.b9*Fz+tyre.b10;
        V = tyre.b11*Fz+tyre.b12;
        E = (tyre.b6*Fz^2+tyre.b7*Fz+tyre.b8);
        Bx = B*(slip+H);
        
        Fx(i,j) = D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+V;
        j = j+1;
    end
    j = 1;
    i = i+1;
end
% LAT
i = 1;
j = 1;
while i <= length(slip_angle)
    slip = slip_angle(i);
    while j <= length(Fz_range)
        Fz = Fz_range(j);
        
        C = tyre.a0;
        D = Fz*(tyre.a1*Fz+tyre.a2);
        BCD = tyre.a3*sin(atan(Fz/tyre.a4)*2)*(1-tyre.a5*abs(cmb));
        B = BCD/(C*D);
        H = tyre.a8*cmb+tyre.a9*Fz+tyre.a10;
        V = tyre.a11*Fz*cmb+tyre.a12*Fz+tyre.a13;
        E = (tyre.a6*Fz+tyre.a7);
        Bx = B*(slip+H);
        
        Fy(i,j) = D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+V;
        j = j+1;
    end
    j = 1;
    i = i+1;
end
% MZ
i = 1;
j = 1;
while i <= length(slip_angle)
    slip = slip_angle(i);
    while j <= length(Fz_range)
        Fz = Fz_range(j);
        
        C = tyre.c0;
        D = Fz*(tyre.c1*Fz+tyre.c2);
        BCD = (tyre.c3*Fz^2+tyre.c4^Fz)*(1-tyre.c6*abs(cmb))*exp(-tyre.c5*Fz);
        B = BCD/(C*D);
        H = tyre.c11*cmb+tyre.c12*Fz+tyre.a13;
        V = (tyre.c14*Fz^2+tyre.c15*Fz)*cmb+tyre.c16*Fz+tyre.c17;
        E = (tyre.c7*Fz^2+tyre.c8*Fz+tyre.c9)*(1-tyre.c10*abs(cmb));
        Bx = B*(slip+H);
        
        Mz(i,j) = D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+V;
        j = j+1;
    end
    j = 1;
    i = i+1;
end
% RESULTS
figure('Name','Tyre.Model P2002 Montecarlo','NumberTitle','off')
subplot(2,1,1)
i = 1;
while i <= length(Fx(1,:))
    plot(slip_range,Fx(:,i));hold on;
    i = i+1;
end
grid minor
title('P2002. Montecarlo Fx-SR MF')
legend('2000 N','2500 N','3000 N','3500 N','4000 N','location','southeast')
xlabel('Slip ratio [%]');ylabel('Longitudinal Force [N]')
xticks([-100:10:100])

subplot(2,1,2)
i = 1;
while i <= length(Fy(1,:))
    plot(slip_angle,Fy(:,i));hold on;
    i = i+1;
end
grid minor
title('P2002. Montecarlo Fy-SA MF')
legend('2000 N','2500 N','3000 N','3500 N','4000 N','location','southeast')
xlabel('Slip angle [deg]');ylabel('Lateral Force [N]')
xticks([-25:2.5:25])

% subplot(3,1,3)
% i = 1;
% while i <= length(Fy(1,:))
%     plot(slip_angle,Mz(:,i));hold on;
%     i = i+1;
% end
% grid minor
% title('P2002. Montecarlo Mz-SA MF')
% legend('2000 N','2500 N','3000 N','3500 N','4000 N','location','southeast')
% xlabel('Slip angle [deg]');ylabel('Aligning Torque [Nm]')
% xticks([-25:2.5:25])

% ROLLING RESISTANCE MODEL
vxs = [0:50:250];
Fz = [0:1000:14000];

figure('Name','Tyre.Model Rolling Resistance','NumberTitle','off')
i = 1;
while i <= length(vxs)
    vx = vxs(i);
    
    p_index = (tyre.p0-tyre.p).^(tyre.p_exp);
    Fz_index = (tyre.Fz0-Fz).^(tyre.Fz_exp-1);
    vx_index = tyre.v0+tyre.v1.*vx+tyre.v2.*(vx.^2);

    Crr = p_index.*Fz_index.*vx_index;
    Rr = Crr.*Fz;

    subplot(2,1,1)
    plot(Fz,Crr);hold on;
    title('Rolling Resistance Coeficient')
    legend('0 km/h','50 km/h','100 km/h','150 km/h','200 km/h','250 km/h','location','southeast')
    xlabel('Normal Force [N]');ylabel('Crr [-]')
    xticks([0:1000:15000])
    subplot(2,1,2)
    plot(Fz,Rr);hold on;
    title('Rolling Resistance Force')
    legend('0 km/h','50 km/h','100 km/h','150 km/h','200 km/h','250 km/h','location','southeast')
    xlabel('Normal Force [N]');ylabel('Frr per tyre [N]')
    xticks([0:1000:15000]);yticks([0:50:200])
    i = i+1;
end
