% Longitudinal Dynamics %
% Extraer variables simples
kin = stv.kin;
aero = stv.aero;
tyr = stv.tyre;
pt = stv.pwt;
driv = stv.driver;
Pz = tck.surfaceXYZ.Pz;
dist = tck.profile.sim_long;

% Reparto de pesos (Moments Front Axe)
slope = atand((Pz(dot)-Pz(dot-1))/(dist(dot)-dist(dot-1)));

Mmass = car.m*env.g*(car.zCG*sind(slope)+car.xCG*cosd(slope));
Maero = aero.Flift(dot-1).*car.xCP+aero.Fdrag(dot-1).*car.zCP;
Miner = car.m*abs(kin.ax(dot-1)).*car.zCG;

tyr.Fz_R(dot) = ((Mmass+Maero)-(Miner))/car.L;
tyr.Fz_F(dot) = car.m*env.g*cosd(slope)+aero.Flift(dot-1)-tyr.Fz_R(dot);

% Tyre maximum forces
[Fx_F,Fy_F,Mz_F] = magicformula_solver(1,tyre,tyr.Fz_F(dot)/2,car.camber);
tyr.Fx_F(dot) = Fx_F;
tyr.Fy_F(dot) = Fy_F;
tyr.Mz_F(dot) = Mz_F;

[Fx_R,Fy_R,Mz_R] = magicformula_solver(1,tyre,tyr.Fz_R(dot)/2,car.camber);   
tyr.Fx_R(dot) = Fx_R;
tyr.Fy_R(dot) = Fy_R;
tyr.Mz_R(dot) = Mz_R;

% Engine maximum forces
run powertrain_solver_up.m

% Tractive Forces
if car.traction == 'FWD'
    Fx_tyre = tyr.Fx_F(dot);
    Fx_engine = pt.Fx(dot);
    kin.Fx_F(dot) = min(tyr.Fx_F(dot),pt.Fx(dot));
    kin.Fx_R(dot) = 0;
    kin.Fx(dot) = kin.Fx_F(dot)+kin.Fx_R(dot);
    kin.Fy(dot) = 0;
    
elseif traction == 'RWD'
    kin.Fx_F(dot) = 0;
    kin.Fx_R(dot) = min(tyr.Fx_R(dot),pt.Fx(dot));
    kin.Fx(dot) = kin.Fx_F(dot)+kin.Fx_R(dot);
    kin.Fy(dot) = 0;
    
elseif traction == 'AWD'
    kin.Fx_F(dot) = min(tyr.Fx_F(dot),pt.Fx(dot));
    kin.Fx_R(dot) = min(tyr.Fx_R(dot),pt.Fx(dot));
    kin.Fx(dot) = kin.Fx_F(dot)+kin.Fx_R(dot);
    kin.Fy(dot) = 0;
end

Fuerzas_resistentes = (aero.Fdrag(dot-1)+tyr.Rr_F(dot-1)+tyr.Rr_R(dot-1));%
Fuerzas_traccion = kin.Fx(dot);

% Kinematics
    kin.ax(dot) = (((kin.Fx(dot))-(tyr.Rr_F(dot-1)+tyr.Rr_R(dot-1)+aero.Fdrag(dot-1)+car.m*env.g*sind(slope)))/car.m);
    kin.ay(dot) = 0;
    kin.vx(dot) = (sqrt(2*kin.ax(dot)*(dist(dot)-dist(dot-1))+(kin.vx(dot-1).^2)));

kin.vy(dot) = 0;
kin.time(dot) = ((kin.vx(dot)-kin.vx(dot-1))/kin.ax(dot));

% Aerodynamics
aero.Fdrag(dot) = 0.5*car.Af*car.Cd*env.d*kin.vx(dot).^2;
aero.Flift(dot) = 0.5*car.Af*car.Cl*env.d*kin.vx(dot).^2;

% Rolling Resistance y Radius
tyr.Fz_index_F(dot) = (tyre.Fz0-tyr.Fz_F(dot)).^(tyre.Fz_exp-1);
tyr.Fz_index_R(dot) = (tyre.Fz0-tyr.Fz_R(dot)).^(tyre.Fz_exp-1);

tyr.vx_index(dot) = tyre.v0+tyre.v1.*kin.vx(dot)+tyre.v2.*kin.vx(dot).^2;

tyr.Crr_F(dot) = tyr.p_index.*tyr.Fz_index_F(dot).*tyr.vx_index(dot);
tyr.Rr_F(dot) = tyr.Crr_F(dot).*tyr.Fz_F(dot);

tyr.Crr_R(dot) = tyr.p_index.*tyr.Fz_index_R(dot).*tyr.vx_index(dot);
tyr.Rr_R(dot) = tyr.Crr_R(dot).*tyr.Fz_R(dot);

% Guardar variables
stv.kin = kin;
stv.aero = aero;
stv.tyre = tyr;
stv.pwt = pt;
stv.driver = driv;
tck.surfaceXYZ.Pz = Pz;
tck.profile.sim_long = dist;

% Borrar variables simples
clearvars kin aero tyr driv pt


