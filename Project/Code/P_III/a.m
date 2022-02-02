clc;
clear;
run('../Base/Base_TF.m');
run('../Base/stabilizer.m');
G_new_OpenLoop = feedback(C_stabilizer * G_R_V, 1);


[K, L, T] = get_fod(G_new_OpenLoop); % frequesy
G_freq = K * exp(-L * s) / (T * s + 1);
[K, ~, T] = get_fod(G_new_OpenLoop, 1); % transfer function
L = 0; % L is very small and function output is negative
G_tran = K * exp(-L * s) / (T * s + 1);
G_opt = opt_app(G_new_OpenLoop, 0, 1, 1); % optimization
[K, L, T] = get_fod(G_opt); 
G_opt = K * exp(-L * s) / (T * s + 1);

t = 0:0.001:10; % time for step
step(G_new_OpenLoop, t);
hold on;
step(G_freq, t);
step(G_tran, t);
step(G_opt, t) ;
hold off;
legend('system', 'frequecy FOTD', 'tranferfunction FOTD',...
    'optimization FOTD');
print('../../Figure/P_III/FOTD.png','-dpng','-r400');
Cost_freg = sum(abs(step(G_new_OpenLoop, t)- step(G_freq, t)));
Cost_tran = sum(abs(step(G_new_OpenLoop, t)- step(G_tran, t)));
Cost_opt  = sum(abs(step(G_new_OpenLoop, t)- step(G_opt, t)));
