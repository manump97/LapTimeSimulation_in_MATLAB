% ----- % Results solver % ----- %
% clc;close all;
% BASIC INFO
s1 = tck.sectors.s1;
s2 = tck.sectors.s2;
s3 = tck.sectors.s3;

time = 1./(stv.kin.vx);time(1)=time(2).*2;
acc_time = 100*sum(time(diff(stv.kin.vx)>0))/sum(time);
bra_time = 100*sum(time(diff(stv.kin.vx)<0))/sum(time);

lap_time = sum(time);
lap_average_speed = mean(3.6.*stv.kin.vx);
fprintf('  Lap Time [s]: %8.3f\n',lap_time)
fprintf('\n  Average Speed [km/h]: %8.3f\n',lap_average_speed)
fprintf('\n  Accelerating Time [%%]: %8.1f\n',acc_time)
fprintf('  Braking Time [%%]:      %8.1f\n\n',bra_time)

s1_time = sum(time(1:s1));
s2_time = sum(time((s1+1):s2));
s3_time = sum(time((s2+1):s3));
s1_avspeed = mean(3.6.*stv.kin.vx(1:s1));
s2_avspeed = mean(3.6.*stv.kin.vx((s1+1):s2));
s3_avspeed = mean(3.6.*stv.kin.vx((s2+1):s3));

fprintf('  S1 Time [s]: %8.3f\n',s1_time)
fprintf('  S1 Average Speed [km/h]: %8.3f\n\n',s1_avspeed)

fprintf('  S2 Time [s]: %8.3f\n',s2_time)
fprintf('  S2 Average Speed [km/h]: %8.3f\n\n',s2_avspeed)

fprintf('  S3 Time [s]: %8.3f\n',s3_time)
fprintf('  S3 Average Speed [km/h]: %8.3f\n\n',s3_avspeed)

% Speed profile
figure('Name','RESULTS.Speed','NumberTitle','off')
plot(tck.profile.sim_long,stv.kin.vx*3.6);hold on;
plot(tck.profile.sim_long,Select_status.*50,'-m');
plot([s1 s1],[0 300],'--r','linewidth',1);plot([s2 s2],[0 300],'--y','linewidth',1);plot([s3 s3],[0 300],'--c','linewidth',1)
ylim([0,300]);
xticks([0:250:max(tck.profile.sim_long)])
yticks([0:20:300])
xlabel('Distance [m]');ylabel('Speed [km/h]');
legend('Speed [km/h]','Turn behaviour','Sector 1','Sector 2','Sector 3')
title('Speed profile')

% Acceleration profile
figure('Name','RESULTS.Acceleration','NumberTitle','off')
subplot(3,1,1)
plot(tck.profile.sim_long,stv.kin.ax);hold on;
plot([s1 s1],[-16 16],'--r','linewidth',1);plot([s2 s2],[-16 16],'--y','linewidth',1);plot([s3 s3],[-16 16],'--c','linewidth',1)
xticks([0:250:max(tck.profile.sim_long)])
ylim([-16,12]);yticks([-16:4:12]);
xlabel('Distance [m]');ylabel('Long. acceleration [m/s2]');
title('Accelerations profile')
yyaxis right
area(stv.kin.vx*3.6,'FaceColor','b','EdgeColor','b',...
    'FaceAlpha',0.15,'EdgeAlpha',0.15)
ylabel('Speed [km/h]')
ax = gca;ax.YAxis(2).Color = 'b';
subplot(3,1,2)
plot(tck.profile.sim_long,stv.kin.ay);hold on;
plot([s1 s1],[-25 25],'--r','linewidth',1);plot([s2 s2],[-25 25],'--y','linewidth',1);plot([s3 s3],[-25 25],'--c','linewidth',1)
xticks([0:250:max(tck.profile.sim_long)])
ylim([-20,20]);yticks([-20:5:20]);
xlabel('Distance [m]');ylabel('Lat. acceleration [m/s2]');
yyaxis right
area(stv.kin.vx*3.6,'FaceColor','b','EdgeColor','b',...
    'FaceAlpha',0.15,'EdgeAlpha',0.15)
ylabel('Speed [km/h]')
ax = gca;ax.YAxis(2).Color = 'b';
subplot(3,1,3)
plot(tck.profile.sim_long,Select_status,'m');hold on;
plot([s1 s1],[0 max(Select_status)],'--r','linewidth',1);plot([s2 s2],[0 max(Select_status)],'--y','linewidth',1);plot([s3 s3],[0 max(Select_status)],'--c','linewidth',1)
xticks([0:250:max(tck.profile.sim_long)])
yticks([min(Select_status):1:max(Select_status)])
xlabel('Distance [m]');ylabel('Turn behaviour [-]');
yyaxis right
area(stv.kin.vx*3.6,'FaceColor','b','EdgeColor','b',...
    'FaceAlpha',0.15,'EdgeAlpha',0.15)
ylabel('Speed [km/h]')
ax = gca;ax.YAxis(2).Color = 'b';

% G-G Diagram
i = 1;
while i <= length(stv.kin.ax)
    ax = abs(stv.kin.ax(i));
    ay = abs(stv.kin.ay(i));
    if stv.kin.ax(i) < 0
        ax = -ax;
    end
    
    if stv.kin.ay(i) < 0
        ay = -ay;
    end
    
    stv.kin.ax(i) = ax;
    stv.kin.ay(i) = ay;
    
    i = i+1; 
end

ax_max = max(stv.kin.ax);
ax_min = min(stv.kin.ax);
ay_max = max(stv.kin.ay);
ay_min = min(stv.kin.ay);

figure('Name','RESULTS.G-G Diagram','NumberTitle','off')
plot(stv.kin.ay,stv.kin.ax,'.','MarkerSize',10);hold on;
scatter(ay_max,0,'or','LineWidth',3);
scatter(ay_min,0,'ok','LineWidth',3);
scatter(0,ax_max,'og','LineWidth',3);
scatter(0,ax_min,'om','LineWidth',3);
xlabel('Lateral acceleration [m/s2]');ylabel('Longitudinal acceleration [m/s2]');
ylim([-14,8]);yticks([-14:2:8]);
xlim([-25,25]);xticks([-25:5:25]);
legend('Acceleration data','Max Ay','Min Ay','Max Ax','Min Ax')
title('G-G Aceleration Diagram')

% Aerodynamics
figure('Name','RESULTS.Aerodynamics','NumberTitle','off')
subplot(2,1,1)
plot(tck.profile.sim_long,stv.aero.Fdrag);hold on;
plot(tck.profile.sim_long,stv.aero.Flift)
plot([s1 s1],[0 2500],'--r','linewidth',1);plot([s2 s2],[0 2500],'--y','linewidth',1);plot([s3 s3],[0 2500],'--c','linewidth',1)
xlabel('Distance [m]');ylabel('Force [N]');
title('Aerodynamics profile')
yyaxis right
area(stv.kin.vx*3.6,'FaceColor','b','EdgeColor','b',...
    'FaceAlpha',0.15,'EdgeAlpha',0.15)
ylabel('Speed [km/h]')
ax = gca;ax.YAxis(2).Color = 'b';
legend('Drag','Lift');
subplot(2,1,2)
plot(tck.profile.sim_long,Select_status,'m');hold on;
plot([s1 s1],[0 max(Select_status)],'--r','linewidth',1);plot([s2 s2],[0 max(Select_status)],'--y','linewidth',1);plot([s3 s3],[0 max(Select_status)],'--c','linewidth',1)
xticks([0:250:max(tck.profile.sim_long)])
yticks([min(Select_status):1:max(Select_status)])
xlabel('Distance [m]');ylabel('Turn behaviour [-]');
plot([s1 s1],[0 max(Select_status)],'--r','linewidth',1);plot([s2 s2],[0 max(Select_status)],'--y','linewidth',1);plot([s3 s3],[0 max(Select_status)],'--c','linewidth',1)
yyaxis right
area(stv.kin.vx*3.6,'FaceColor','b','EdgeColor','b',...
    'FaceAlpha',0.15,'EdgeAlpha',0.15)
ylabel('Speed [km/h]')
ax = gca;ax.YAxis(2).Color = 'b';

% Tyre Force
figure('Name','RESULTS.Tyre Forces','NumberTitle','off')
subplot(3,1,1)
plot(tck.profile.sim_long,stv.tyre.Fx_F/1000);hold on;
plot(tck.profile.sim_long,stv.tyre.Fx_R/1000)
plot([s1 s1],[0 30],'--r','linewidth',1);plot([s2 s2],[0 30],'--y','linewidth',1);plot([s3 s3],[0 30],'--c','linewidth',1)
xticks([0:250:max(tck.profile.sim_long)])
xlabel('Distance [m]');ylabel('Long. Force [kN]');
title('Tyre Forces')
ylim([0 10])
yyaxis right
area(stv.kin.vx*3.6,'FaceColor','b','EdgeColor','b',...
    'FaceAlpha',0.15,'EdgeAlpha',0.15)
ylabel('Speed [km/h]')
ax = gca;ax.YAxis(2).Color = 'b';
legend('Fx_F','Fx_R')

subplot(3,1,2)
plot(tck.profile.sim_long,stv.tyre.Fy_F/1000);hold on;
plot(tck.profile.sim_long,stv.tyre.Fy_R/1000)
plot([s1 s1],[0 30],'--r','linewidth',1);plot([s2 s2],[0 30],'--y','linewidth',1);plot([s3 s3],[0 30],'--c','linewidth',1)
xticks([0:250:max(tck.profile.sim_long)])
xlabel('Distance [m]');ylabel('Lat. Force [kN]');
ylim([0 30])
yyaxis right
area(stv.kin.vx*3.6,'FaceColor','b','EdgeColor','b',...
    'FaceAlpha',0.15,'EdgeAlpha',0.15)
ylabel('Speed [km/h]')
ax = gca;ax.YAxis(2).Color = 'b';
legend('Fy_F','Fy_R')

subplot(3,1,3)
plot(tck.profile.sim_long,stv.tyre.Fz_F/1000);hold on;
plot(tck.profile.sim_long,stv.tyre.Fz_R/1000)
plot([s1 s1],[0 30],'--r','linewidth',1);plot([s2 s2],[0 30],'--y','linewidth',1);plot([s3 s3],[0 30],'--c','linewidth',1)
xticks([0:250:max(tck.profile.sim_long)])
xlabel('Distance [m]');ylabel('Normal Force [kN]');
ylim([0 20])
yyaxis right
area(stv.kin.vx*3.6,'FaceColor','b','EdgeColor','b',...
    'FaceAlpha',0.15,'EdgeAlpha',0.15)
ylabel('Speed [km/h]')
ax = gca;ax.YAxis(2).Color = 'b';
legend('Fz_F','Fz_R')

% Rolling Resistance
figure('Name','RESULTS.Rolling Resistance','NumberTitle','off')
subplot(2,1,1)
plot(tck.profile.sim_long,stv.tyre.Rr_F);hold on;
plot(tck.profile.sim_long,stv.tyre.Rr_R);
plot([s1 s1],[0 200],'--r','linewidth',1);plot([s2 s2],[0 200],'--y','linewidth',1);plot([s3 s3],[0 200],'--c','linewidth',1)
xlabel('Distance [m]');ylabel('Rolling Resistance Force [N]');
ylim([0 200]);xticks([0:250:max(tck.profile.sim_long)])
title('Rolling Resistance profile')
yyaxis right
area(stv.kin.vx*3.6,'FaceColor','b','EdgeColor','b',...
    'FaceAlpha',0.15,'EdgeAlpha',0.15)
ylabel('Speed [km/h]')
ax = gca;ax.YAxis(2).Color = 'b';
legend('Rr Front','Rr Rear')
subplot(2,1,2)
plot(tck.profile.sim_long,stv.tyre.Crr_F.*10);hold on;
plot(tck.profile.sim_long,stv.tyre.Crr_R.*10);
plot([s1 s1],[0 0.1],'--r','linewidth',1);plot([s2 s2],[0 0.1],'--y','linewidth',1);plot([s3 s3],[0 0.1],'--c','linewidth',1)
xlabel('Distance [m]');ylabel('Rolling Resistance Coefficient x10 [-]');
ylim([0 0.1]);xticks([0:250:max(tck.profile.sim_long)])
yyaxis right
area(stv.kin.vx*3.6,'FaceColor','b','EdgeColor','b',...
    'FaceAlpha',0.15,'EdgeAlpha',0.15)
ylabel('Speed [km/h]')
ax = gca;ax.YAxis(2).Color = 'b';
legend('Crr Front','Crr Rear')

% Tractive forces
tractive = stv.kin.Fx_F+stv.kin.Fx_R;
tyre_Fx = stv.tyre.Fx_F;
tyre_Fy = stv.tyre.Fy_R;
motor = stv.pwt.Fx;

figure('Name','RESULTS.Tractive Forces','NumberTitle','off')
plot(tck.profile.sim_long,motor/1000);hold on;
plot(tck.profile.sim_long,tyre_Fx/1000)
plot(tck.profile.sim_long,tyre_Fy/1000)
plot(tck.profile.sim_long,tractive/1000,'g','LineWidth',2)
plot(tck.profile.sim_long,Select_status,'m');hold on;
plot([s1 s1],[0 12],'--r','linewidth',1);plot([s2 s2],[0 12],'--y','linewidth',1);plot([s3 s3],[0 12],'--c','linewidth',1)
xticks([0:250:max(tck.profile.sim_long)])
ylim([0,12]);yticks([0:1:12]);
xlabel('Distance [m]');ylabel('Force [kN]');
title('Tractive Forces')
yyaxis right
area(stv.kin.vx*3.6,'FaceColor','b','EdgeColor','b',...
    'FaceAlpha',0.15,'EdgeAlpha',0.15)
ylabel('Speed [km/h]')
ax = gca;ax.YAxis(2).Color = 'b';
legend('Engine Force','Tyre Fx Force','Tyre Fy Force','Tractive Force','Turn behaviour')

% Engine
figure('Name','RESULTS.Engine map behaviour','NumberTitle','off')
subplot(3,1,1)
plot(stv.kin.vx*3.6,stv.pwt.n,'.');
xlabel('Speed [km/h]');ylabel('Engine angular speed [RPM]');
xticks([0:10:250])
title('Engine map behaviour')
subplot(3,1,2)
plot(stv.kin.vx*3.6,stv.pwt.torque,'.');
xlabel('Speed [km/h]');ylabel('Engine Torque [Nm]');
xticks([0:10:250])
subplot(3,1,3)
plot(stv.kin.vx*3.6,stv.pwt.power/5000,'.')
xlabel('Speed [km/h]');ylabel('Engine Power [kW]');
xticks([0:10:250])

% SIM TRACES
PL = tck.surfaceXYZ.PL;
PR = tck.surfaceXYZ.PR;
P = tck.surfaceXYZ.P;
T = tck.trajectory.T;
figure('Name','SIM.Speed Trace','NumberTitle','off')
plot(PL(1,:),PL(2,:),'-k');hold on;
plot(PR(1,:),PR(2,:),'-k');grid minor;
plot(P(1,:),P(2,:),'-c');
plot(T(1,:),T(2,:),'.m','MarkerSize',8)
scatter(T(1,:),T(2,:),30,stv.kin.vx*3.6,...
    'MarkerFaceColor','flat','LineWidth',0.000001)
c = colorbar;
c.Label.String = 'Speed [km/h]';
colormap('parula')
plot(P(1,s1),P(2,s1),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r')
plot(P(1,s2),P(2,s2),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','y')
plot(P(1,s3),P(2,s3),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','c')
xlabel('X [m]');ylabel('Y [m]')
title('Speed trace')


figure('Name','SIM.Acceleration Trace','NumberTitle','off')
subplot(2,1,1)
plot(PL(1,:),PL(2,:),'-k');hold on;
plot(PR(1,:),PR(2,:),'-k');grid minor;
plot(P(1,:),P(2,:),'-c');
plot(T(1,:),T(2,:),'.m','MarkerSize',8)
scatter(T(1,:),T(2,:),30,stv.kin.ax,...
    'MarkerFaceColor','flat','LineWidth',0.000001)
c = colorbar;
c.Label.String = 'Longitudinal acceleration [m/s2]';
colormap('parula')
plot(P(1,s1),P(2,s1),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r')
plot(P(1,s2),P(2,s2),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','y')
plot(P(1,s3),P(2,s3),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','c')
xlabel('X [m]');ylabel('Y [m]')
title('Longitudinal acceleration trace')
subplot(2,1,2)
plot(PL(1,:),PL(2,:),'-k');hold on;
plot(PR(1,:),PR(2,:),'-k');grid minor;
plot(P(1,:),P(2,:),'-c');
plot(T(1,:),T(2,:),'.m','MarkerSize',8)
scatter(T(1,:),T(2,:),30,stv.kin.ay,...
    'MarkerFaceColor','flat','LineWidth',0.000001)
c = colorbar;
c.Label.String = 'Lateral acceleration [m/s2]';
colormap('parula')
plot(P(1,s1),P(2,s1),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r')
plot(P(1,s2),P(2,s2),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','y')
plot(P(1,s3),P(2,s3),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','c')
xlabel('X [m]');ylabel('Y [m]')
title('Lateral acceleration trace')


figure('Name','SIM.Height Trace','NumberTitle','off')
plot(PL(1,:),PL(2,:),'-k');hold on;
plot(PR(1,:),PR(2,:),'-k');grid minor;
plot(P(1,:),P(2,:),'-c');
plot(T(1,:),T(2,:),'.m','MarkerSize',8)
scatter(T(1,:),T(2,:),30,tck.surfaceXYZ.Pz,...
    'MarkerFaceColor','flat','LineWidth',0.000001)
c = colorbar;
c.Label.String = 'Height [m]';
colormap('parula')
plot(P(1,s1),P(2,s1),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r')
plot(P(1,s2),P(2,s2),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','y')
plot(P(1,s3),P(2,s3),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','c')
xlabel('X [m]');ylabel('Y [m]')
title('Height trace')


figure('Name','SIM.Aerodynamics trace','NumberTitle','off')
subplot(2,1,1)
plot(PL(1,:),PL(2,:),'-k');hold on;
plot(PR(1,:),PR(2,:),'-k');grid minor;
plot(P(1,:),P(2,:),'-c');
plot(T(1,:),T(2,:),'.m','MarkerSize',8)
scatter(T(1,:),T(2,:),30,stv.aero.Fdrag,...
    'MarkerFaceColor','flat','LineWidth',0.000001)
c = colorbar;caxis([0,1800])
c.Label.String = 'Drag Force [N]';
colormap('parula')
plot(P(1,s1),P(2,s1),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r')
plot(P(1,s2),P(2,s2),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','y')
plot(P(1,s3),P(2,s3),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','c')
xlabel('X [m]');ylabel('Y [m]')
title('Aerodynamics trace')
subplot(2,1,2)
plot(PL(1,:),PL(2,:),'-k');hold on;
plot(PR(1,:),PR(2,:),'-k');grid minor;
plot(P(1,:),P(2,:),'-c');
plot(T(1,:),T(2,:),'.m','MarkerSize',8)
scatter(T(1,:),T(2,:),30,stv.aero.Flift,...
    'MarkerFaceColor','flat','LineWidth',0.000001)
c = colorbar;caxis([0,1800])
c.Label.String = 'Lift Force [N]';
colormap('parula')
plot(P(1,s1),P(2,s1),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r')
plot(P(1,s2),P(2,s2),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','y')
plot(P(1,s3),P(2,s3),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','c')
xlabel('X [m]');ylabel('Y [m]')


figure('Name','SIM.Tractive Force trace','NumberTitle','off')
plot(PL(1,:),PL(2,:),'-k');hold on;
plot(PR(1,:),PR(2,:),'-k');grid minor;
plot(P(1,:),P(2,:),'-c');
plot(T(1,:),T(2,:),'.m','MarkerSize',8)
scatter(T(1,:),T(2,:),30,stv.kin.Fx_F+stv.kin.Fx_R,...
    'MarkerFaceColor','flat','LineWidth',0.000001)
c = colorbar;
c.Label.String = 'Tractive Force [N]';
colormap('parula')
plot(P(1,s1),P(2,s1),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r')
plot(P(1,s2),P(2,s2),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','y')
plot(P(1,s3),P(2,s3),'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','c')
xlabel('X [m]');ylabel('Y [m]')
title('Tractive Force trace')


figure('Name','SIM.Speed Histogram','NumberTitle','off')
subplot(2,1,1)
histogram(stv.kin.vx*3.6,[0:10:300],'Normalization','probability')
xlabel('Speed [km/h]');ylabel('Percentage [-]')
title('Sim. Speed Histogram')
subplot(2,1,2)
[f,z]=hist(stv.kin.vx*3.6,[0:10:300]);
fNorm = 100*f/(sum(f));
fCDF = cumsum(fNorm);
stairs(z,fCDF);
xticks([0:10:300]);
xlabel('Speed [km/h]');ylabel('Acumulative [%]');

figure('Name','SIM.Tractive Force Histogram','NumberTitle','off')
subplot(2,1,1)
histogram(stv.kin.Fx_F+stv.kin.Fx_R,[-1000:100:10000],'Normalization','probability')
xlabel('Tractive Force [N]');ylabel('Percentage [-]')
title('Sim. Tractive Force Histogram')
xticks([-1000:500:10000]);
subplot(2,1,2)
[f,z]=hist(stv.kin.Fx_F+stv.kin.Fx_R,[-1000:500:10000]);
fNorm = 100*f/(sum(f));
fCDF = cumsum(fNorm);
stairs(z,fCDF);
xticks([-1000:500:10000]);
xlabel('Tractive Force [N]');ylabel('Acumulative [%]');

% Clear variables
clearvars -except car env tck Select* stv tyre pwt lap*
% clearvars Select_status

