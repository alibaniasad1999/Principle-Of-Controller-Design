clear;
clc;
s   = tf('s');
% define system
G = (s + 1) / (s^2 - 2 * s + 4);
%% load system and controller designed with sisotool
load('ControlSystemDesignerSession.mat');
% Controller
C = ControlSystemDesignerSession.DesignerData.Designs(2).Data.C;
%% ploter
rlocus(C*G);
print('../../../Figure/Q1/Q1_b/lag/rlocus.png','-dpng','-r400');
step(feedback(C*G, 1));
print('../../../Figure/Q1/Q1_b/lag/feedback_step.png','-dpng','-r400');
bodemag(feedback(C*G, 1));
print('../../../Figure/Q1/Q1_b/lag/feedback_bode.png','-dpng','-r400');
bodemag(G);
print('../../../Figure/Q1/Q1_b/lag/openloop_bode.png','-dpng','-r400');
s_function = 1 / (1 + C*G);
bodemag(s_function);
print('../../../Figure/Q1/Q1_b/lag/s_bode.png','-dpng','-r400');
t_function = C*G / (1 + C*G);
bodemag(t_function);
print('../../../Figure/Q1/Q1_b/lag/t_bode.png','-dpng','-r400');