% Powertrain Solver %

% Powertrain type
if pwt.type == 0 % Combustion
    % Calculate n from vehicle speed(gear ratio)
    pt.wo(dot) = (kin.vx(dot-1)*3.6)/tyr.R_F;

    pt.n(dot) = (pt.wo(dot).*pwt.gear_r(pt.gear)*(60/(2*pi)))+pwt.min_n;
    if pt.n(dot) > pwt.n_lim_change
        n_col = find(pwt.n_matrix(pt.gear,:)==0);
        n_col = n_col(1);
        pt.gear = pt.gear+1;
        if pt.gear > length(pwt.gear_r)
            pt.gear = length(pwt.gear_r);
        end
        pt.n(dot) = pwt.n_matrix(pt.gear,n_col);
    else
        pt.gear = pt.gear;
    end
    pt.torque(dot) = polyval(pwt.interp_coef,pt.n(dot));

    pt.wtorque(dot) = pt.torque(dot).*pwt.gear_r(pt.gear);%.*pwt.diff;
    pt.Fx(dot) = (pt.wtorque(dot).*pwt.diff(pt.gear))/tyr.R_F;
    
    pt.power(dot) = pt.torque(dot).*pt.n(dot);

elseif pwt.type == 1 % Electric
end



