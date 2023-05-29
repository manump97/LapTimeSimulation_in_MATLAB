% ----- % Car Model % ----- %
clear car;%clc;

Select_car = string(Select_car);

switch Select_car
    case ['SeatLeon']
        run SeatLeon_car.m
    case ['Porsche911']
        run Porsche911_2012_car.m
    otherwise
        error('LTS: CAR SELECTED DOES NOT EXIST')
        stop all
end

clearvars -except env tck car pwt tyre stv Select*