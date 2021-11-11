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
% sensitivity function
bode(1 / (1 + C * G));
% print('../../../Figure/Q1/Q1_d/sensitivity_func.png','-dpng','-r400');
% complementary sensitivity function
bode(C * G / (1 + C * G));
% print('../../../Figure/Q1/Q1_d/com_sensitivity_func.png','-dpng','-r400');
nyquist(1 / (1 + C * G))
hold
nyquist(C*G / (1 + C * G))
print('../../../Figure/Q1/Q1_d/nyquist.png','-dpng','-r400');
legend('sensitivity function', 'complementary sensitivity function')