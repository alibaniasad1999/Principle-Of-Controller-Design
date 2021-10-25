clear;
clc;
s   = tf('s');
% define system
G   = 1 / (s * (0.1 * s + 1) * (s + 1));
%% load system and controller designed with sisotool
load('ControlSystemDesignerSession.mat');
controller = ControlSystemDesignerSession.DesignerData.Designs(2).Data.C;
%% ploter
% system step responde without controller
step(feedback(G, 1));
print('../../Figure/Q3/Q3_system_respond.png','-dpng','-r400');
step(feedback(controller * G, 1)); % system step responde with controller
print('../../Figure/Q3/Q3_system_controller_respond.png','-dpng','-r400');
% system step responde without controller
step(feedback(G, 1));
% system step responde without controller
step(feedback(G, 1));
hold;
step(feedback(controller * G, 1)); % system step responde with controller
legend('system', 'system with controller')
print('../../Figure/Q3/Q3_respond_all.png','-dpng','-r400');
hold off;
% system step responde without controller
nichols(G);
print('../../Figure/Q3/Q3_system_nichols.png','-dpng','-r400');
nichols(controller * G); % system step responde with controller
print('../../Figure/Q3/Q3_system_controller_nichols.png','-dpng','-r400');
% system step responde without controller
nichols(G);
hold;
nichols(controller * G); % system step responde with controller
legend('system', 'system with controller')
print('../../Figure/Q3/Q3_nichols.png','-dpng','-r400');