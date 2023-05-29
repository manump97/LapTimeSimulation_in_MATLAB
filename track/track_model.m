% ----- % Track Model % ----- %
clear track;%clc;

Select_track = string(Select_track);

switch Select_track
    case ['Montmelo']
        load Montmelo.mat
        run Montmelo_track_v3.m
    case ['Monza']
        load Monza.mat
        run Monza_track_v3.m
    case ['Monaco']
        load Monaco.mat
        run Monaco_track_v3.m
    otherwise
        error('LTS: TRACK SELECTED DOES NOT EXIST')
end
tck = track;
clearvars -except env tck car pwt tyre stv Select*