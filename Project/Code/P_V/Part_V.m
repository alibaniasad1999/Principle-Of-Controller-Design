% part V %
simulink_data = sim('PID2D');
simulink_data.simout.plot;
print('../../Figure/P_V/PID2DOF.png','-dpng','-r400');
