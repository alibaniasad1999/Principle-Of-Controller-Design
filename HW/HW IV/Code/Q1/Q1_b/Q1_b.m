clear;
clc;
s   = tf('s');
% define system
G = (s + 1) * (s + 4) * (s + 8) / (s^3 * (s^2 + 0.2 * s + 100));
%% load system and controller designed with sisotool
load('ControlSystemDesignerSession.mat');
% Controller
C = ControlSystemDesignerSession.DesignerData.Designs(3).Data.C;
%% Ploter
margin(C * G);
print('../../../Figure/Q1/Q1_b/margin.png','-dpng','-r400');
nichols(C * G);
print('../../../Figure/Q1/Q1_b/nichols.png','-dpng','-r400');
step(feedback(C * G, 1));
print('../../../Figure/Q1/Q1_b/step.png','-dpng','-r400');