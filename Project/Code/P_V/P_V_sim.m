% part V %
clc;
clear;
SISO_base_tf;
% load data from sisotool %
load('../../Code/P_I/ControlSystemDesignerSession_PID.mat');
stabilizer_conroller = ControlSystemDesignerSession.DesignerData.Designs...
    .Data.C2;

[num_st,den_st]=tfdata(stabilizer_conroller,'v');
[num_V_theta,den_V_theta]=tfdata(theta_motor_V*gear_ratio,'v');


stop_time = 200;
step_time = 0.001;

sim('PID2DOF_nonlinear.slx');

plot(ans.PID2DOF_output_without_sat)
legend('PID2DOF output without sat nonlinear')


% plot(ans.PID2DOF_output_with_sat)
% legend('PID2DOF output with sat nonlinear')


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