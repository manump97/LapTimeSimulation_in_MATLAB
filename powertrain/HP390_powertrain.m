%% Powertrain Model HP390 %%
clear powertrain;%clc;

name = '390HP';

% Type (Combustion-0/Electric-1)
pwt.type = 0;

% Engine
% Initial values
    pwt.ni = [1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7500 8000]; % Initial n values [rpm]
    pwt.torquei = [310 335 352 362 377 379 425 420 435 438 425 398 370 315]; % Initial torque values [Nm]
% Min and Max n [rpm]
pwt.min_n = min(pwt.ni); % Minimum engine angular velocity [rpm]
pwt.max_n = max(pwt.ni); % Maximum engine angular velocity [rpm]
% Engine curves
pwt.interp_coef = polyfit(pwt.ni,pwt.torquei,4); % Interpolation coefficients
pwt.n = [pwt.min_n:20:pwt.max_n]; % Engine angular velocity [rpm]
pwt.torque =  polyval(pwt.interp_coef,pwt.n); % Engine torque [Nm]
pwt.power = pwt.torque.*pwt.n*(2*pi/60)/1000; % Engine power [kW]

% Gearbox
pwt.gear_i_r = [1.108 0.625 0.454 0.361 0.277 0.239];
pwt.diff = [3.44 3.44 3.44 3.44 3.44 3.44];
pwt.gear_r = pwt.gear_i_r.*pwt.diff;

% Fuel
pwt.fuel_cons_ratio = 0.5; % Fuel Consumption [L/km]
pwt.fuel_tank = 100; % Fuel tank [L] 

% Matrix calculus
    v = [0:1:10000];
    R = 14*25.4/1000;
    wo = v*(60/(2*pi))/R;
    wi(1:length(pwt.gear_r),1) = 0;
    i = 2;
    j = 1;
   while j <= length(pwt.gear_r)
        while wi(j,i-1) < pwt.max_n
            w_i = wo(i)*pwt.gear_r(j);
            wi(j,i) = w_i;
            i = i+1;
        end
        if w_i > pwt.max_n
            wi(j,i-1) = 0;
        end
        j = j+1;
        i = 2;
   end

pwt.n_matrix = wi; % Engine angular speed matrix (x-Speed [km/h], y-n [RPM])
pwt.n_lim_change = 7000; % n gear change upshift [rpm]
pwt.n_lim_reduce = 5000; % n gear change downshift [rpm]

% Gear change map calculus
    gear_change = 0;
    n_change = pwt.n_lim_change;
    i = 2;
    gear = 1;
    while i <= length(wi)
        if wi(gear,i-1) > n_change
            gear = gear+1;
            gear_change(i-1) = gear;
            if gear > length(wi(:,1))
                gear = length(wi(:,1));
                gear_change(i-1) = gear;
            end
        end
        gear_change(i) = gear;
        i = i+1;
    end
v = v(1:length(wi(1,:)));
pwt.gear_matrix = gear_change;

% GRAPHS
figure('Name','PWT.Power & Torque','NumberTitle','off')
plot(pwt.n,pwt.torque);hold on;
plot(pwt.ni,pwt.torquei,'.','MarkerSize',10)
xlim([pwt.min_n*0.8 pwt.max_n*1.1]);ylim([min(pwt.torque)*0.8 max(pwt.torque)*1.1]);
xlabel('Engine angular speed [RPM]');ylabel('Torque [Nm]');
yyaxis right
plot(pwt.n,pwt.power);
ylabel('Power [kW]')
title('Engine power & torque')

figure('Name','PWT.Gear change map','NumberTitle','off')
subplot(2,1,1)
plot(v,wi(1,:));hold on
plot(v,wi(2,:));
plot(v,wi(3,:));
plot(v,wi(4,:));
plot(v,wi(5,:));
plot(v,wi(6,:));
legend('g1','g2','g3','g4','g5','g6')
xlabel('Speed [km/h]');ylabel('Engine angular speed [RPM]');
title('Gear change map')
subplot(2,1,2)
plot(v,gear_change);
ylim([0 7]);
xlabel('Speed [km/h]');ylabel('Gear [-]');

% Torque and Force
gear_r = pwt.gear_r;
vx = [0:1:1000];
w_o = vx*(60/(2*pi))/R;

wi(1:length(gear_r),1) = 0;

n = pwt.ni;
torque = pwt.torquei;
p1 = polyfit(n,torque,4);
torque_i = polyval(p1,n);
power_i = torque_i.*n*(2*pi/60)/1000;

i = 2;
j = 1;
while j <= length(gear_r)
    while wi(j,i-1) < max(n)
        w_i = w_o(i).*gear_r(j);
        torque_m(j,i) = polyval(p1,w_i);
        torque_w(j,i) = torque_m(j,i).*gear_r(j);
        Fx_w(j,i) = torque_w(j,i).*pwt.diff(j)/R;
        wi(j,i) = w_i;
        i = i+1;
    end
    if w_i > max(n)
        wi(j,i-1) = 0;
        torque_m(j,i-1) = 0;
        torque_w(j,i-1) = 0;
        Fx_w(j,i-1) = 0;
    end
    i = 2;
    j = j+1;
end
vx = vx(1:length(wi));

figure('Name','PWT.Torque per gear','NumberTitle','off')
subplot(2,1,1)
plot(vx,torque_m(1,:));hold on
plot(vx,torque_m(2,:));
plot(vx,torque_m(3,:));
plot(vx,torque_m(4,:));
plot(vx,torque_m(5,:));
plot(vx,torque_m(6,:));
legend('g1','g2','g3','g4','g5','g6')
xlabel('Speed [km/h]');ylabel('Torque Motor [Nm]');
title('Torque per gear')
subplot(2,1,2)
plot(vx,torque_w(1,:));hold on
plot(vx,torque_w(2,:));
plot(vx,torque_w(3,:));
plot(vx,torque_w(4,:));
plot(vx,torque_w(5,:));
plot(vx,torque_w(6,:));
legend('g1','g2','g3','g4','g5','g6')
xlabel('Speed [km/h]');ylabel('Torque Wheel [Nm]');

figure('Name','PWT.Fx per gear','NumberTitle','off')
plot(vx,Fx_w(1,:));hold on
plot(vx,Fx_w(2,:));
plot(vx,Fx_w(3,:));
plot(vx,Fx_w(4,:));
plot(vx,Fx_w(5,:));
plot(vx,Fx_w(6,:));
legend('g1','g2','g3','g4','g5','g6')
xlabel('Speed [km/h]');ylabel('Fx_w [N]');
title('Longitudinal force per gear')

