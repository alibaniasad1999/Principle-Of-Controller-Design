clear;
clc;
% Maserati data
C_a = 0.29; % drag coeffient
C   = 743;  % constant
M   = 1900; % kg
tau = .2;   % (sec)
T   = 1;    % (sec)
s   = tf('s');
G   = C / (M * tau) / ((s + C_a / M) * (s + 1 / T) * (s + 1 / tau));
%% load system and controller designed with sisotool
load('ControlSystemDesignerSession.mat');
controller = ControlSystemDesignerSession.DesignerData.Designs(2).Data.C;
%% ploter
% system step responde without controller
step(feedback(G, 1));
print('../../Figure/Q4/Q4_system_respond.png','-dpng','-r400');
step(feedback(controller * G, 1)); % system step responde with controller
print('../../Figure/Q4/Q4_system_controller_respond.png','-dpng','-r400');
% system step responde without controller
step(feedback(G, 1));
% system step responde without controller
step(feedback(G, 1));
hold;
step(feedback(controller * G, 1)); % system step responde with controller
legend('system', 'system with controller')
print('../../Figure/Q4/Q4_respond_all.png','-dpng','-r400');
hold off;
% system step responde without controller
rlocus(G);
print('../../Figure/Q4/Q4_system_rlocus.png','-dpng','-r400');
rlocus(controller * G); % system step responde with controller
print('../../Figure/Q4/Q4_system_controller_rlocus.png','-dpng','-r400');
% system step responde without controller
rlocus(G);
hold;
rlocus(controller * G); % system step responde with controller
legend('system', 'system with controller')
print('../../Figure/Q4/Q4_rlocus.png','-dpng','-r400');