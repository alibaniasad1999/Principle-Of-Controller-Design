s = tf('s');
G = (-s + 3) / ((s+1) * (s+2) * (s^2 + 2 * s + 4));
[K, L, T] = get_fod(G); % frequesy
G_freq = K * exp(-L * s) / (T * s + 1);
[K, L, T] = get_fod(G, 1); % transfer function
G_tran = K * exp(-L * s) / (T * s + 1);
G_opt = opt_app(G, 0, 1, 1); % optimization
step(G);
hold;
step(G_freq);
step(G_tran);
step(G_opt) ;
legend('system', 'frequecy FOTD', 'tranferfunction FOTD',...
    'optimization FOTD');
print('../../Figure/Q1/a/FOTD.png','-dpng','-r400');
Cost_freg = sum(abs(step(G)- step(G_freq)));
Cost_tran = sum(abs(step(G)- step(G_tran)));
Cost_opt  = sum(abs(step(G)- step(G_opt )));