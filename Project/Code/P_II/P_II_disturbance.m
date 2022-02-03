% part II %
% disturbance rejection checking without saturation
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

G_CL_partII_PI_dis = G_R_V/(1+G_R_V*controller_PIDtuner_partII_PI*(1+stabilizer_conroller));
G_CL_partII_PIDF_dis = G_R_V/(1+G_R_V*controller_PIDtuner_partII_PIDF*(1+stabilizer_conroller));
%step respones figures
hold on
legend 'show'

bode(G_CL_partII_PI_dis,G_CL_partII_PIDF_dis)
G_CL_partII_PI_dis.name = 'PI @matlab PID tuner disturbance rejection';
G_CL_partII_PIDF_dis.name = 'PIDF @matlab PID tuner disturbance rejection';

 print('../../Figure/P_II/PID_tunner_dis_rej.png','-dpng','-r400');


