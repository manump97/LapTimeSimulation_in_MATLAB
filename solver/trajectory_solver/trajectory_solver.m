% Solver_Trajectory
% close all;clear all;%clc;

PL = tck.surfaceXYZ.PL;
PR = tck.surfaceXYZ.PR;
P = tck.surfaceXYZ.P;
w = tck.profile.width;
R = tck.layout.L(1,:);
L = tck.layout.L(2,:);
C = tck.layout.C;

% Figure Inicial
figure('Name','SOLVER.TRAJ.Computation','Numbertitle','off')
plot(PL(1,:),PL(2,:),'-k');hold on;
plot(PR(1,:),PR(2,:),'-k');grid minor;
plot(P(1,:),P(2,:),'-c');plot(P(1,:),P(2,:),'.b')
xlabel('X [m]');ylabel('Y [m]')
title('Trajectory solver computation')

% ELEMENTS VECTOR
% Code
%       Straight: 0
%       Right Turn: 1
%       Left Turn: -1

% R = tck.tck1.layout.L(1,:);
% L = tck.tck1.layout.L(2,:);
% C = tck.tck1.layout.C;

% MATRIZ de Raceline
% 1 Tipo de elemento
% 2 Punto en el que empieza cada elemento
% 3 Radio
% 4 Angulo barrido
% 5 Punto en el que se encuentra el appex
% 6 Máximo Radio

raceline = [];

i = 2;
cont = 1;
if L(1) == 0
    raceline(1,cont) = 0;
elseif L(i) < 0
    raceline(1,cont) = 1;
elseif L(i) > 0
    raceline(1,cont) = -1;
end
raceline(2,cont) = 1;
raceline(3,cont) = R(1);
while i <= length(L) % Hay que mirar primero Swept Angle luego Radio.
    if ne(L(i),L(i-1)) | ne(R(i),R(i-1))
        cont = cont+1;
        if L(i) == 0
           raceline(1,cont) = 0; 
        elseif L(i) < 0
           raceline(1,cont) = 1;
        elseif L(i) > 0
           raceline(1,cont) = -1;
        end
        raceline(2,cont) = i-1;
        raceline(3,cont) = abs(R(i));
        raceline(4,cont) = abs(L(i));
    end
    i = i+1;
end

% Buscar APPEXs
i = 1;
while i <= length(raceline(1,:))
    if ne(raceline(1,i),0)
        raceline(5,i)=round((raceline(2,i+1)-raceline(2,i))/2)+raceline(2,i);
    end
    i = i+1;
end
raceline;

% SOLVER
i = 1;
while i <= length(raceline(1,:))
    if ne(raceline(3,i),0)
        raceline(6,i) = raceline(3,i)+(w/(1-cosd(raceline(4,i)))); %-(w/2); % Maximum Radius
    else
        raceline(6,i) = 0;
    end
    i = i+1;
end
radius(1,:)=raceline(3,:); % Radio central
radius(2,:)=raceline(6,:); % Radio máximo
radius(3,:)=raceline(4,:); % Ángulo barrido

% MATRIZ de Trayectoria T
% 1r Fila Coordenadas X
% 2n Fila Coordenadas Y
% 3r Fila Radio Máximo
% 4t Fila Ángulo barrido
nn = [raceline(2,:),length(P)];
T = zeros(4,length(P(1,:))); 

i = 1;
j = 1;
while i <= length(P(1,:))
    % Plot all the turns first
    while j <= length(raceline(1,:))
      if ne(raceline(1,j),0)
            Sappex = raceline(5,j)-1;
            Radius = raceline(6,j);
            alpha = raceline(4,j);
            n = nn(j+1)-nn(j);
            nplim = raceline(2,j);
            if raceline(1,j)==-1 
                if raceline(1,j+1) == 1 % Enlazada LR
                    Pappex = [PL(1,Sappex) PL(2,Sappex)];%
                    Plim = [PL(1,nplim) PL(2,nplim);PR(1,nplim) PR(2,nplim)];%
                elseif raceline(1,j+1) == -1 % Curva L de radio variable
                    Pappex = [PL(1,Sappex) PL(2,Sappex)];%
                    Plim = [PL(1,nplim) PL(2,nplim);PR(1,nplim) PR(2,nplim)];%
                else
                    Pappex = [PL(1,Sappex) PL(2,Sappex)];
                    Plim = [PL(1,nplim) PL(2,nplim);PR(1,nplim) PR(2,nplim)];
                end
            elseif raceline(1,j)==1
                if raceline(1,j+1) == -1 % Enlazada RL
                    Pappex = [PR(1,Sappex) PR(2,Sappex)];%
                    Plim = [PR(1,nplim) PR(2,nplim);PL(1,nplim) PL(2,nplim)];%
                elseif raceline(1,j+1) == 1 % Curva R de radio variable
                    Pappex = [PR(1,Sappex) PR(2,Sappex)];%
                    Plim = [PR(1,nplim) PR(2,nplim);PL(1,nplim) PL(2,nplim)];%
                else
                    Pappex = [PR(1,Sappex) PR(2,Sappex)];
                    Plim = [PR(1,nplim) PR(2,nplim);PL(1,nplim) PL(2,nplim)];
                end
            end
%             clc
            T = max_radius(T,C(:,j)',Pappex,Plim,Sappex,Radius,alpha,n,raceline(1,j));
            trajectory_correction
      end
      j = j+1;
    end
    i = i+1;
end
% T
% Plot all the straights
j = 2;
type = [];
while j <= length(raceline(1,:))-1
   if j == 2 % PRIMER TRAMO. Que haga también el inicio
        inter1 = nn(1);
        inter2 = nn(2);
        n = nn(2)-nn(1);
        type = [0 0 0];
        T = max_straight(T,inter1,inter2,n,type);
        
    elseif j == (length(raceline(1,:))-1) % ULTIMO TRAMOS. Que haga también el final
        T(1,end)= P(1,end);
        T(2,end)= P(2,end);
        inter1 = nn(end-1)-2;
        inter2 = nn(end);
        n = nn(end)-nn(end-1)+1;
        type = [1 1 1];
        T = max_straight(T,inter1,inter2,n,type);
        
	end
    if raceline(1,j) == 0
        inter1 = raceline(2,j)-2; 
        inter2 = raceline(2,j+1); 
        n = nn(j+1)-nn(j)+1; 
        type = [raceline(1,j-1) raceline(1,j) raceline(1,j+1)];
        T = max_straight(T,inter1,inter2,n,type);
     end
     j = j+1;
end
figure('Name','SOLVER.TRAJ.Optimal path','NumberTitle','Off',...
    'units','normalized','outerposition',[0 0 1 1])
plot(PL(1,:),PL(2,:),'-k');hold on;
plot(PR(1,:),PR(2,:),'-k');grid minor;
plot(P(1,:),P(2,:),'-c');
plot(T(1,:),T(2,:),'.m','MarkerSize',8)
plot(T(1,inter1),T(2,inter1),'.g','MarkerSize',10)
plot(T(1,inter2),T(2,inter2),'.g','MarkerSize',10)
xlabel('X [m]');ylabel('Y [m]')
title('Optimal trajectory path')

figure('Name','SOLVER.TRAJ.Plot Elements.','NumberTitle','Off')
plot(raceline(1,:),'.--b','MarkerSize',14)
xlabel('Number of track elements');ylabel('[-1,0,1] = [Left Turn,Straight,Right Turn]')
title('Trajectory layout')
% figure('Name','Hist Elements. tck 01','NumberTitle','Off')
% histogram(raceline(1,:))

% SAVE RESULTS
tck.trajectory.T = T;
tck.trajectory.raceline = raceline;
clearvars -except car env tck Select* stv tyre pwt

