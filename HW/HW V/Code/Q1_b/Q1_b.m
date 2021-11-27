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
print('../../Figure/Q1/Q1_b/rlocus.png','-dpng','-r400');
step(feedback(C*G, 1));
print('../../Figure/Q1/Q1_b/feedback_step.png','-dpng','-r400');
bode(feedback(C*G, 1));
print('../../Figure/Q1/Q1_b/feedback_bode.png','-dpng','-r400');
bode(G);
print('../../Figure/Q1/Q1_b/openloop_bode.png','-dpng','-r400');
s_function = 1 / (1 + C*G);
bode(s_function);
print('../../Figure/Q1/Q1_b/s_bode.png','-dpng','-r400');
t_function = C*G / (1 + C*G);
bode(t_function);
print('../../Figure/Q1/Q1_b/t_bode.png','-dpng','-r400');