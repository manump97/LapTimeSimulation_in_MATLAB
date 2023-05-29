% ----- % STATE VAR Closing lap % ------ %


stv.point = 1;
% Kinematics
stv.kin.ax(1) = stv.kin.ax(end);
stv.kin.ay(1) = stv.kin.ay(end);
stv.kin.a(1) = stv.kin.a(end);

stv.kin.vx(1) = stv.kin.vx(end);
stv.kin.vy(1) = stv.kin.vy(end);
stv.kin.v(1) = stv.kin.v(end);

stv.kin.Fx(1) = stv.kin.Fx(end);
stv.kin.Fx_F(1) = stv.kin.Fx_F(end);
stv.kin.Fx_R(1) = stv.kin.Fx_R(end);
stv.kin.Fy(1) = stv.kin.Fy(end);

stv.kin.time(1) = stv.kin.time(end);

% Tyre
stv.tyre.Fx_R(1) = stv.tyre.Fx_R(end);
stv.tyre.Fx_F(1) = stv.tyre.Fx_F(end);

stv.tyre.Fy_R(1) = stv.tyre.Fy_R(end);
stv.tyre.Fy_F(1) = stv.tyre.Fy_F(end);

stv.tyre.Fz_R(1) = stv.tyre.Fz_R(end);
stv.tyre.Fz_F(1) = stv.tyre.Fz_F(end);

stv.tyre.Mz_R(1) = stv.tyre.Mz_R(end);
stv.tyre.Mz_F(1) = stv.tyre.Mz_R(end);

% Tyre Radius
stv.tyre.Rh_F(1) = stv.tyre.Rh_F(end);
stv.tyre.Rh_R(1) = stv.tyre.Rh_R(end);

stv.tyre.R_F(1) = stv.tyre.R_F(end);
stv.tyre.R_R(1) = stv.tyre.R_R(end);

% Tyre Rolling Resistance
stv.tyre.p_index(1) = stv.tyre.p_index(end);
stv.tyre.Fz_index_F(1) = stv.tyre.Fz_index_F(end);
stv.tyre.Fz_index_R(1) = stv.tyre.Fz_index_R(end);
stv.tyre.vx_index(1) = stv.tyre.vx_index(end);

stv.tyre.Crr_F(1) = stv.tyre.Crr_F(end);
stv.tyre.Rr_F(1) = stv.tyre.Rr_F(end);

stv.tyre.Crr_R(1) = stv.tyre.Crr_R(end);
stv.tyre.Rr_R(1) = stv.tyre.Rr_R(end);

% Powertrain
if pwt.type == 0
    stv.pwt.fuel_cons(1) = stv.pwt.fuel_cons(end);
end
stv.pwt.gear = stv.pwt.gear;
stv.pwt.n(1) = stv.pwt.n(end);
stv.pwt.wo(1) = stv.pwt.wo(end);
stv.pwt.wtorque(1) = stv.pwt.wtorque(end);
stv.pwt.torque(1) = stv.pwt.torque(end);
stv.pwt.power(1) = stv.pwt.power(end);
stv.pwt.Fx(1) = stv.pwt.Fx(end);

% Aerodynamics
stv.aero.Fdrag(1) = stv.aero.Fdrag(end);
stv.aero.Flift(1) = stv.aero.Flift(end);

% Driver
stv.driver.throttle(1) = stv.driver.throttle(end);
stv.driver.brake(1) = stv.driver.brake(end);
stv.driver.steer_angle(1) = stv.driver.steer_angle(end);

