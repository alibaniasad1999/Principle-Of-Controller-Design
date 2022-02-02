% part V %
clc;
clear;
SISO_base_tf;
% load data from sisotool %
load('../../Code/P_I/ControlSystemDesignerSession_PID.mat');
stabilizer_conroller = ControlSystemDesignerSession.DesignerData.Designs...
    .Data.C2;
[num_st,den_st]=tfdata(stabilizer_conroller,'v');
[num_G_R_V,den_G_R_V]=tfdata(G_R_V,'v');
stop_time = 20;
step_time = 0.001;


% %controller designed from matlab pid tuner app
% G_OL_overal = feedback(stabilizer_conroller * G_R_V, 1);
% G_CL_partII_PI = feedback(controller_PIDtuner_partII_PI * G_OL_overal, 1);
% G_CL_partII_PIDF = feedback(controller_PIDtuner_partII_PIDF * G_OL_overal, 1);
% %step respones figures
% hold on
% legend 'show'
% 
% h = stepplot(G_CL_partII_PI,G_CL_partII_PIDF);
% h.showCharacteristic('PeakResponse')
% h.showCharacteristic('SettlingTime')
% G_CL_partII_PI.name = 'PI @matlab PID tuner';
% G_CL_partII_PIDF.name = 'PIDF @matlab PID tuner';
% 
% print('../../Figure/P_II/PID_tunner.png','-dpng','-r400');