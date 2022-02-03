% init function and transfer funstion %
clc;
clear;
m = 1   ; % ball weight (kg)
d = 0.05; % gear rediuce (m)
a = 0.02; % ball rediuce (m)
L = 1   ; % bar length (m)
g = 9.8 ; % m/s^2 
run('../Base/stabilizer.m');
[num,den] = tfdata(C_stabilizer);
load('ControlSystemDesignerSession_PID.mat');
PID_conroller = ControlSystemDesignerSession.DesignerData.Designs.Data.C1;
[numPID, denPID] = tfdata(PID_conroller);