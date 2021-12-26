clear; clc;
load('IAE.mat');
sim_result = sim('Q1_PID');
plot(sim_result.tout, sim_result.x, 'LineWidth', 2);
hold on
plot(sim_result.tout, sim_result.desired, 'LineWidth', 2);
xlabel('time');
ylabel('x');
legend('system', 'desired');
print('../../../Figure/Q1/IAE.png','-dpng','-r400');