% simple_MF_tyre %
%close all;
clear all;%clc;

Fz_range = [2000:500:4000]; % [N]
slip_ratio = [-100:1:100]; % [%] 0-100
slip_angle = [-25:1:25];

B = 10;
C = 1.65; % 1.65 Long, 1.3 Lat
D = 1;
E = 0.97;

i = 1;
j = 1;
while i <= length(slip_ratio)
    slip = slip_ratio(i);
    while j <= length(Fz_range)
        Fz = Fz_range(j);
        Fx(i,j) = Fz*D*sin(C*atan(B*slip-E*(B*slip-atan(B*slip))));
        j = j+1;
    end
    j = 1;
    i = i+1;
end

% LATERAL
C = 1.3;

i = 1;
j = 1;
while i <= length(slip_angle)
    slip = slip_angle(i);
    while j <= length(Fz_range)
        Fz = Fz_range(j);
        Fy(i,j) = Fz*D*sin(C*atan(B*slip-E*(B*slip-atan(B*slip))));
        j = j+1;
    end
    j = 1;
    i = i+1;
end

figure('Name','Tyre.Simple MF','NumberTitle','off')
subplot(2,1,1)
i = 1;
while i <= length(Fx(1,:))
    plot(slip_ratio,Fx(:,i));hold on;
    i = i+1;
end
grid minor
title('Simple Long MF')
xlabel('Slip Ratio [%]');ylabel('Longitudinal Force [N]')
legend('2000 N','2500 N','3000 N','3500 N','4000 N','location','southeast')


subplot(2,1,2)
i = 1;
while i <= length(Fy(1,:))
    plot(slip_angle,Fy(:,i));hold on;
    i = i+1;
end
grid minor
title('Simple Lat MF')
xlabel('Slip Angle [deg]');ylabel('Lateral Force [N]')
legend('2000 N','2500 N','3000 N','3500 N','4000 N','location','southeast')

