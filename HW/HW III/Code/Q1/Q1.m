clear;
clc;
s   = tf('s');
% define system
G   = ( 2 * s+ 0.1) / (s * (s^2 + 0.1 * s + 4));
%% load system and controller designed with sisotool
load('ControlSystemDesignerSession.mat');
controller = ControlSystemDesignerSession.DesignerData.Designs(2).Data.C;
%% ploter
% system step responde without controller
step(feedback(G, 1));
print('../../Figure/Q1/Q1_system_respond.png','-dpng','-r400');
step(feedback(controller * G, 1)); % system step responde with controller
print('../../Figure/Q1/Q1_system_controller_respond.png','-dpng','-r400');
% system step responde without controller
step(feedback(G, 1));
% system step responde without controller
step(feedback(G, 1));
hold;
step(feedback(controller * G, 1)); % system step responde with controller
legend('system', 'system with controller')
print('../../Figure/Q1/Q1_respond_all.png','-dpng','-r400');
hold off;
% system step responde without controller
rlocus(G);
print('../../Figure/Q1/Q1_system_rlocus.png','-dpng','-r400');
rlocus(controller * G); % system step responde with controller
print('../../Figure/Q1/Q1_system_controller_rlocus.png','-dpng','-r400');
% system step responde without controller
rlocus(G);
hold;
rlocus(controller * G); % system step responde with controller
legend('system', 'system with controller')
print('../../Figure/Q1/Q1_rlocus.png','-dpng','-r400');