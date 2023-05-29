% LATERAL DYNAMICS
kin = stv.kin;
aero = stv.aero;
tyr = stv.tyre;
pt = stv.pwt;
driv = stv.driver;
Pz = tck.surfaceXYZ.Pz;
dist = tck.profile.sim_long;

% Tyre forces
[Fx_F,Fy_F,Mz_F] = magicformula_solver(2,tyre,tyr.Fz_F(1)/2,car.camber);
[Fx_R,Fy_R,Mz_R] = magicformula_solver(2,tyre,tyr.Fz_R(1)/2,car.camber);   

% Kin
kin.ax(dot) = 0;
kin.vx(dot) = 0;
kin.vx(dot) = sqrt(raceline(6,status).*(Fy_F+Fy_R)/car.m);
vx_lat = kin.vx(dot);
kin.vy(dot) = sqrt(raceline(6,status).*(Fy_F+Fy_R)/car.m);
kin.time(dot) = 0;

if raceline(1,status) > 0
    kin.ay(dot) = (Fy_F+Fy_R)/car.m;
else
    kin.ay(dot) = -(Fy_F+Fy_R)/car.m;
end

kin.Fx_F(dot) = Fx_F;
kin.Fx_R(dot) = Fx_R;
kin.Fx(dot) = 0;
kin.Fy(dot) = Fy_F+Fy_R;
% Aero
aero.Fdrag(dot) = aero.Fdrag(dot-1);
aero.Flift(dot) = aero.Flift(dot-1);
% Tyr
tyr.Fz_R(dot) = tyr.Fz_R(dot-1);
tyr.Fz_F(dot) = tyr.Fz_F(dot-1);
tyr.Fy_R(dot) = Fy_R;
tyr.Fy_F(dot) = Fy_F;
tyr.Fx_R(dot) = Fx_R;
tyr.Fx_F(dot) = Fx_F;
tyr.Mz_R(dot) = Mz_R;

tyr.Fz_index_F(dot) = tyr.Fz_index_F(dot-1);
tyr.Fz_index_R(dot) = tyr.Fz_index_R(dot-1);
tyr.vx_index(dot) = tyr.vx_index(dot-1);
tyr.Crr_F(dot) = tyr.Crr_F(dot-1);
tyr.Rr_F(dot) = tyr.Rr_F(dot-1);
tyr.Crr_R(dot) = tyr.Crr_R(dot-1);
tyr.Rr_R(dot) = tyr.Rr_R(dot-1);

% Pt
pt.gear = pt.gear;
pt.wo(dot) = pt.wo(dot-1);
pt.n(dot) = pt.n(dot-1);
pt.torque(dot) = pt.torque(dot-1);
pt.wtorque(dot) = pt.wtorque(dot-1);
pt.Fx(dot) = pt.Fx(dot-1);
pt.power(dot) = pt.power(dot-1);


% Guardar variables
stv.kin = kin;
stv.aero = aero;
stv.tyre = tyr;
stv.pwt = pt;
stv.driver = driv;
tck.surfaceXYZ.Pz = Pz;
tck.profile.sim_long = dist;