clc;
clear;
run('../Base/Base_TF.m');
run('../Base/stabilizer.m');
G_new_OpenLoop = feedback(C_stabilizer * G_R_V, 1);


[K, L, T] = get_fod(G_new_OpenLoop); % frequesy
G_freq = K * exp(-L * s) / (T * s + 1);
% [K, L, T] = get_fod(G_new_OpenLoop, 1); % transfer function
% G_tran = K * exp(-L * s) / (T * s + 1);
G_opt = opt_app(G_new_OpenLoop, 0, 1, 1); % optimization
[K, L, T] = get_fod(G_opt); 
G_opt = K * exp(-L * s) / (T * s + 1);

step(G_new_OpenLoop);
hold;
step(G_freq);
% step(G_tran);
step(G_opt) ;
legend('system', 'frequecy FOTD', 'tranferfunction FOTD',...
    'optimization FOTD');
% print('../../Figure/Q1/a/FOTD.png','-dpng','-r400');
% Cost_freg = sum(abs(step(G)- step(G_freq)));
% Cost_tran = sum(abs(step(G)- step(G_tran)));
% Cost_opt  = sum(abs(step(G)- step(G_opt )));
