function [P,C] = ParamArcTag(P,C,sector,R,alpha,n,recta)
% ----- INICIALIZANDO VARIABLES -----
% x0,y0 = Centro Circumferencia
% r = Radio Curva
% alpha = Ángulo barrido
% n =  Número de ptos dados en la curva
n = n+1; % n  = n+1  El primer y último punto.
if recta ~= 1;
    recta = R/2;% Longitud del vector tangente posterior al punto final.
end
%% RECTAS
if P(3,end) == 0;
    Pn = [P(1,end)-P(1,end-1),P(2,end)-P(2,end-1)];
    V = Pn/(norm(Pn));
    if V(1)==0;
        Vper = [-(alpha/abs(alpha))*V(2),V(1)];
    elseif V(2)==0;
        Vper = [V(2),(alpha/abs(alpha))*V(1)];
    else
        Vper = [(-alpha/abs(alpha))*V(2),(alpha/abs(alpha))*V(1)];
    end
    Center_u = Vper.*R;
    Center = [Center_u(1)+P(1,end),Center_u(2)+P(2,end)];

    Px = P(1,:);
    Py = P(2,:);
    Pmode = P(3,:);
    Pangle = P(4,:);
    Psector = P(5,:);

    coseno = Center_u(1)/norm(Center_u);
    tangente = Center_u(2)/Center_u(1);

    if coseno >= 0 && tangente >= 0;
        % 1r Cuadrante                       
%         disp('1r Cuadrante');
        angulo = 180-atand(tangente);
    elseif coseno <= 0 && tangente <= 0;
        % 2n Cuadrante
%         disp('2n Cuadrante');
        if alpha < 0 && P(2,end)==P(2,end-1);
            angulo = atand(tangente);
%             disp('1')
        elseif Pn(1)>0 && Pn(2)>0
            angulo = -atand(tangente);
%             disp('2')
        elseif P(1,end)<P(1,end-1) && P(2,end)==P(2,end-1)
            angulo = atand(tangente);
%             disp('3')
        else            
            angulo = -atand(tangente);
%             disp('4')
        end
    elseif coseno <= 0 && tangente >= 0;
        % 3r Cuadrante
%         disp('3r Cuadrante');
        angulo = -atand(tangente);
    elseif coseno >= 0 && tangente <= 0;
        % 4t Cuadrante
%         disp('4t Cuadrante');
        angulo = 180-atand(tangente);
    else
        angulo = 0;
    end
    d = length(Px);
    dalpha = alpha/n;
    i = 1;
    while n>=i; 
         x = R*cosd(dalpha-angulo)+Center(1);
         y = R*sind(dalpha-angulo)+Center(2);
         Px(d+i)=x;
         Py(d+i)=y;
         if alpha > 0;
             Pmode(d+i)=-R;
         else
             Pmode(d+i)=R;
         end
         Pangle(d+i)=alpha;
         Psector(d+i)=sector;
         i=i+1;
         dalpha=dalpha+alpha/n;
         mode(d+i) = 1;
    end
    
    P = [Px;Py;Pmode;Pangle;Psector];
    
    % Mostrar Recta Tangente de salida_modo1
    Precta = [P(1,end)-Center(1),P(2,end)-Center(2)];
    V = Precta/(norm(Precta));
    if V(1)==0;
        Vper = [-(alpha/abs(alpha))*V(2),V(1)];
    elseif V(2)==0;
        Vper = [V(2),(alpha/abs(alpha))*V(1)];
    else
        Vper = [(-alpha/abs(alpha))*V(2),(alpha/abs(alpha))*V(1)];
    end
    Pfinal = Vper.*recta;   
    Tx = [P(1,end) Pfinal(1)+P(1,end)];
    Ty = [P(2,end) Pfinal(2)+P(2,end)];
    P(:,end+1)=[Tx(2);Ty(2);2;alpha;sector];
          
%% CURVAS
elseif P(3,end) ~= 0;
    Pn = [P(1,end)-P(1,end-1),P(2,end)-P(2,end-1)];
    V = Pn/(norm(Pn));
    if V(1) == 0 && V(2) > 0;
        Vper = [-(alpha/abs(alpha))*V(2),V(1)];
    elseif V(1) == 0 && V(2) < 0;
        Vper = [-(alpha/abs(alpha))*V(2),V(1)];
    elseif V(2)==0;
        Vper = [V(2),(alpha/abs(alpha))*V(1)];
    else
        Vper = [(-alpha/abs(alpha))*V(2),(alpha/abs(alpha))*V(1)];
    end
    Center_u = Vper.*R;
    P(:,end) = [];
    Center = [Center_u(1)+P(1,end),Center_u(2)+P(2,end)];
    Px = P(1,:);
    Py = P(2,:);
    Pmode = P(3,:);
    Pangle = P(4,:);
    Psector = P(5,:);
    
    coseno = Center_u(1)/norm(Center_u);
    tangente = Center_u(2)/Center_u(1);

    if coseno >= 0 && tangente >= 0;
        % 1r Cuadrante                       
%         disp('1r Cuadrante');
        angulo = 180-atand(tangente);
    elseif coseno <= 0 && tangente <= 0;
        % 2n Cuadrante
%         disp('2n Cuadrante');
        if alpha < 0 && P(2,end)==P(2,end-1);
            angulo = atand(tangente);
%             disp('1')
        elseif Pn(1)>0 && Pn(2)>0
            angulo = -atand(tangente);
%             disp('2')
        elseif P(1,end)<P(1,end-1) && P(2,end)==P(2,end-1)
            angulo = atand(tangente);
%             disp('3')
        else            
            if Vper(1) == P(1,end-1);
                angulo = -atand(tangente);
%                 disp('4.1')
            else
                if Vper(1) == 0;
                    angulo = 180-atand(tangente);
                else
                    angulo = -atand(tangente);
                end
%                 disp('4.2')
            end
%             disp('4')
        end
    elseif coseno <= 0 && tangente >= 0;
%         3r Cuadrante
%         disp('3r Cuadrante');
        angulo = -atand(tangente);
    elseif coseno >= 0 && tangente <= 0;
        % 4t Cuadrante
%         disp('4t Cuadrante');
        angulo = 180-atand(tangente);
    else
        angulo = 0;
    end
    d = length(Px);
    n = n-1;
    dalpha = alpha/n;
    i = 1;
    while n>=i;
         x = R*cosd(dalpha-angulo)+Center(1);
         y = R*sind(dalpha-angulo)+Center(2);
         Px(d+i)=x;
         Py(d+i)=y;
         if alpha > 0;
             Pmode(d+i)=-R;
         else
             Pmode(d+i)=R;
         end
         Pangle(d+i)=alpha;
         Psector(d+i)=sector;
         i=i+1;
         dalpha=dalpha+alpha/n;
         mode(d+i) = 1;
    end
    
    P = [Px;Py;Pmode;Pangle;Psector];
    
    % Mostrar Recta Tangente de salida_modo1
    Precta = [P(1,end)-Center(1),P(2,end)-Center(2)];
    V = Precta/(norm(Precta));
    if V(1)==0;
        Vper = [-(alpha/abs(alpha))*V(2),V(1)];
    elseif V(2)==0;
        Vper = [V(2),(alpha/abs(alpha))*V(1)];
    else
        Vper = [(-alpha/abs(alpha))*V(2),(alpha/abs(alpha))*V(1)];
    end
    Pfinal = Vper.*recta;   
    Tx = [P(1,end) Pfinal(1)+P(1,end)];
    Ty = [P(2,end) Pfinal(2)+P(2,end)];
    P(:,end+1)=[Tx(2);Ty(2);2;alpha;sector];

end

%% GRAFICAR
if recta == 1;
    plot(Px,Py,'-k','linewidth',1)
    xlabel('X [m]')
    ylabel('Y [m]')
else
%     plot(Tx,Ty,'--b')
%     hold on
%     plot(Tx,Ty,'.m','Markersize',12)
    plot(Px,Py,'-c');hold on
    plot(Px,Py,'.b','Markersize',8)
    plot(Center(1),Center(2),'.k','Markersize',16)
    xlabel('X [m]')
    ylabel('Y [m]')
end
C(:,end+1)= [Center(1);Center(2)];
end




