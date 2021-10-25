clear;
clc;
s   = tf('s');
% define system
G   = 220 / (s^2 + 1.2 * s);
%% load system and controller designed with sisotool
load('ControlSystemDesignerSession.mat');
controller = ControlSystemDesignerSession.DesignerData.Designs(2).Data.C;
%% ploter
% system step responde without controller
step(feedback(G, 1));
print('../../Figure/Q2/Q2_system_respond.png','-dpng','-r400');
step(feedback(controller * G, 1)); % system step responde with controller
print('../../Figure/Q2/Q2_system_controller_respond.png','-dpng','-r400');
% system step responde without controller
step(feedback(G, 1));
% system step responde without controller
step(feedback(G, 1));
hold;
step(feedback(controller * G, 1)); % system step responde with controller
legend('system', 'system with controller')
print('../../Figure/Q2/Q2_respond_all.png','-dpng','-r400');
hold off;
% system step responde without controller
margin(G);
print('../../Figure/Q2/Q2_system_margin.png','-dpng','-r400');
margin(controller * G); % system step responde with controller
print('../../Figure/Q2/Q2_system_controller_margin.png','-dpng','-r400');
% system step responde without controller
margin(G);
hold;
margin(controller * G); % system step responde with controller
legend('system', 'system with controller')
print('../../Figure/Q2/Q2_margin.png','-dpng','-r400');