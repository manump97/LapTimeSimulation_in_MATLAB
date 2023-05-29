% STRAIGHT Dynamics ACCELERATING+BRAKING %
% Extraer variables simples
kin = stv.kin;
aero = stv.aero;
tyr = stv.tyre;
pt = stv.pwt;
driv = stv.driver;
Pz = tck.surfaceXYZ.Pz;
dist = tck.profile.sim_long;

i = raceline(2,status-1);
ii = 0;
while i < dot_entry
    kin.vx(i) = min(kin.vx(i),bv(i));
    i = i+1;
end
[value,c] = max(kin.vx(raceline(2,status-1):i-1));
value;
c = c+raceline(2,status-1);

% Kin
kin.ax(c:dot_entry) = bax(c:dot_entry);
kin.ay(c:dot_entry) = bay(c:dot_entry);
kin.vy(c:dot_entry) = bvy(c:dot_entry);
kin.time(c:dot_entry) = btime(c:dot_entry);

kin.Fx_F(c:dot_entry) = -bFx_F(c:dot_entry);
kin.Fx_R(c:dot_entry) = -bFx_R(c:dot_entry);
kin.Fx(c:dot_entry) = -(bFx_F(c:dot_entry)+bFx_R(c:dot_entry));
kin.Fy(c:dot_entry) = 0;
% Aero
aero.Fdrag(c:dot_entry) = bFdrag(c:dot_entry);
aero.Flift(c:dot_entry) = bFlift(c:dot_entry);
% Tyr
tyr.Fz_R(c:dot_entry) = bFz_R(c:dot_entry);
tyr.Fz_F(c:dot_entry) = bFz_F(c:dot_entry);
tyr.Fy_R(c:dot_entry) = bFy_R(c:dot_entry);
tyr.Fy_F(c:dot_entry) = bFy_F(c:dot_entry);
tyr.Fx_R(c:dot_entry) = bFx_R(c:dot_entry);
tyr.Fx_F(c:dot_entry) = bFx_F(c:dot_entry);
tyr.Mz_R(c:dot_entry) = bMz_R(c:dot_entry);

tyr.Fz_index_F(c:dot_entry) = bFz_index_F(c:dot_entry);
tyr.Fz_index_R(c:dot_entry) = bFz_index_R(c:dot_entry);
tyr.vx_index(c:dot_entry) = bvx_index(c:dot_entry);
tyr.Crr_F(c:dot_entry) = bCrr_F(c:dot_entry);
tyr.Rr_F(c:dot_entry) = bRr_F(c:dot_entry);
tyr.Crr_R(c:dot_entry) = bCrr_R(c:dot_entry);
tyr.Rr_R(c:dot_entry) = bRr_R(c:dot_entry);
% Pt
pt.gear = pwt.gear_matrix(round(kin.vx(dot_entry-1)));
pt.wo(c:dot_entry) = bwo(c:dot_entry);
pt.n(c:dot_entry) = bn(c:dot_entry);
pt.torque(c:dot_entry) = btorque(c:dot_entry);
pt.wtorque(c:dot_entry) = bwtorque(c:dot_entry);
pt.Fx(c:dot_entry) = bFx(c:dot_entry);
pt.power(c:dot_entry) = bpower(c:dot_entry);
% Driv

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