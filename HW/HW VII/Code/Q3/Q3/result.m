clear; clc;
load('ITAE40.mat');
sim_result = sim('Q3_PID');
plot(sim_result.tout, sim_result.desired, 'LineWidth', 2);
hold on
plot(sim_result.tout, sim_result.x, 'LineWidth', 2);
load('ITAE100.mat');
sim_result = sim('Q3_PID');
plot(sim_result.tout, sim_result.x, 'LineWidth', 2);
load('ITAE400.mat');
sim_result = sim('Q3_PID');
plot(sim_result.tout, sim_result.x, 'LineWidth', 2);
load('ITAE1000.mat');
sim_result = sim('Q3_PID');
plot(sim_result.tout, sim_result.x, 'LineWidth', 2);
xlabel('time');
ylabel('x');
axis([0, 400, -.5, 1.5])
legend('desired', '40 second', '100 second', '400 second', '1000 second'...
    );
print('../../../Figure/Q3/ITAE.png','-dpng','-r400');