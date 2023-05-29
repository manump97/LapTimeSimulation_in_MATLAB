% Montmelo Track Model v3
%close all;clear all;%clc;
% tic
sim = 0;
save_track = 0;

% SET ORIGINS
w = 15; % Track Width [m]
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
d1 = [-675,0];          e1s = round(abs(-675)*ratio);
R2 = 38; a2 = -80;      e2c = round(2*pi*R2*(abs(a2)/360)*ratio)+1;
d3 = 20;                e3s = round(abs(d3)*ratio);
R4 = 55; a4 = 60;       e4c = round(2*pi*R4*(abs(a4)/360)*ratio)+1;
d5 = 50;                e5s = round(abs(d5)*ratio);
R6 = 105; a6 = -80;     e6c = round(2*pi*R6*(abs(a6)/360)*ratio)+1;
R7 = 220; a7 = -80;     e7c = round(2*pi*R7*(abs(a7)/360)*ratio)+1;
d8 = 270;               e8s = round(abs(d8)*ratio);
% Sector 2
R9 = 53; a9 = -90;          e9c = round(2*pi*R9*(abs(a9)/360)*ratio)+1;
R10 = 105; a10 = -90;       e10c = round(2*pi*R10*(abs(a10)/360)*ratio)+1;
d11 = 190;                  e11s = round(abs(d11)*ratio);
R12 = 35; a12 = 135;        e12c = round(2*pi*R12*(abs(a12)/360)*ratio)+1;
d13 = 90;                   e13s = round(abs(d13)*ratio);
R14 = 165; a14 = 45;        e14c = round(2*pi*R14*(abs(a14)/360)*ratio)+1;
d15 = 95;                   e15s = round(abs(d15)*ratio);
R16 = 35; a16 = 100;        e16c = round(2*pi*R16*(abs(a16)/360)*ratio)+1;
R17 = 100; a17 = -45;       e17c = round(2*pi*R17*(abs(a17)/360)*ratio)+1;
d18 = 170;                  e18s = round(abs(d18)*ratio);
R19 = 80; a19 = -85;        e19c = round(2*pi*R19*(abs(a19)/360)*ratio)+1;
d20 = 480;                  e20s = round(abs(d20)*ratio);
% Sector 3
R21 = 15; a21 = 145;        e21c = round(2*pi*R21*(abs(a21)/360)*ratio)+1;
d22 = 85;                   e22s = round(abs(d22)*ratio);
R23 = 35; a23 = 45;         e23c = round(2*pi*R23*(abs(a23)/360)*ratio)+1;
d24 = 30;                   e24s = round(abs(d24)*ratio);
R25 = 55; a25 = -170;       e25c = round(2*pi*R25*(abs(a25)/360)*ratio)+1;
d26 = 140;                  e26s = round(abs(d26)*ratio);
R27 = 25; a27 = -90;        e27c = round(2*pi*R27*(abs(a27)/360)*ratio)+1;
d28 = 100;                  e28s = round(abs(d28)*ratio);
R29 = 15; a29 = 95;         e29c = round(2*pi*R29*(abs(a29)/360)*ratio)+1;
d30 = 20;                   e30s = round(abs(d30)*ratio);
R31 = 15; a31 = -85;        e31c = round(2*pi*R31*(abs(a31)/360)*ratio)+1;
d32 = 80;                   e32s = round(abs(d32)*ratio);
R33 = 84; a33 = -90;        e33c = round(2*pi*R33*(abs(a33)/360)*ratio)+1;
d34 = 364;                e34s = round(abs(d34)*ratio);

% Segments
figure('Name','TRACK.Layout. Circuito de Barcelona & Catalunya. Spain','NumberTitle','Off',...
    'units','normalized','outerposition',[0 0 1 1])
% 1 Sector 1
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
[P,C] = ParamArcTag(P,C,1,R7,a7,e7c,10);
[PL,CL] = ParamArcTag(PL,CL,1,R7+w/2,a7,e7c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R7-w/2,a7,e7c,1);
% 8
[P,C] = ParamRecta(P,C,1,d8,e8s);
[PL,CL] = ParamRecta(PL,CL,1,d8,-e8s);
[PR,CR] = ParamRecta(PR,CR,1,d8,-e8s);
% 9 Sector 2
[P,C] = ParamArcTag(P,C,2,R9,a9,e9c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R9+w/2,a9,e9c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R9-w/2,a9,e9c,1);
% 10
[P,C] = ParamArcTag(P,C,2,R10,a10,e10c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R10+w/2,a10,e10c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R10-w/2,a10,e10c,1);
% 11
[P,C] = ParamRecta(P,C,2,d11,e11s);
[PL,CL] = ParamRecta(PL,CL,2,d11,-e11s);
[PR,CR] = ParamRecta(PR,CR,2,d11,-e11s);
% 12
[P,C] = ParamArcTag(P,C,2,R12,a12,e12c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R12-w/2,a12,e12c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R12+w/2,a12,e12c,1);
% 13
[P,C] = ParamRecta(P,C,2,d13,e13s);
[PL,CL] = ParamRecta(PL,CL,2,d13,-e13s);
[PR,CR] = ParamRecta(PR,CR,2,d13,-e13s);
% 14
[P,C] = ParamArcTag(P,C,2,R14,a14,e14c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R14-w/2,a14,e14c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R14+w/2,a14,e14c,1);
% 15
[P,C] = ParamRecta(P,C,2,d15,e15s);
[PL,CL] = ParamRecta(PL,CL,2,d15,-e15s);
[PR,CR] = ParamRecta(PR,CR,2,d15,-e15s);
% 16
[P,C] = ParamArcTag(P,C,2,R16,a16,e16c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R16-w/2,a16,e16c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R16+w/2,a16,e16c,1);
% 17
[P,C] = ParamArcTag(P,C,2,R17,a17,e17c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R17+w/2,a17,e17c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R17-w/2,a17,e17c,1);
% 18
[P,C] = ParamRecta(P,C,2,d18,e18s);
[PL,CL] = ParamRecta(PL,CL,2,d18,-e18s);
[PR,CR] = ParamRecta(PR,CR,2,d18,-e18s);
% 19
[P,C] = ParamArcTag(P,C,2,R19,a19,e19c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R19+w/2,a19,e19c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R19-w/2,a19,e19c,1);
% 20
[P,C] = ParamRecta(P,C,2,d20,e20s);
[PL,CL] = ParamRecta(PL,CL,2,d20,-e20s);
[PR,CR] = ParamRecta(PR,CR,2,d20,-e20s);
% 21 Sector 3
[P,C] = ParamArcTag(P,C,3,R21,a21,e21c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R21-w/2,a21,e21c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R21+w/2,a21,e21c,1);
% 22
[P,C] = ParamRecta(P,C,3,d22,e22s);
[PL,CL] = ParamRecta(PL,CL,3,d22,-e22s);
[PR,CR] = ParamRecta(PR,CR,3,d22,-e22s);
% 23
[P,C] = ParamArcTag(P,C,3,R23,a23,e23c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R23-w/2,a23,e23c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R23+w/2,a23,e23c,1);
% 24
[P,C] = ParamRecta(P,C,3,d24,e24s);
[PL,CL] = ParamRecta(PL,CL,3,d24,-e24s);
[PR,CR] = ParamRecta(PR,CR,3,d24,-e24s);
% 25
[P,C] = ParamArcTag(P,C,3,R25,a25,e25c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R25+w/2,a25,e25c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R25-w/2,a25,e25c,1);
% 26
[P,C] = ParamRecta(P,C,3,d26,e26s);
[PL,CL] = ParamRecta(PL,CL,3,d26,-e26s);
[PR,CR] = ParamRecta(PR,CR,3,d26,-e26s);
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
[PL,CL] = ParamArcTag(PL,CL,3,R29-w/2,a29,e29c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R29+w/2,a29,e29c,1);
% 30
[P,C] = ParamRecta(P,C,3,d30,e30s);
[PL,CL] = ParamRecta(PL,CL,3,d30,-e30s);
[PR,CR] = ParamRecta(PR,CR,3,d30,-e30s);
% 31
[P,C] = ParamArcTag(P,C,3,R31,a31,e31c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R31+w/2,a31,e31c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R31-w/2,a31,e31c,1);
% 32
[P,C] = ParamRecta(P,C,3,d32,e32s);
[PL,CL] = ParamRecta(PL,CL,3,d32,-e32s);
[PR,CR] = ParamRecta(PR,CR,3,d32,-e32s);
% 33
[P,C] = ParamArcTag(P,C,3,R33,a33,e33c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R33+w/2,a33,e33c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R33-w/2,a33,e33c,1);
% 34
[P,C] = ParamRecta(P,C,3,d34,e34s);
[PL,CL] = ParamRecta(PL,CL,3,d34,-e34s);
[PR,CR] = ParamRecta(PR,CR,3,d34,-e34s);

% FIGURE PARAMETERS
grid minor
xlim([min(P(1,:))-100,max(P(1,:))+100]);ylim([min(P(2,:))-100,max(P(2,:))+100]);
title('Circuito de Barcelona & Catalunya. Spain')
plot(P(1,1),P(2,1),'sk','MarkerFaceColor','k')%,'MarkerSize',10)
text(-20,20,'Start','Color','k','FontSize',10)

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
% figure('Name','Distance Evolution. Circuit de Barcelona & Catalunya-Spain','NumberTitle','Off')
% plot(sim_long); hold on; grid minor;
% plot([0 length(sim_long)],[0 4655],'-r')
% xlabel('Points []');ylabel('Accumulative Distance [m]')

% Z coordinate
z = [0 250 600 835 1150 1700 1800 2000 2300 2400 2850 3000 3350 3450 3700 3800 4150 4400 4500 4655;
    120 120 113 113 125 133 133 128 114 114 136 136 131 131 142 142 128 122 120 120];

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
track.profile.real_long = 4655;
track.profile.sim_long = sim_long;
track.profile.n_straights = 16;
track.profile.n_left_turns = 7;
track.profile.n_right_turns = 11;

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
clearvars -regexp ^a\d{1}$ ^a\d{2}$ d e ^R\d{1}$ ^R\d{2}$ simu w o i -except Select* env* save_track

% FIGURES
mL = track.surfaceXYZ.PL;
mR = track.surfaceXYZ.PR;
s1 = track.sectors.s1;
s2 = track.sectors.s2;
s3 = track.sectors.s3;
P = track.surfaceXYZ.P;
Pz = track.surfaceXYZ.Pz;
sim_long = track.profile.sim_long;

figure('Name','TRACK.Sectors. Circuito de Barcelona & Catalunya. Spain','NumberTitle','Off',...
    'units','normalized','outerposition',[0 0 1 1])
plot(mL(1,:),mL(2,:),'-k','linewidth',2);hold on;plot(mR(1,:),mR(2,:),'-k','linewidth',2);
plot(P(1,1:s1),P(2,1:s1),'-r','linewidth',3);
plot(P(1,s1:s2),P(2,s1:s2),'-y','linewidth',3);
plot(P(1,s2:s3),P(2,s2:s3),'-c','linewidth',3);
plot(P(1,1),P(2,1),'sk','MarkerFaceColor','k')%,'MarkerSize',10)
xlim([min(P(1,:))-100,max(P(1,:))+100]);ylim([min(P(2,:))-100,max(P(2,:))+100]);
xlabel('X [m]');ylabel('Y [m]');
title('Circuito de Barcelona & Catalunya. Spain')

text(-800,200,'S1','Color','r',...
'FontSize',14,'FontWeight','bold')
text(-200,300,'S2','Color','y',...
'FontSize',14,'FontWeight','bold')
text(350,100,'S3','Color','c',...
'FontSize',14,'FontWeight','bold')
text(-20,20,'Start','Color','k','FontSize',10)

figure('Name','TRACK.3D Layout. Circuito de Barcelona & Catalunya. Spain','NumberTitle','Off',...
    'units','normalized','outerposition',[0 0 1 1])
stem3(P(1,:),P(2,:),Pz-2,'Color',[0.5 0.5 0.5],'LineWidth',2);hold on;
plot3(mL(1,:),mL(2,:),Pz(1,:),'-k','linewidth',2);hold on;
plot3(mR(1,:),mR(2,:),Pz(1,:),'-k','linewidth',2);
plot3(P(1,1:s1),P(2,1:s1),Pz(1:s1),'-r','linewidth',3);grid minor;
plot3(P(1,s1:s2),P(2,s1:s2),Pz(s1:s2),'-y','linewidth',3);
plot3(P(1,s2:s3),P(2,s2:s3),Pz(s2:s3),'-c','linewidth',3);
zlim([0,max(Pz)*1.1])
xlabel('X [m]');ylabel('Y [m]');zlabel('Z [m]')
title('Circuit de Barcelona & Catalunya. Spain')

figure('Name','TRACK.Height profile. Circuito de Barcelona & Catalunya. Spain','NumberTitle','Off')
plot(sim_long(1:s1),Pz(1:s1),'-r','linewidth',3);hold on;
plot(sim_long((s1+1):s2),Pz((s1+1):s2),'-y','linewidth',3)
plot(sim_long((s2+1):s3),Pz((s2+1):s3),'-c','linewidth',3)
ylim([0,max(Pz)*1.1]);yticks([0:10:max(Pz)*1.1]);
xticks([0:500:max(sim_long)]);
legend('Sector 1','Sector 2','Sector 3')
xlabel('Distance [m]');ylabel('Height [m]')
title('Height profile')

clearvars -regexp P m s C -except Select* env* save_track
clearvars ccz cz nz z

if save_track == 1
    save('track\track_models\Montmelo_v2','track')
end

clearvars save_track -except Select* env*

% toc

