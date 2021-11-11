clear;
clc;
s   = tf('s');
% define system
G = (s + 1) * (s + 4) * (s + 8) / (s^3 * (s^2 + 0.2 * s + 100));
%% load system and controller designed with sisotool
load('ControlSystemDesignerSession.mat');
% Controller
C = ControlSystemDesignerSession.DesignerData.Designs(3).Data.C;
%% ploter
% r to y
bode(C * G / (1 + C * G));
print('../../../Figure/Q1/Q1_c/bode_r2y.png','-dpng','-r400');
% du to y
bode(G / (1 + C * G));
print('../../../Figure/Q1/Q1_c/bode_du2y.png','-dpng','-r400');
% dy to y
bode(1 / C * G);
print('../../../Figure/Q1/Q1_c/bode_dy2y.png','-dpng','-r400');
% n to y
bode(C * G / (1 + C * G));
print('../../../Figure/Q1/Q1_c/bode_n2y.png','-dpng','-r400');
