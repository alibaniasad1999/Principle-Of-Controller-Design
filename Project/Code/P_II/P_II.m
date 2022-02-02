% part II %
clc;
clear;
SISO_base_tf;
% load data from sisotool %
load('../../Code/P_I/ControlSystemDesignerSession_PID.mat');
stabilizer_conroller = ControlSystemDesignerSession.DesignerData.Designs...
    .Data.C2;

%controller designed from matlab pid tuner app
controller_PIDtuner_partII_PIDF = 3.97 + 5.03/s -0.00752*s/(0.0019*s+1);
controller_PIDtuner_partII_PI = 4.03 + 4.14/s ;

G_OL_overal = feedback(stabilizer_conroller * G_R_V, 1);
G_CL_partII_PI = feedback(controller_PIDtuner_partII_PI * G_OL_overal, 1);
G_CL_partII_PIDF = feedback(controller_PIDtuner_partII_PIDF * G_OL_overal, 1);
%step respones figures
hold on
legend 'show'

h = stepplot(G_CL_partII_PI,G_CL_partII_PIDF);
h.showCharacteristic('PeakResponse')
h.showCharacteristic('SettlingTime')
G_CL_partII_PI.name = 'PI @matlab PID tuner';
G_CL_partII_PIDF.name = 'PIDF @matlab PID tuner';

print('../../Figure/P_II/PID_tunner.png','-dpng','-r400');