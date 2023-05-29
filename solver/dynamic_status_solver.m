% ----- % Dynamic Status Solver % ----- %
dot = 2; status = 1;
raceline = tck.trajectory.raceline;
dist = tck.profile.sim_long;

Select_status = [];
current_Lap = 1;

fprintf('### LAP 1 - Opening lap ###\n')
disp('# SECTOR 1 #')
while current_Lap <= 2
    while status <= length(raceline(1,:))
        if (status+1) > length(raceline(1,:))
            lim = length(dist);
        else
            lim = raceline(2,status+1);
        end

        switch abs(raceline(1,status)) 

            case 0 % Longitudinal
                disp('  Straight')
                while dot <= lim
                    run longitudinal_dynamics.m;
                    Select_status(dot) = 0;
                    dot = dot+1;
                end

            case 1 % Lateral
                disp('  Turn')
                dot_entry = dot;

                if raceline(1,status-1) == 0
                    while dot >= raceline(2,status-1)
                       run braking_dynamics.m;             
                       dot = dot-1; 
                    end
                    run straight_dynamics.m
                    dot = dot_entry;
                end

                doti = dot;
                vx_long = stv.kin.vx(doti-1);
                while dot <= raceline(2,status+1)
                    run lateral_dynamics.m
                    if vx_lat > vx_long
                        Select_status(dot) = 2;
                        run longitudinal_dynamics.m;
                        if raceline(1,status) > 0
                            stv.kin.ay(dot) = (stv.kin.vx(dot)^2)/raceline(6,status);
                        else
                            stv.kin.ay(dot) = -(stv.kin.vx(dot)^2)/raceline(6,status);
                        end
                    else
                        Select_status(dot) = 1;
                        run lateral_dynamics.m 
                    end
                    dot = dot+1;
                end
        end
        status = status+1;
        switch dot-1
            case tck.sectors.s1
                disp('# SECTOR 2 #')
            case tck.sectors.s2
                disp('# SECTOR 3 #')
        end
    end
    if current_Lap == 1
        fprintf('\n### LAP 2 - Closing lap ###\n')
        disp('# SECTOR 1 #')
        dot=2;status=1;current_Lap =current_Lap+1;
        run state_var_model_CloseLoop.m
    else
        current_Lap = current_Lap+1;
        fprintf('\n### Clean Lap finished ###\n\n')
    end
end

% Clear variables
clearvars -except car env tck Select* stv tyre pwt

