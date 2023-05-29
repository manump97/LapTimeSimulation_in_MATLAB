% Monaco Track Model v3
%close all;clear all;%clc;
% tic
sim = 0;
save_track = 0;

% SET ORIGINS
w = 8; % Track Width [m]
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
d1 = [22 14];           e1s = round(abs(sqrt(22^2+14^2))*ratio)+1;
R2 = 250; a2 = -25;     e2c = round(2*pi*R2*(abs(a2)/360)*ratio)+1;
R3 = 120; a3 = 10;      e3c = round(2*pi*R3*(abs(a3)/360)*ratio)+1;
d301 = 5;                e301s = round(abs(d301)*ratio);
R4 = 15; a4 = -85;      e4c = round(2*pi*R4*(abs(a4)/360)*ratio)+1;
d5 = 90;                e5s = round(abs(d5)*ratio);
R6 = 370; a6 = 10;      e6c = round(2*pi*R6*(abs(a6)/360)*ratio)+1;
d7 = 55;                e7s = round(abs(d7)*ratio);
R8 = 370; a8 = -10;     e8c = round(2*pi*R8*(abs(a8)/360)*ratio)+1;
R9 = 150; a9 = 35;      e9c = round(2*pi*R9*(abs(a9)/360)*ratio)+1;
R10 = 300; a10 = -20;   e10c = round(2*pi*R10*(abs(a10)/360)*ratio)+1;
d101 = 5;                e101s = round(abs(d101)*ratio);
R11 = 75; a11 = 140;     e11c = round(2*pi*R11*(abs(a11)/360)*ratio)+1;
d111 = 5;                e111s = round(abs(d111)*ratio);
R12 = 40; a12 = -95;     e12c = round(2*pi*R12*(abs(a12)/360)*ratio)+1;
d13 = 180;              e13s = round(abs(d13)*ratio);
% Sector 2
R14 = 20; a14 = -90;     e14c = round(2*pi*R14*(abs(a14)/360)*ratio)+1;
d141 = 5;                e141s = round(abs(d141)*ratio);
R15 = 40; a15 = -50;     e15c = round(2*pi*R15*(abs(a15)/360)*ratio)+1;
R16 = 30; a16 = 30;     e16c = round(2*pi*R16*(abs(a16)/360)*ratio)+1;
d17 = 45;                e17s = round(abs(d17)*ratio);
R18 = 10; a18 = 185;     e18c = round(2*pi*R18*(abs(a18)/360)*ratio)+1;
d19 = 40;                e19s = round(abs(d19)*ratio);
R20 = 20; a20 = -115;     e20c = round(2*pi*R20*(abs(a20)/360)*ratio)+1;
d21 = 45;                e21s = round(abs(d21)*ratio);
R22 = 20; a22 = -115;     e22c = round(2*pi*R22*(abs(a22)/360)*ratio)+1;
d23 = 150;                e23s = round(abs(d23)*ratio);
R24 = 350; a24 = -70;     e24c = round(2*pi*R24*(abs(a24)/360)*ratio)+1;
d25 = 90;     e25s = round(abs(d25)*ratio);
% Sector 3
R26 = 10; a26 = 90;     e26c = round(2*pi*R26*(abs(a26)/360)*ratio)+1;
d27 = 6;                e27s = round(abs(d27)*ratio);
R28 = 8; a28 = -155;     e28c = round(2*pi*R28*(abs(a28)/360)*ratio)+1;
d281 = 2;                e281s = round(abs(d281)*ratio);
R29 = 35; a29 = 50;     e29c = round(2*pi*R29*(abs(a29)/360)*ratio)+1;
d30 = 200;                e30s = round(abs(d30)*ratio);
R31 = 40; a31 = 80;     e31c = round(2*pi*R31*(abs(a31)/360)*ratio)+1;
d311 = 5;                e311s = round(abs(d311)*ratio);

R32 = 200; a32 = 30;     e32c = round(2*pi*R32*(abs(a32)/360)*ratio)+1;

R33 = 30; a33 = 45;     e33c = round(2*pi*R33*(abs(a33)/360)*ratio)+1;
R34 = 30; a34 = -45;     e34c = round(2*pi*R34*(abs(a34)/360)*ratio)+1;
d35 = 85;                e35s = round(abs(d35)*ratio);
R36 = 25; a36 = -45;     e36c = round(2*pi*R36*(abs(a36)/360)*ratio)+1;
d361 = 15;                e361s = round(abs(d361)*ratio);
R37 = 25; a37 = 45;     e37c = round(2*pi*R37*(abs(a37)/360)*ratio)+1;
d371 = 5;                e371s = round(abs(d371)*ratio);
R38 = 145; a38 = 45;     e38c = round(2*pi*R38*(abs(a38)/360)*ratio);
R39 = 30; a39 = -75;     e39c = round(2*pi*R39*(abs(a39)/360)*ratio);
d391 = 5;                e391s = round(abs(d391)*ratio);
R40 = 10; a40 = -70;     e40c = round(2*pi*R40*(abs(a40)/360)*ratio)+1;
d41 = 60;                e41s = round(abs(d41)*ratio);
R42 = 10; a42 = -90;     e42c = round(2*pi*R42*(abs(a42)/360)*ratio);
R43 = 30; a43 = 37;      e43c = round(2*pi*R43*(abs(a43)/360)*ratio);
d431 = 5;                e431s = round(abs(d431)*ratio);
R44 = 320; a44 = -34;     e44c = round(2*pi*R44*(abs(a44)/360)*ratio)+1;
d45 = 130;                e45s = round(abs(d45)*ratio);

% Segments
figure('Name','TRACK.Layout. Circuito de Monte Carlo. Mónaco','NumberTitle','Off',...
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
[P,C] = ParamArcTag(P,C,1,R3,a3,e3c,10);
[PL,CL] = ParamArcTag(PL,CL,1,R3-w/2,a3,e3c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R3+w/2,a3,e3c,1);
% 301
[P,C] = ParamRecta(P,C,1,d301,e301s);
[PL,CL] = ParamRecta(PL,CL,1,d301,-e301s);
[PR,CR] = ParamRecta(PR,CR,1,d301,-e301s);
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
[PL,CL] = ParamArcTag(PL,CL,1,R6-w/2,a6,e6c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R6+w/2,a6,e6c,1);
% 7
[P,C] = ParamRecta(P,C,1,d7,e7s);
[PL,CL] = ParamRecta(PL,CL,1,d7,-e7s);
[PR,CR] = ParamRecta(PR,CR,1,d7,-e7s);
% 8
[P,C] = ParamArcTag(P,C,1,R8,a8,e8c,10);
[PL,CL] = ParamArcTag(PL,CL,1,R8+w/2,a8,e8c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R8-w/2,a8,e8c,1);
% 9 
[P,C] = ParamArcTag(P,C,1,R9,a9,e9c,10);
[PL,CL] = ParamArcTag(PL,CL,1,R9+w/2,a9,e9c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R9-w/2,a9,e9c,1);
% 10
[P,C] = ParamArcTag(P,C,1,R10,a10,e10c,10);
[PL,CL] = ParamArcTag(PL,CL,1,R10-w/2,a10,e10c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R10+w/2,a10,e10c,1);
% 101
[P,C] = ParamRecta(P,C,1,d101,e101s);
[PL,CL] = ParamRecta(PL,CL,1,d101,-e101s);
[PR,CR] = ParamRecta(PR,CR,1,d101,-e101s);
% 11
[P,C] = ParamArcTag(P,C,1,R11,a11,e11c,10);
[PL,CL] = ParamArcTag(PL,CL,1,R11+w/2,a11,e11c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R11-w/2,a11,e11c,1);
% 111
[P,C] = ParamRecta(P,C,1,d111,e111s);
[PL,CL] = ParamRecta(PL,CL,1,d111,-e111s);
[PR,CR] = ParamRecta(PR,CR,1,d111,-e111s);
% 12
[P,C] = ParamArcTag(P,C,1,R12,a12,e12c,10);
[PL,CL] = ParamArcTag(PL,CL,1,R12-w/2,a12,e12c,1);
[PR,CR] = ParamArcTag(PR,CR,1,R12+w/2,a12,e12c,1);
% 13
[P,C] = ParamRecta(P,C,1,d13,e13s);
[PL,CL] = ParamRecta(PL,CL,1,d13,-e13s);
[PR,CR] = ParamRecta(PR,CR,1,d13,-e13s);
% 14 Sector 2
[P,C] = ParamArcTag(P,C,2,R14,a14,e14c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R14-w/2,a14,e14c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R14+w/2,a14,e14c,1);
% 141
[P,C] = ParamRecta(P,C,2,d141,e141s);
[PL,CL] = ParamRecta(PL,CL,2,d141,-e141s);
[PR,CR] = ParamRecta(PR,CR,2,d141,-e141s);
% 15
[P,C] = ParamArcTag(P,C,2,R15,a15,e15c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R15-w/2,a15,e15c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R15+w/2,a15,e15c,1);

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
[PL,CL] = ParamArcTag(PL,CL,2,R18+w/2,a18,e18c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R18-w/2,a18,e18c,1);
% 19
[P,C] = ParamRecta(P,C,2,d19,e19s);
[PL,CL] = ParamRecta(PL,CL,2,d19,-e19s);
[PR,CR] = ParamRecta(PR,CR,2,d19,-e19s);
% 20
[P,C] = ParamArcTag(P,C,2,R20,a20,e20c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R20-w/2,a20,e20c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R20+w/2,a20,e20c,1);
% 21
[P,C] = ParamRecta(P,C,2,d21,e21s);
[PL,CL] = ParamRecta(PL,CL,2,d21,-e21s);
[PR,CR] = ParamRecta(PR,CR,2,d21,-e21s);
% 22
[P,C] = ParamArcTag(P,C,2,R22,a22,e22c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R22-w/2,a22,e22c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R22+w/2,a22,e22c,1);
% 23
[P,C] = ParamRecta(P,C,2,d23,e23s);
[PL,CL] = ParamRecta(PL,CL,2,d23,-e23s);
[PR,CR] = ParamRecta(PR,CR,2,d23,-e23s);
% 24
[P,C] = ParamArcTag(P,C,2,R24,a24,e24c,10);
[PL,CL] = ParamArcTag(PL,CL,2,R24-w/2,a24,e24c,1);
[PR,CR] = ParamArcTag(PR,CR,2,R24+w/2,a24,e24c,1);
% 25
[P,C] = ParamRecta(P,C,2,d25,e25s);
[PL,CL] = ParamRecta(PL,CL,2,d25,-e25s);
[PR,CR] = ParamRecta(PR,CR,2,d25,-e25s);
% 26 Sector 3
[P,C] = ParamArcTag(P,C,3,R26,a26,e26c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R26+w/2,a26,e26c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R26-w/2,a26,e26c,1);
% 27
[P,C] = ParamRecta(P,C,3,d27,e27s);
[PL,CL] = ParamRecta(PL,CL,3,d27,-e27s);
[PR,CR] = ParamRecta(PR,CR,3,d27,-e27s);
% 28
[P,C] = ParamArcTag(P,C,3,R28,a28,e28c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R28-w/2,a28,e28c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R28+w/2,a28,e28c,1);
% 281
[P,C] = ParamRecta(P,C,3,d281,e281s);
[PL,CL] = ParamRecta(PL,CL,3,d281,-e281s);
[PR,CR] = ParamRecta(PR,CR,3,d281,-e281s);
% 29
[P,C] = ParamArcTag(P,C,3,R29,a29,e29c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R29+w/2,a29,e29c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R29-w/2,a29,e29c,1);
% 30
[P,C] = ParamRecta(P,C,3,d30,e30s);
[PL,CL] = ParamRecta(PL,CL,3,d30,-e30s);
[PR,CR] = ParamRecta(PR,CR,3,d30,-e30s);
% 31
[P,C] = ParamArcTag(P,C,3,R31,a31,e31c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R31+w/2,a31,e31c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R31-w/2,a31,e31c,1);
% 311
[P,C] = ParamRecta(P,C,3,d311,e311s);
[PL,CL] = ParamRecta(PL,CL,3,d311,-e311s);
[PR,CR] = ParamRecta(PR,CR,3,d311,-e311s);
% 32
[P,C] = ParamArcTag(P,C,3,R32,a32,e32c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R32+w/2,a32,e32c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R32-w/2,a32,e32c,1);
% 33
[P,C] = ParamArcTag(P,C,3,R33,a33,e33c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R33+w/2,a33,e33c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R33-w/2,a33,e33c,1);
% 34
[P,C] = ParamArcTag(P,C,3,R34,a34,e34c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R34-w/2,a34,e34c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R34+w/2,a34,e34c,1);
% 35
[P,C] = ParamRecta(P,C,3,d35,e35s);
[PL,CL] = ParamRecta(PL,CL,3,d35,-e35s);
[PR,CR] = ParamRecta(PR,CR,3,d35,-e35s);
% 36
[P,C] = ParamArcTag(P,C,3,R36,a36,e36c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R36-w/2,a36,e36c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R36+w/2,a36,e36c,1);
% 361
[P,C] = ParamRecta(P,C,3,d361,e361s);
[PL,CL] = ParamRecta(PL,CL,3,d361,-e361s);
[PR,CR] = ParamRecta(PR,CR,3,d361,-e361s);
% 37
[P,C] = ParamArcTag(P,C,3,R37,a37,e37c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R37+w/2,a37,e37c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R37-w/2,a37,e37c,1);
% 371
[P,C] = ParamRecta(P,C,3,d371,e371s);
[PL,CL] = ParamRecta(PL,CL,3,d371,-e371s);
[PR,CR] = ParamRecta(PR,CR,3,d371,-e371s);
% 38
[P,C] = ParamArcTag(P,C,3,R38,a38,e38c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R38+w/2,a38,e38c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R38-w/2,a38,e38c,1);
% 39
[P,C] = ParamArcTag(P,C,3,R39,a39,e39c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R39-w/2,a39,e39c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R39+w/2,a39,e39c,1);
% 391
[P,C] = ParamRecta(P,C,3,d391,e391s);
[PL,CL] = ParamRecta(PL,CL,3,d391,-e391s);
[PR,CR] = ParamRecta(PR,CR,3,d391,-e391s);
% 40
[P,C] = ParamArcTag(P,C,3,R40,a40,e40c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R40-w/2,a40,e40c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R40+w/2,a40,e40c,1);
% 41
[P,C] = ParamRecta(P,C,3,d41,e41s);
[PL,CL] = ParamRecta(PL,CL,3,d41,-e41s);
[PR,CR] = ParamRecta(PR,CR,3,d41,-e41s);
% 42
[P,C] = ParamArcTag(P,C,3,R42,a42,e42c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R42-w/2,a42,e42c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R42+w/2,a42,e42c,1);
% 43
[P,C] = ParamArcTag(P,C,3,R43,a43,e43c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R43+w/2,a43,e43c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R43-w/2,a43,e43c,1);
% 431
[P,C] = ParamRecta(P,C,3,d431,e431s);
[PL,CL] = ParamRecta(PL,CL,3,d431,-e431s);
[PR,CR] = ParamRecta(PR,CR,3,d431,-e431s);
% 44
[P,C] = ParamArcTag(P,C,3,R44,a44,e44c,10);
[PL,CL] = ParamArcTag(PL,CL,3,R44-w/2,a44,e44c,1);
[PR,CR] = ParamArcTag(PR,CR,3,R44+w/2,a44,e44c,1);
% 45
[P,C] = ParamRecta(P,C,3,d45,e45s);
[PL,CL] = ParamRecta(PL,CL,3,d45,-e45s);
[PR,CR] = ParamRecta(PR,CR,3,d45,-e45s);

% FIGURE PARAMETERS
grid minor
xlim([min(P(1,:))-100,max(P(1,:))+100]);ylim([min(P(2,:))-100,max(P(2,:))+100]);
title('Circuito de Monte Carlo. Mónaco')
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
% figure('Name','Distance Evolution. Circuito de Monte Carlo. Mónaco','NumberTitle','Off')
% plot(sim_long); hold on; grid minor;
% plot([0 length(sim_long)],[0 3337],'-r')
% xlabel('Points []');ylabel('Accumulative Distance [m]')

% Z coordinate
z = [0 120 420 500 560 690 800 900 1450 2080 2500 2850 3000 3337;
    5 5 25 25 33 33 43 43 8 4 4 2 5 5];

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
track.profile.real_long = 3337;
track.profile.sim_long = sim_long;
track.profile.n_straights = 7;
track.profile.n_left_turns = 11;
track.profile.n_right_turns = 15;

track.surfaceXYZ.P = P;
track.surfaceXYZ.PL = PR;
track.surfaceXYZ.PR = PL;
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

figure('Name','TRACK.Sectors. Circuito de Monte Carlo. Mónaco','NumberTitle','Off',...
    'units','normalized','outerposition',[0 0 1 1])
plot(mL(1,:),mL(2,:),'-k','linewidth',2);hold on;plot(mR(1,:),mR(2,:),'-k','linewidth',2);
plot(P(1,1:s1),P(2,1:s1),'-r','linewidth',3);
plot(P(1,s1:s2),P(2,s1:s2),'-y','linewidth',3);
plot(P(1,s2:s3),P(2,s2:s3),'-c','linewidth',3);
plot(P(1,1),P(2,1),'sk','MarkerFaceColor','k')%,'MarkerSize',10)
xlim([min(P(1,:))-100,max(P(1,:))+100]);ylim([min(P(2,:))-100,max(P(2,:))+100]);
xlabel('X [m]');ylabel('Y [m]');
title('Circuito de Monte Carlo. Mónaco')

text(350,-200,'S1','Color','r',...
'FontSize',14,'FontWeight','bold')
text(650,-400,'S2','Color','y',...
'FontSize',14,'FontWeight','bold')
text(0,-150,'S3','Color','c',...
'FontSize',14,'FontWeight','bold')
text(-20,20,'Start','Color','k','FontSize',10)

figure('Name','TRACK.3D Layout. Circuito de Monte Carlo. Mónaco','NumberTitle','Off',...
    'units','normalized','outerposition',[0 0 1 1])
stem3(P(1,:),P(2,:),Pz-2.5,'Color',[0.5 0.5 0.5],'LineWidth',2);hold on;
plot3(mL(1,:),mL(2,:),Pz(1,:),'-k','linewidth',2);hold on;
plot3(mR(1,:),mR(2,:),Pz(1,:),'-k','linewidth',2);
plot3(P(1,1:s1),P(2,1:s1),Pz(1:s1),'-r','linewidth',3); grid off;
plot3(P(1,s1:s2),P(2,s1:s2),Pz(s1:s2),'-y','linewidth',3);
plot3(P(1,s2:s3),P(2,s2:s3),Pz(s2:s3),'-c','linewidth',3);
zlim([-5,200])
xlabel('X [m]');ylabel('Y [m]');zlabel('Z [m]')
title('Circuito de Monte Carlo. Mónaco')

figure('Name','TRACK.Height profile. Circuito de Monte Carlo. Mónaco','NumberTitle','Off')
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

if save_track == 1;
    save('track\track_models\Monaco_v2','track')
end

clearvars save_track -except Select* env*

% toc

