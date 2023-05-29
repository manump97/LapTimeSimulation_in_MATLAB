% Longitudinal Dynamics BRAKING %
% Extraer variables simples
kin = stv.kin;
aero = stv.aero;
tyr = stv.tyre;
pt = stv.pwt;
driv = stv.driver;
Pz = tck.surfaceXYZ.Pz;
dist = tck.profile.sim_long;

if dot_entry == dot % Velocidad de entrada en curva
    % Tyre forces
    [Fx_F,Fy_F,Mz_F] = magicformula_solver(2,tyre,tyr.Fz_F(1)/2,car.camber);
    bFx_F(dot) = Fx_F;
    bFy_F(dot) = Fy_F;
    bMz_F(dot) = Mz_F;

    [Fx_R,Fy_R,Mz_R] = magicformula_solver(2,tyre,tyr.Fz_R(1)/2,car.camber);   
    bFx_R(dot) = Fx_R;
    bFy_R(dot) = Fy_R;
    bMz_R(dot) = Mz_R;
    
    % Speed
    bv(dot) = sqrt(raceline(6,status).*(bFy_F(dot)+bFy_R(dot))/car.m); % Revisar las fuerzas resistentes
    % Aero
    bFdrag(dot) = 0.5*car.Af*car.Cd*env.d*bv(dot).^2;
    bFlift(dot) = 0.5*car.Af*car.Cl*env.d*bv(dot).^2;
    
    % Rolling Resistance y Radius
    bFz_index_F(dot) = (tyre.Fz0-tyr.Fz_F(1)).^(tyre.Fz_exp-1); % Statis weight
    bFz_index_R(dot) = (tyre.Fz0-tyr.Fz_R(1)).^(tyre.Fz_exp-1); % Statis weight

    bvx_index(dot) = tyre.v0+tyre.v1.*bv(dot)+tyre.v2.*bv(dot).^2;

    bCrr_F(dot) = tyr.p_index.*bFz_index_F(dot).*bvx_index(dot);
    bRr_F(dot) = bCrr_F(dot).*tyr.Fz_F(1);

    bCrr_R(dot) = tyr.p_index.*bFz_index_R(dot).*bvx_index(dot);
    bRr_R(dot) = bCrr_R(dot).*tyr.Fz_R(1);
    
    % Reparto de pesos (Moments Front Axe)
    slope = atand((Pz(dot)-Pz(dot-1))/(dist(dot)-dist(dot-1)));

    Mmass = car.m*env.g*(car.zCG*sind(slope)+car.xCG*cosd(slope));
    Maero = bFlift(dot).*car.xCP+bFdrag(dot).*car.zCP;
    Miner = car.m*abs(kin.ax(1)).*car.zCG;

    bFz_R(dot) = ((Mmass+Maero)-(Miner))/car.L;
    bFz_F(dot) = car.m*env.g*cosd(slope)+bFlift(dot)-bFz_R(dot);
    
    % Tyre maximum forces
    [Fx_F,Fy_F,Mz_F] = magicformula_solver(2,tyre,bFz_F(dot)/2,car.camber);
    bFx_F(dot) = Fx_F;
    bFy_F(dot) = Fy_F;
    bMz_F(dot) = Mz_F;

    [Fx_R,Fy_R,Mz_R] = magicformula_solver(1,tyre,bFz_R(dot)/2,car.camber);   
    bFx_R(dot) = Fx_R;
    bFy_R(dot) = Fy_R;
    bMz_R(dot) = Mz_R;
    
    % Engine maximum forces
%     run powertrain_solver_down.m
% -------------
%     bgear = pt.gear;
    bgear = pwt.gear_matrix(round(bv(dot)));
    bwo(dot) = (bv(dot)*3.6)/tyr.R_F;
    bn(dot) = (bwo(dot).*pwt.gear_r(bgear))*(60/(2*pi))+pwt.min_n;
    btorque(dot) = polyval(pwt.interp_coef,bn(dot));
    bwtorque(dot) = btorque(dot).*pwt.gear_r(bgear);%.*pwt.diff;
    bFx(dot) = (bwtorque(dot).*pwt.diff(bgear))/tyr.R_F;
    bpower(dot) = btorque(dot).*bn(dot);
% ----------------

    Fuerzas_resistentes = (bFdrag(dot)+bRr_F(dot)+bRr_R(dot)+(car.MbrakingF+car.MbrakingR)/car.Rg);%
    Fuerzas_traccion = 0;

% Kinematics
    bax(dot) = -(bFdrag(dot)+bRr_F(dot)+bRr_R(dot)+(car.MbrakingF+car.MbrakingR)/car.Rg+car.m*env.g*sind(slope))/car.m;
    bay(dot) = 0;
    bvy(dot) = 0;
    btime(dot) = 0;
    
else
    [Fx_F,Fy_F,Mz_F] = magicformula_solver(2,tyre,bFz_F(dot+1)/2,car.camber);
    bFx_F(dot) = Fx_F;
    bFy_F(dot) = Fy_F;
    bMz_F(dot) = Mz_F;

    [Fx_R,Fy_R,Mz_R] = magicformula_solver(2,tyre,bFz_R(dot+1)/2,car.camber);   
    bFx_R(dot) = Fx_R;
    bFy_R(dot) = Fy_R;
    bMz_R(dot) = Mz_R;
    
    % Speed
    bax(dot) = -(bFdrag(dot+1)+bRr_F(dot+1)+bRr_R(dot+1)+(2.*car.MbrakingF+2.*car.MbrakingR)/car.Rg+car.m*env.g*sind(slope))/car.m;
    bay(dot) = 0;
    bv(dot) = abs(sqrt(2*-bax(dot)*(dist(dot+1)-dist(dot))+(bv(dot+1).^2)));
    bvy(dot) = 0;
    btime(dot) = ((bv(dot+1)-bv(dot))/bax(dot));
    % Aero
    bFdrag(dot) = 0.5*car.Af*car.Cd*env.d*bv(dot).^2;
    bFlift(dot) = 0.5*car.Af*car.Cl*env.d*bv(dot).^2;
    
    % Rolling Resistance y Radius
    bFz_index_F(dot) = (tyre.Fz0-bFz_F(dot+1)).^(tyre.Fz_exp-1); % Static weight
    bFz_index_R(dot) = (tyre.Fz0-bFz_R(dot+1)).^(tyre.Fz_exp-1); % Static weight

    bvx_index(dot) = tyre.v0+tyre.v1.*bv(dot)+tyre.v2.*bv(dot).^2;

    bCrr_F(dot) = tyr.p_index.*bFz_index_F(dot).*bvx_index(dot);
    bRr_F(dot) = bCrr_F(dot).*bFz_F(dot+1);

    bCrr_R(dot) = tyr.p_index.*bFz_index_R(dot).*bvx_index(dot);
    bRr_R(dot) = bCrr_R(dot).*bFz_R(dot+1);
    
    % Reparto de pesos (Moments Front Axe) - Revisar calculo de momentos
    slope = atand((-Pz(dot)+Pz(dot+1))/(-dist(dot)+dist(dot+1)));

    Mmass = car.m*env.g*(car.zCG*sind(slope)+car.xCG*cosd(slope));
    Maero = bFlift(dot).*car.xCP+bFdrag(dot).*car.zCP;
    Miner = car.m*abs(bax(dot)).*car.zCG;

    bFz_R(dot) = ((Mmass+Maero)-(Miner))/car.L;
    bFz_F(dot) = car.m*env.g*cosd(slope)+bFlift(dot)-bFz_R(dot);
    
    % Tyre maximum forces
    [Fx_F,Fy_F,Mz_F] = magicformula_solver(2,tyre,bFz_F(dot)/2,car.camber);
    bFx_F(dot) = Fx_F;
    bFy_F(dot) = Fy_F;
    bMz_F(dot) = Mz_F;

    [Fx_R,Fy_R,Mz_R] = magicformula_solver(1,tyre,bFz_R(dot)/2,car.camber);   
    bFx_R(dot) = Fx_R;
    bFy_R(dot) = Fy_R;
    bMz_R(dot) = Mz_R;
    
if pwt.type == 0 % Combustion
    % Calculate n from vehicle speed(gear ratio)
    bwo(dot) = (bv(dot+1)*3.6)/tyr.R_F;
    
    bn(dot) = (bwo(dot).*pwt.gear_r(bgear)*(60/(2*pi)))+pwt.min_n;
    if bn(dot) > pwt.n_lim_change
        n_col = find(pwt.n_matrix(bgear,:)==0);
        n_col = n_col(1);
        bgear = bgear+1;
        if bgear > length(pwt.gear_r)
            bgear = length(pwt.gear_r);
        end
        bn(dot) = pwt.n_matrix(bgear,n_col);
    else
        bgear = bgear;
    end
    btorque(dot) = polyval(pwt.interp_coef,bn(dot));

    bwtorque(dot) = btorque(dot).*pwt.gear_r(bgear);%.*pwt.diff;
    bFx(dot) = (bwtorque(dot).*pwt.diff(bgear))/tyr.R_F;
    
    bpower(dot) = btorque(dot).*bn(dot);
end

% -------------------

    Fuerzas_resistentes = (bFdrag(dot)+bRr_F(dot)+bRr_R(dot)+(car.MbrakingF+car.MbrakingR)/car.Rg);%
    Fuerzas_traccion = 0;

end