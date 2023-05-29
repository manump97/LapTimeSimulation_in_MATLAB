% ------ % MAIN SCRIPT LAP TIME SIMULATION (LTS) % ----- %
close all force;clear all;clc;tic
fprintf('\n###### LAP TIME SIMULATION (LTS) ######\n\n')
fprintf('--------------------------------------- CONTACT\n')
fprintf('Autor: Manuel Montesinos del Puerto\n')
fprintf('Email: m.montesinos.delpuerto@gmail.com\n')
% Add paths
addpath('car','config','config\export_fig','environment','powertrain','results','solver',...
    'solver\trajectory_solver','state_var','track','track\track_models','track\track_functions','tyre');

% Options
Select_track = 'Montmelo'; % Select the track (Montmelo/Monza/Monaco)
Select_car = 'Porsche911'; % Select the car (SeatLeon/Porsche911)
Select_powertrain = '390HP'; % Select the powertrain (TSI_2.0/390HP)

fprintf('--------------------------------------- OPTIONS\n')
fprintf('   Track: %s\n',Select_track)
fprintf('   Car: %s\n',Select_car)
fprintf('   Powertrain: %s\n',Select_powertrain)
fprintf('--------------------------------------- CONFIGURATION\n')
% Set configuration
run software_config
fprintf('OK <- Configuration set\n');toc
fprintf('--------------------------------------- INITIALIZATION\n');
% Initialize models;
run environment_model;fprintf('DONE <- Initilization Environment\n')
run track_model;fprintf('DONE <- Initilization Track\n')
run car_model;fprintf('DONE <- Initilization Car\n')
run powertrain_model;fprintf('DONE <- Initilization Powertrain\n')
run tyre_model;fprintf('DONE <- Initilization Tyre\n')
run state_var_model;fprintf('DONE <- Initilization State_var\n');toc
fprintf('--------------------------------------- SOLVERS\n');
% Simulation solvers
run trajectory_solver;fprintf('OK <- Solver Trajectory\n\n')
run dynamic_status_solver;fprintf('OK <- Solver Dynamic Status\n');toc
fprintf('--------------------------------------- RESULTS\n')
% Results analysis
run results_solver;fprintf('OK <- Analysis Results\n');toc
fprintf('---------------------------------------\n');
% Future actions
%   Report Generator
%   Variables looping comparison
