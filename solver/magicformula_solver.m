function [Fx,Fy,Mz] = magicformula_solver(type,tyre,Fz,camber)
    Fz = Fz/1000;
    slip = 8.5;
    switch type
        case 1 % Longitudinal
            C = tyre.b0;
            D = Fz*(tyre.b1*Fz+tyre.b2);
            BCD = (tyre.b3*Fz^2+tyre.b4*Fz)*exp(-tyre.b5*Fz);
            B = BCD/(C*D);
            Sh = tyre.b9*Fz+tyre.b10;
            Sv = tyre.b11*Fz+tyre.b12;
            E = (tyre.b6*Fz^2+tyre.b7*Fz+tyre.b8);
            Bx = B*(slip+Sh);
            
            Fx = abs(D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+Sv);
            Fy = 0;
            Mz = 0;
        case 2 % Lateral
            C = tyre.a0;
            D = Fz*(tyre.a1*Fz+tyre.a2);
            BCD = tyre.a3*sin(atan(Fz/tyre.a4)*2)*(1-tyre.a5*abs(camber));
            B = BCD/(C*D);
            Sh = tyre.a8*camber+tyre.a9*Fz+tyre.a10;
            Sv = tyre.a11*Fz*camber+tyre.a12*Fz+tyre.a13;
            E = (tyre.a6*Fz+tyre.a7);
            Bx = B*(slip+Sh);
            
            Fy = abs(D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+Sv);
            
            C = tyre.c0;
            D = Fz*(tyre.c1*Fz+tyre.c2);
            BCD = (tyre.c3*Fz^2+tyre.c4^Fz)*(1-tyre.c6*abs(camber))*exp(-tyre.c5*Fz);
            B = BCD/(C*D);
            Sh = tyre.c11*camber+tyre.c12*Fz+tyre.c13;
            Sv = (tyre.c14*Fz^2+tyre.c15*Fz)*camber+tyre.c16*Fz+tyre.c17;
            E = (tyre.c7*Fz^2+tyre.c8*Fz+tyre.c9)*(1-tyre.c10*abs(camber));
            Bx = B*(slip+Sh);
            
            Mz = abs(D*sin(C*atan(Bx-E*(Bx-atan(Bx))))+Sv);
            Fx = 0;
    end
end

