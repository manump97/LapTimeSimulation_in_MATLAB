 function [P,C] = ParamStraight(P,C,sector,P1,n)
% Parametrizar una recta y = mx + c
% ----- INICIALIZANDO VARIABLES -----
% x0 = Punto inicial recta (segmento)
% x1 = Punto final recta (segmento)
path = 0;

if length(P1) > 1 && n < 0;
    n = abs(n);
    path = 1;
elseif length(P1) == 1 && n < 0;
    n = abs(n);
    path = 1;
end

% CUALQUIER SEGMENTO
if P(3,end) > 0 && length(P1) == 1;

    Px = P(1,:);
    Py = P(2,:);
    Pmode = P(3,:);
    Pangle = P(4,:);
    Psector = P(5,:);
    vector = [Px(end)-Px(end-1) Py(end)-Py(end-1)];
    if length(P(1,:)) > 1;
       P(:,end)=[];
    end
    distance = P1;

    % Horizontales
    if abs(vector(2)) < 1e-5;
        if vector(1) >= 0;
            paso = distance/n;
        else
            paso = -distance/n;
        end

        x0x = P(1,end);
        x0y = P(2,end);
        m = vector(2)/vector(1);
        c = x0y - m*x0x;

        i = 1;
        d = length(P(1,:))-1;
        p = 0;

        while i <= n;
            Px(i+d)= x0x+paso*p;
            Py(i+d)= m*paso*p+c;
            Pmode(i+d)= 0;
            Pangle(i+d) = 0;
            Psector(i+d) = sector;
            i = i+1;
            p = p+1;
        end
    % Verticales
    elseif abs(vector(1)) < 1e-5;
        if vector(2) >= 0;
            paso = distance/(n);
        else
            paso = -distance/(n);
        end
        x0x = P(1,end);
        x0y = P(2,end);
        i = 1;
        d = length(P(1,:))-1;
        p = 0;
        while i <= n;
            Px(i+d)= x0x;
            Py(i+d)= x0y+paso*p;
            Pmode(i+d)= 0;
            Pangle(i+d) = 0;
            Psector(i+d) = sector;
            i = i+1;
            p = p+1;
        end
    % DIAGONALES
    else
        x0x = Px(end-1);
        x0y = Py(end-1);
        m = vector(2)/vector(1);
        c = x0y - m*x0x;
        vn = vector/norm(vector);

        if vector(1) > 0;
            paso = (abs(vn(1))*distance)/n; 
        elseif vector(1) < 0;
            paso = -(abs(vn(1))*distance)/n;
        end
        i = 1;
        d = length(P(1,:))-1;
        p = 0;
        while i <= n;
            Px(i+d)= x0x+paso*p;
            Py(i+d)= m*(x0x+paso*p)+c;
            Pmode(i+d)= 0;
            Pangle(i+d)= 0;
            Psector(i+d) = sector;
            i = i+1;
            p = p+1;
        end     
    end
    P = [Px;Py;Pmode;Pangle;Psector];
% INICIO TRACK
elseif P1(1) == 0 && P1(2) ~= 0;
    if length(P(1,:)) > 1;
        P(:,end)=[];
    end
    x0x = P(1,end);
    x0y = P(2,end);
    x1x = P1(1)+x0x;
    x1y = P1(2)+x0y;
    
    Px = P(1,:);
    Py = P(2,:);
    Pmode = P(3,:);
    Pangle = P(4,:);
    Psector = P(5,:);
    
    vector = [x1x-x0x,x1y-x0y];
    distance = norm(vector);
    if P1(2) < 0;
        paso = -distance/n;
    else
        paso = distance/n;
    end
    i = 1;
    d = length(P(1,:))-1;
    p = 0;
    while i <= n;
        Px(i+d)= x0x;
        Py(i+d)= x0y+paso*p;
        Pmode(i+d)= 0;
        Pangle(i+d) = 0;
        Psector(i+d) = sector;
        i = i+1;
        p = p+1;
    end
    P = [Px;Py;Pmode;Pangle;Psector];
else
    if length(P1) > 1;
        if length(P(1,:)) > 1;
            P(:,end)=[];
        end
        x0x = P(1,end);
        x0y = P(2,end);
        x1x = P1(1)+x0x;
        x1y = P1(2)+x0y;
        
        m = (x1y-x0y)/(x1x-x0x);
        c = x0y - m*x0x;
        Px = P(1,:);
        Py = P(2,:);
        Pmode = P(3,:);
        Pangle = P(4,:);
        Psector = P(5,:);
        % Iteramos para conseguir n puntos de la recta.
        x = x0x;
        w = (x1x-x0x)/(n); % Si en vez de queres Trazos, queremos Ptos escribir: n+1
        i = 1;
        d = length(P(1,:))-1;
        while n+1 >= i; % n+2, puesto que queremos el punto inicial y final. Si en vez de Trazos, queremos Ptos escribir: n+2
            y = m*x+c;
            Px(i+d)= x;
            Py(i+d)= y;
            Pmode(i+d) = 0;
            Pangle(i+d) = 0;
            Psector(i+d) = sector;
            x = x+w;
            i = i+1;
        end    
    end
    P = [Px;Py;Pmode;Pangle;Psector];
end
% Guardamos X e Y en Matrices.
% Devoldemos una Matriz P de forma [Xi,Yi] para cualquier i.
P = [Px;Py;Pmode;Pangle;Psector];

if n == 1;
    Pmode(end) = 0;
end

Px = P(1,:);
Py = P(2,:);
% ----- PLOTEAR -----
if path == 1;
    plot(Px,Py,'-k','linewidth',1)
    xlabel('X [m]')
    ylabel('Y [m]')
else
    plot(Px,Py,'-c')
    hold on
    plot(Px,Py,'.b')
    xlabel('X [m]')
    ylabel('Y [m]')
end
% -------------------
C(:,end+1)= [0;0];
end

