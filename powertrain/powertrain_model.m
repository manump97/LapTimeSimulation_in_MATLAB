% ----- % Powertrain Model % ----- %
clear powertrain;%clc;

Select_powertrain = string(Select_powertrain);

switch Select_powertrain
    case ['TSI_2.0']
        run TSI20_powertrain.m
    case ['390HP']
        run HP390_powertrain.m
    otherwise
        error('LTS: POWERTRAIN SELECTED DOES NOT EXIST')
        stop all
end

clearvars -except env tck car pwt tyre stv Select*