clc
clear

% system specifications %
m = 1   ; % ball weight (kg)
d = 0.05; % gear rediuce (m)
a = 0.02; % ball rediuce (m)
L = 1   ; % bar length (m)
g = 9.8 ; % m/s^2

% transfer functions
s = tf('s');
R_theta    = m * g * d / (7 / 5 * L * s^2); % R / theta
theta_V    = 0.0274 / (0.003228 * s^2 + 0.003508 * s); % theta / V
gear_motor = 1/5; % gearbox ratio
% final 
G_R_V = R_theta * gear_motor * theta_V;