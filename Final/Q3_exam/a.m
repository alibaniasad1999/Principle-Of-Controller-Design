s = tf('s');
G = (-s+4)/((s+1)*(s+2)*(s^2 + s +6));
[K, L, T] = get_fod(G); % frequesy
G_freq = K * exp(-L * s) / (T * s + 1);
% [K, L, T] = get_fod(G, 1); % transfer function
% G_tran = K * exp(-L * s) / (T * s + 1);
G_opt = opt_app(G, 0, 1, 1); % optimization
[K, L, T] = get_fod(G_opt);
G_opt = K * exp(-L * s) / (T * s + 1);

step(G);
hold;
step(G_freq);
% step(G_tran);
step(G_opt) ;
% legend('system', 'frequecy FOTD', 'tranferfunction FOTD',...
%     'optimization FOTD');
legend('system', 'frequecy FOTD', 'optimization FOTD');
