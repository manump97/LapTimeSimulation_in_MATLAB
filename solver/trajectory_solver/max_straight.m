function [T] = max_straight(T0,i1,i2,num,type)
T = T0;
if type == [0 0 0]; % Inicio de recta 
    P0 = [T(1,i1);T(2,i1)];
    Pn = [T(1,i2);T(2,i2)];
    vn = Pn-P0;
    cont = 1;
    mvn = norm(vn);
    dxn = vn(1)/num;
    mn = (vn(2))/(vn(1));
    nn = P0(2)-mn*P0(1);
    while cont < num;
        T(1,1+cont) = dxn*cont+P0(1);
        T(2,1+cont) = mn*(dxn*cont+P0(1))+nn;
        cont = cont+1;
    end  
    cont = cont-1;
elseif type == [1 1 1];
    P0 = [T(1,i1);T(2,i1)];
    Pn = [T(1,i2);T(2,i2)];
    vn = Pn-P0;
    cont = 1;
    mvn = norm(vn);
    dxn = vn(1)/num;
    mn = (vn(2))/(vn(1));
    nn = P0(2)-mn*P0(1);
    while cont < num;
        T(1,i1+cont) = dxn*cont+P0(1);
        T(2,i1+cont) = mn*(dxn*cont+P0(1))+nn;
        cont = cont+1;
    end  
    cont = cont-1;
else

    P1 = [T(1,i1);T(2,i1)];
    P2 = [T(1,i2);T(2,i2)];
    vp = P2-P1;

    i = 1;
    mvp = norm(vp);
    dx = (vp(1))/(num);
    if type == [1 0 1] | type == [-1 0 -1]; % Recta pura
        m = (vp(2))/(vp(1));
        n = P1(2)-m*P1(1);
        while i < num;
            T(1,i1+i) = dx*i+P1(1);
            T(2,i1+i) = m*(dx*i+P1(1))+n;
            i = i+1;
        end    
    elseif type == [1 0 -1]; % Recta S 1
        while i < num;
            T(1,i1+i) = 0;
            T(2,i1+i) = 0;
            i = i+1;
        end
    elseif type == [-1 0 1]; % Recta S 2
        while i < num;
            T(1,i1+i) = 0;
            T(2,i1+i) = 0;
            i = i+1;
        end
    end
    i = i-1;
end

plot(T(1,(i1+1):(i2)),T(2,(i1+1):(i2)),'.g','MarkerSize',15);hold on;
plot(T(1,i2),T(2,i2),'c','MarkerSize',15)
plot(T(1,i1),T(2,i1),'c','MarkerSize',15)
end

