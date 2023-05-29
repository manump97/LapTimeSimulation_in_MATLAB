function [T] = max_radius(T0,P0,P1,Plim,Sappex,R,alpha,n,curva)

% P0 = centro
% P1 = appex

Rint = Plim(1,:);
Rext = Plim(2,:);
T = T0;
v = (P1-P0)/(norm(P1-P0));
Cg = v.*R;

ux = [1,0];
uy = [0,1];
vdotux = v(1)*ux(1)+v(2)*ux(2);
anglex = acosd(vdotux/(norm(ux)*norm(v)));
vdotuy = v(1)*uy(1)+v(2)*uy(2);
angley = acosd(vdotuy/(norm(uy)*norm(v)));

if anglex <= 180 & angley <= 90; % 1r o 2n Cuadrante
    angle = anglex;
elseif angley > 90; % 3r o 4t Cuadrante
    angle = 360-anglex;
end

T(1,Sappex) = P1(1);
T(2,Sappex) = P1(2);
vCg = P1-Cg;
i = 0;
w = 0;
n = (floor(n+1)/2)-1; 

va1 = [Rint(1)-vCg(1),Rint(2)-vCg(2)];
vb = [P1(1)-vCg(1),P1(2)-vCg(2)];
beta1 = acosd(dot(va1,vb)/(norm(va1)*norm(vb)));

va2 = [Rext(1)-vCg(1),Rext(2)-vCg(2)];
beta2 = acosd(dot(va2,vb)/(norm(va2)*norm(vb)));

beta = (beta1+beta2)/2;

while i <= n ;
    if curva == -1;
        T(1,Sappex-i)=R*cosd(angle-w)+vCg(1);
        T(2,Sappex-i)=R*sind(angle-w)+vCg(2);
        T(1,Sappex+i)=R*cosd(angle+w)+vCg(1);
        T(2,Sappex+i)=R*sind(angle+w)+vCg(2);
        T(3,Sappex-i)= R;
        T(3,Sappex+i)= R;
    elseif curva == 1;
        T(1,Sappex-i)=R*cosd(angle+w)+vCg(1);
        T(2,Sappex-i)=R*sind(angle+w)+vCg(2);
        T(1,Sappex+i)=R*cosd(angle-w)+vCg(1);
        T(2,Sappex+i)=R*sind(angle-w)+vCg(2);
        T(3,Sappex-i)= R;
        T(3,Sappex+i)= R;
    end    
    i = i+1;
    w = (2*beta/(2*n))*i;
end
i = i-1;
plot(T(1,Sappex-i:Sappex+i),T(2,Sappex-i:Sappex+i),'.m','MarkerSize',10);hold on;
plot(T(1,Sappex-i:Sappex+i),T(2,Sappex-i:Sappex+i),'-r')
plot(vCg(1),vCg(2),'.r','MarkerSize',14)
plot(P1(1),P1(2),'.y','MarkerSize',14)
end

