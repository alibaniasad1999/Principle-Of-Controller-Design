% part I %
clc;
clear;
SISO_base_tf;
% load data from sisotool %
load('ControlSystemDesignerSession_PID.mat');
PID_conroller = ControlSystemDesignerSession.DesignerData.Designs.Data.C1;
stabilizer_conroller = ControlSystemDesignerSession.DesignerData.Designs...
    .Data.C2;
step(feedback(PID_conroller * feedback(stabilizer_conroller * G_R_V, 1), 1));
print('../../Figure/P_I/PID.png','-dpng','-r400');