% Monza Track Model v1
%close all;clear all;%clc;
% tic
sim = 0;
save_track = 0;

% SET ORIGINS
w = 10; % Track Width [m]
origin = [0;0;0;0;1];
origin_L = [0;-w/2;0;0;1];
origin_R = [0;w/2;0;0;1];
P = origin;
PL = origin_L;
PR = origin_R;
C = []; CL = []; CR = [];
switch sim
    case 0
        ratio = 1;
    case 1
        ratio = 0.1;
end

% Parameters per segment
% Sector 1
d1 = [-920,0];          e1s = round(abs(-920)*ratio);
R2 = 15; a2 = -90;      e2c = round(2*pi*R2*(abs(a2)/360)*ratio);
d3 = 6;                 e3s = round(abs(d3)*ratio);
R4 = 15; a4 = 105;      e4c = round(2*pi*R4*(abs(a4)/360)*ratio);
d5 = 100;               e5s = round(abs(d5)*ratio);
R6 = 280; a6 = -15;     e6c = round(2*pi*R6*(abs(a6)/360)*ratio);
d7 = 140;               e7s = round(abs(d7)*ratio);
R8 = 315; a8 = -80;     e8c = round(2*pi*R8*(abs(a8)/360)*ratio);
d9 = 365;               e9s = round(abs(d9)*ratio);
% Sector 2
R10 = 20; a10 = 80;     e10c = round(2*pi*R10*(abs(a10)/360)*ratio);
d11 = 10;               e11s = round(abs(d11)*ratio);
R12 = 20; a12 = -70;    e12c = round(2*pi*R12*(abs(a12)/360)*ratio);
d13 = 320;              e13s = round(abs(d13)*ratio);
R14 = 70; a14 = -105;   e14c = round(2*pi*R14*(abs(a14)/360)*ratio);
d15 = 230;              e15s = round(abs(d15)*ratio);
R16 = 40; a16 = -60;    e16c = round(2*pi*R16*(abs(a16)/360)*ratio);
d17 = 230;              e17s = round(abs(d17)*ratio);
R18 = 1200; a18 = 20;   e18c = round(2*pi*R18*(abs(a18)/360)*ratio);
d19 = 390;              e19s = round(abs(d19)*ratio);
% Sector 3
R20 = 30; a20 = 70;     e20c = round(2*pi*R20*(abs(a20)/360)*ratio);
d21 = 2;               e21s = round(abs(d21)*ratio);
R22 = 110; a22 = -90;   e22c = round(2*pi*R22*(abs(a22)/360)*ratio);
d23 = 2;                e23s = round(abs(d23)*ratio);
R24 = 50; a24 = 55;     e24c = round(2*pi*R24*(abs(a24)/360)*ratio);
d25 = 900;            e25s = round(abs(d25)*ratio);
R26 = 80; a26 = -90;    e26c = round(2*pi*R26*(abs(a26)/360)*ratio);
R27 = 190; a27 = -85;   e27c = round(2*pi*R27*(abs(a27)/360)*ratio);
d28 = 230;              e28s = round(abs(d28)*ratio);
R29 = 900; a29 = -5;     e29c = round(2*pi*R29*(abs(a29)/360)*ratio);
d30 = 5;              e30s = round(abs(d30)*ratio);

% Segments
figure('Name','TRACK.Layout. Autodromo di Monza. Italia','NumberTitle','Off',...
    'units','normalized','outerposition',[0 0 1 1])
% 1
[P,C] = ParamRecta(P,C,1,d1,e1s);
[PL,CL] = ParamRecta(PL,CL,1,d1,-e1s);
[PR,CR] = ParamRecta(PR,CR,1,d1,-e1s);
% 2
[P,C] = ParamArcTag(P,C,1,R2,a2,e2c,10);
[PL,CL] = ParamArcTag(PL,CL,1,R2+w/2,a2,e2c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R2-w/2,a2,e2c,1);
% 3
[P,C] = ParamRecta(P,C,1,d3,e3s);
[PL,CL] = ParamRecta(PL,CL,1,d3,-e3s);
[PR,CR] = ParamRecta(PR,CR,1,d3,-e3s);
% 4
[P,C] = ParamArcTag(P,C,1,R4,a4,e4c,10);
[PL,CL] = ParamArcTag(PL,CL,1,R4-w/2,a4,e4c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R4+w/2,a4,e4c,1);
% 5
[P,C] = ParamRecta(P,C,1,d5,e5s);
[PL,CL] = ParamRecta(PL,CL,1,d5,-e5s);
[PR,CR] = ParamRecta(PR,CR,1,d5,-e5s);
% 6 
[P,C] = ParamArcTag(P,C,1,R6,a6,e6c,10);
[PL,CL] = ParamArcTag(PL,CL,1,R6+w/2,a6,e6c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R6-w/2,a6,e6c,1);
% 7
[P,C] = ParamRecta(P,C,1,d7,e7s);
[PL,CL] = ParamRecta(PL,CL,1,d7,-e7s);
[PR,CR] = ParamRecta(PR,CR,1,d7,-e7s);
% 8 
[P,C] = ParamArcTag(P,C,1,R8,a8,e8c,10);
[PL,CL] = ParamArcTag(PL,CL,1,R8+w/2,a8,e8c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R8-w/2,a8,e8c,1);
% 9
[P,C] = ParamRecta(P,C,1,d9,e9s);
[PL,CL] = ParamRecta(PL,CL,1,d9,-e9s);
[PR,CR] = ParamRecta(PR,CR,1,d9,-e9s);
% 10 
[P,C] = ParamArcTag(P,C,2,R10,a10,e10c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R10-w/2,a10,e10c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R10+w/2,a10,e10c,1);
% 11
[P,C] = ParamRecta(P,C,2,d11,e11s);
[PL,CL] = ParamRecta(PL,CL,2,d11,-e11s);
[PR,CR] = ParamRecta(PR,CR,2,d11,-e11s);
% 12 
[P,C] = ParamArcTag(P,C,2,R12,a12,e12c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R12+w/2,a12,e12c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R12-w/2,a12,e12c,1);
% 13
[P,C] = ParamRecta(P,C,2,d13,e13s);
[PL,CL] = ParamRecta(PL,CL,2,d13,-e13s);
[PR,CR] = ParamRecta(PR,CR,2,d13,-e13s);
% 14 
[P,C] = ParamArcTag(P,C,2,R14,a14,e14c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R14+w/2,a14,e14c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R14-w/2,a14,e14c,1);
% 15
[P,C] = ParamRecta(P,C,2,d15,e15s);
[PL,CL] = ParamRecta(PL,CL,2,d15,-e15s);
[PR,CR] = ParamRecta(PR,CR,2,d15,-e15s);
% 16 
[P,C] = ParamArcTag(P,C,2,R16,a16,e16c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R16+w/2,a16,e16c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R16-w/2,a16,e16c,1);
% 17
[P,C] = ParamRecta(P,C,2,d17,e17s);
[PL,CL] = ParamRecta(PL,CL,2,d17,-e17s);
[PR,CR] = ParamRecta(PR,CR,2,d17,-e17s);
% 18 
[P,C] = ParamArcTag(P,C,2,R18,a18,e18c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R18-w/2,a18,e18c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R18+w/2,a18,e18c,1);
% 19
[P,C] = ParamRecta(P,C,2,d19,e19s);
[PL,CL] = ParamRecta(PL,CL,2,d19,-e19s);
[PR,CR] = ParamRecta(PR,CR,2,d19,-e19s);
% 20 
[P,C] = ParamArcTag(P,C,3,R20,a20,e20c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R20-w/2,a20,e20c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R20+w/2,a20,e20c,1);
% 21
[P,C] = ParamRecta(P,C,2,d21,e21s);
[PL,CL] = ParamRecta(PL,CL,2,d21,-e21s);
[PR,CR] = ParamRecta(PR,CR,2,d21,-e21s);
% 22 
[P,C] = ParamArcTag(P,C,3,R22,a22,e22c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R22+w/2,a22,e22c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R22-w/2,a22,e22c,1);
% 23
[P,C] = ParamRecta(P,C,2,d23,e23s);
[PL,CL] = ParamRecta(PL,CL,2,d23,-e23s);
[PR,CR] = ParamRecta(PR,CR,2,d23,-e23s);
% 24 
[P,C] = ParamArcTag(P,C,3,R24,a24,e24c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R24-w/2,a24,e24c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R24+w/2,a24,e24c,1);
% 25
[P,C] = ParamRecta(P,C,3,d25,e25s);
[PL,CL] = ParamRecta(PL,CL,3,d25,-e25s);
[PR,CR] = ParamRecta(PR,CR,3,d25,-e25s);
% 26
[P,C] = ParamArcTag(P,C,3,R26,a26,e26c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R26+w/2,a26,e26c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R26-w/2,a26,e26c,1);
% 27
[P,C] = ParamArcTag(P,C,3,R27,a27,e27c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R27+w/2,a27,e27c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R27-w/2,a27,e27c,1);
% 28
[P,C] = ParamRecta(P,C,3,d28,e28s);
[PL,CL] = ParamRecta(PL,CL,3,d28,-e28s);
[PR,CR] = ParamRecta(PR,CR,3,d28,-e28s);
% 29
[P,C] = ParamArcTag(P,C,3,R29,a29,e29c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R29+w/2,a29,e29c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R29-w/2,a29,e29c,1);
% 30
[P,C] = ParamRecta(P,C,3,d30,e30s);
[PL,CL] = ParamRecta(PL,CL,3,d30,-e30s);
[PR,CR] = ParamRecta(PR,CR,3,d30,-e30s);

P(:,end) = [];
PL(:,end) = [];
PR(:,end) = [];

% FIGURE PARAMETERS
grid minor
xlim([min(P(1,:))-100,max(P(1,:))+100]);ylim([min(P(2,:))-100,max(P(2,:))+100]);
title('Autodromo di Monza. Italia')
plot(P(1,1),P(2,1),'sk','MarkerFaceColor','k')%,'MarkerSize',10)
text(-20,35,'Start','Color','k','FontSize',10)

% ANIMATION
simu_animation(P,sim,0.001)

% Theorical distance
i = 2;
sim_long(1) = 0;
Px = P(1,:); Py = P(2,:);
while i <= length(P(1,:))
    vlong = [Px(i)-Px(i-1) Py(i)-Py(i-1)];
    sim_long(i) = sim_long(i-1) + norm(vlong);
    i = i+1;
end
% figure('Name','Distance Evolution. Autodromo di Monza-Italy','NumberTitle','Off')
% plot(sim_long); hold on; grid minor;
% plot([0 length(sim_long)],[0 5793],'-r')
% xlabel('Points []');ylabel('Accumulative Distance [m]')

% Z coordinate
z = [0 10 1400 1700 1950 2250 3500 3600 3750 3900 5000 5450 5793;
    182 182 190 190 192 192 187 184 184 187 181 181 182];

Pz = [];
iz = 2;

m = (z(2,iz)-z(2,iz-1))/(z(1,iz)-z(1,iz-1));
n = z(2,iz)-z(1,iz)*m;

i = 1;
while i <= length(sim_long)
    Pz(i) = m*sim_long(i)+n;
    if sim_long(i) >= z(1,iz)
        iz = iz+1;
        m = (z(2,iz)-z(2,iz-1))/(z(1,iz)-z(1,iz-1));
        n = z(2,iz)-z(1,iz)*m;
        Pz(i) = m*sim_long(i)+n;
    end
    i = i+1;
end

% Save data
layout = P(3:4,:);
sector = P(5,:);
layoutL = PL(3:4,:);
layoutR = PR(3:4,:);
P(3:5,:) = [];
PL(3:5,:) = [];
PR(3:5,:) = [];

track.profile.width = w;
track.profile.real_long = 5793;
track.profile.sim_long = sim_long;
track.profile.n_straights = 7;
track.profile.n_left_turns = 4;
track.profile.n_right_turns = 7;

track.surfaceXYZ.P = P;
track.surfaceXYZ.PL = PL;
track.surfaceXYZ.PR = PR;
track.surfaceXYZ.Pz = Pz;

track.layout.C = C;
track.layout.CL = CL;
track.layout.CR = CR;

track.layout.L = layout;
track.layout.LL = layoutL;
track.layout.LR = layoutR;

track.sectors.S = sector;
track.sectors.s1 = find(sector==1,1,'last');
track.sectors.s2 = find(sector==2,1,'last');
track.sectors.s3 = find(sector==3,1,'last');

% Clear
clearvars -regexp ^a\d{1}$ ^a\d{2}$ d e ^R\d{1}$ ^R\d{2}$ sim w o -except Select* env* save_track 

% FIGURES
mL = track.surfaceXYZ.PL;
mR = track.surfaceXYZ.PR;
s1 = track.sectors.s1;
s2 = track.sectors.s2;
s3 = track.sectors.s3;
P = track.surfaceXYZ.P;
Pz = track.surfaceXYZ.Pz;
sim_long = track.profile.sim_long;

figure('Name','TRACK.Sectors. Autodromo di Monza-Italy','NumberTitle','Off',...
    'units','normalized','outerposition',[0 0 1 1])
plot(mL(1,:),mL(2,:),'-k','linewidth',2);hold on;plot(mR(1,:),mR(2,:),'-k','linewidth',2);
plot(P(1,1:s1),P(2,1:s1),'-r','linewidth',3);
plot(P(1,s1:s2),P(2,s1:s2),'-y','linewidth',3);
plot(P(1,s2:s3),P(2,s2:s3),'-c','linewidth',3);
plot(P(1,1),P(2,1),'sk','MarkerFaceColor','k')%,'MarkerSize',10)
xlim([min(P(1,:))-100,max(P(1,:))+100]);ylim([min(P(2,:))-100,max(P(2,:))+100]);
xlabel('X [m]');ylabel('Y [m]');
title('Autodromo di Monza. Italy')

text(-1200,100,'S1','Color','r',...
'FontSize',14,'FontWeight','bold')
text(-1000,700,'S2','Color','y',...
'FontSize',14,'FontWeight','bold')
text(0,400,'S3','Color','c',...
'FontSize',14,'FontWeight','bold')
text(-20,35,'Start','Color','k','FontSize',10)

figure('Name','TRACK.3D Layout. Autodromo di Monza-Italy','NumberTitle','Off',...
    'units','normalized','outerposition',[0 0 1 1])
stem3(P(1,:),P(2,:),Pz-2,'Color',[0.5 0.5 0.5],'LineWidth',2);hold on;
plot3(mL(1,:),mL(2,:),Pz(1,:),'-k','linewidth',2);hold on;
plot3(mR(1,:),mR(2,:),Pz(1,:),'-k','linewidth',2);
plot3(P(1,1:s1),P(2,1:s1),Pz(1:s1),'-r','linewidth',3);grid minor;
plot3(P(1,s1:s2),P(2,s1:s2),Pz(s1:s2),'-y','linewidth',3);
plot3(P(1,s2:s3),P(2,s2:s3),Pz(s2:s3),'-c','linewidth',3);
zlim([0,max(Pz)*1.1])
xlabel('X [m]');ylabel('Y [m]');zlabel('Z [m]')
title('Autodromo di Monza. Italy')

figure('Name','TRACK.Height profile. Autodromo di Monza-Italy','NumberTitle','Off')
plot(sim_long(1:s1),Pz(1:s1),'-r','linewidth',3);hold on;
plot(sim_long((s1+1):s2),Pz((s1+1):s2),'-y','linewidth',3)
plot(sim_long((s2+1):s3),Pz((s2+1):s3),'-c','linewidth',3)
ylim([0,max(Pz)*1.1]);yticks([0:10:max(Pz)*1.1]);
xticks([0:500:max(sim_long)]);
legend('Sector 1','Sector 2','Sector 3')
xlabel('Distance [m]');ylabel('Height [m]')

clearvars -regexp P m s C -except Select* env* save_track
clearvars ccz cz nz z

if save_track == 1
    save('track\track_models\Monza_v2','track')
end

clearvars save_track -except Select* env*

% toc

