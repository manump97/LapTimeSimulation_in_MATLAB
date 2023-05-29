% ----- % STATE VAR % ------ %
clear stv;%clc;

stv.point = 1;
% Kinematics
stv.kin.ax = 0;
stv.kin.ay = 0;
stv.kin.a = 0;

stv.kin.vx = 0;
stv.kin.vy = 0;
stv.kin.v = 0;

stv.kin.Fx = 0;
stv.kin.Fx_F = 0;
stv.kin.Fx_R = 0;
stv.kin.Fy = 0;

stv.kin.time = 0;

% Tyre
stv.tyre.Fx_R = 0;
stv.tyre.Fx_F = 0;

stv.tyre.Fy_R = 0;
stv.tyre.Fy_F = 0;

stv.tyre.Fz_R = car.m*env.g...
    *(car.xCG/car.L);

stv.tyre.Fz_F = car.m*env.g...
    -stv.tyre.Fz_R;

stv.tyre.Mz_R = 0;
stv.tyre.Mz_F = 0;

% Tyre Radius
stv.tyre.Rh_F = car.Rg-(stv.tyre.Fz_F/tyre.Kz);
stv.tyre.Rh_R = car.Rg-(stv.tyre.Fz_R/tyre.Kz);

stv.tyre.R_F = (2/3)*car.Rg+(1/3)*stv.tyre.Rh_F;
stv.tyre.R_R = (2/3)*car.Rg+(1/3)*stv.tyre.Rh_R;

% Tyre Rolling Resistance
stv.tyre.p_index = (tyre.p0-tyre.p).^(tyre.p_exp);
stv.tyre.Fz_index_F = (tyre.Fz0-stv.tyre.Fz_F).^(tyre.Fz_exp-1);
stv.tyre.Fz_index_R = (tyre.Fz0-stv.tyre.Fz_R).^(tyre.Fz_exp-1);
stv.tyre.vx_index = tyre.v0;

stv.tyre.Crr_F = stv.tyre.p_index.*stv.tyre.Fz_index_F.*stv.tyre.vx_index;
stv.tyre.Rr_F = stv.tyre.Crr_F.*stv.tyre.Fz_F;

stv.tyre.Crr_R = stv.tyre.p_index.*stv.tyre.Fz_index_R.*stv.tyre.vx_index;
stv.tyre.Rr_R = stv.tyre.Crr_R.*stv.tyre.Fz_R;

% Powertrain
if pwt.type == 0
    stv.pwt.fuel_cons = 0;
end
stv.pwt.gear = 1;
stv.pwt.n = pwt.min_n;
stv.pwt.wo = 0;
stv.pwt.wtorque = 0;
stv.pwt.torque = 0;
stv.pwt.power = 0;
stv.pwt.Fx = 0;

% Aerodynamics
stv.aero.Fdrag = 0;
stv.aero.Flift = 0;

% Driver
stv.driver.throttle = 0;
stv.driver.brake = 0;
stv.driver.steer_angle = 0;

