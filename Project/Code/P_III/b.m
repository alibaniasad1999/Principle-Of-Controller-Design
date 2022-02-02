clc;
clear;
run('../Base/Base_TF.m');
run('../Base/stabilizer.m');
G_new_OpenLoop = feedback(C_stabilizer * G_R_V, 1);
[Kc, pp, wg, wp] = margin(G_new_OpenLoop);
Tc = 2 * pi / wg;
Kp = dcgain(G_new_OpenLoop);

G_opt = opt_app(G_new_OpenLoop, 0, 1, 1); % optimization
[K, L, T] = get_fod(G_opt); 
G_opt = K * exp(-L * s) / (T * s + 1);

N = 10;

% ziegler nichols
[Gc_zn, ~, ~, ~, ~] = ziegler_nic(3, [K, L, T, N]);
step(feedback(Gc_zn * G_new_OpenLoop, 1));
print('../../Figure/P_III/zn.png','-dpng','-r400');
% refined ziegler nichols
[Gc_rzn, H, ~, ~, ~, ~] = rziegler_nic([K, L, T, N, Kc, Tc]);
step(feedback(Gc_rzn * G_new_OpenLoop, H));
print('../../Figure/P_III/rzn.png','-dpng','-r400');
% modified ziegler nichols
rb = 1;
for pb = 5:5:35
    [Gc_mzn, ~, ~, ~, ~] = ziegler_nic(3, [K, Tc, rb, pb, N]);
    step(feedback(Gc_mzn * G_new_OpenLoop, 1), 50)
    hold on;
end
legend('$r_b = 5$', '$r_b = 10$', '$r_b = 15$', '$r_b = 20$', ...
     '$r_b = 25$', '$r_b = 30$', '$r_b = 35$', 'interpreter', 'latex')
print('../../Figure/P_III/mzn.png','-dpng','-r400');
hold off
% Cohen Coon
[Gc_cc, ~, ~, ~, ~] = cohen_pid(3, 1,[K, L, T, N]);
step(feedback(Gc_cc * G_new_OpenLoop, 1));
print('../../Figure/P_III/cc.png','-dpng','-r400');
% Cohen Coon revisited
[Gc_ccr, ~, ~, ~, ~] = cohen_pid(3, 2,[K, L, T, N]);
step(feedback(Gc_ccr * G_new_OpenLoop, 1));
print('../../Figure/P_III/ccr.png','-dpng','-r400');
% Astrom Hagglund
[Gc_ah, ~, ~, ~, ~] = AH_pid(2, [K, L, T, N], 0);
step(feedback(Gc_ah * G_new_OpenLoop, 1));
print('../../Figure/P_III/ah.png','-dpng','-r400');
% Frequency based Astrom Hagglund
[Gc_fah, ~, ~, ~, ~] = AH_pid(2, [Kc, Tc, Kp, N], 1);
step(feedback(Gc_fah * G_new_OpenLoop, 1));
print('../../Figure/P_III/fah.png','-dpng','-r400');
% CHR 0 overshoot
[Gc_chrzero,~ , ~, ~, ~] = chr_pid(3, 1, [K, L, T, N, 0]);
step(feedback(Gc_chrzero * G_new_OpenLoop, 1));
print('../../Figure/P_III/chr0.png','-dpng','-r400');
% CHR 20 overshoot
[Gc_chrtwenty,~ , ~, ~, ~] = chr_pid(3, 1, [K, L, T, N, 1]);
step(feedback(Gc_chrtwenty * G_new_OpenLoop, 1));
print('../../Figure/P_III/chr20.png','-dpng','-r400');
% WJC 
[Gc_wjc, ~, ~, ~] = wjcpid([K, L, T, N]);
step(feedback(Gc_wjc * G_new_OpenLoop, 1));
print('../../Figure/P_III/wjc.png','-dpng','-r400');
% optimum pid
[Gc_opt, ~, ~, ~, ~] = opt_pid(3, 1, [K, L, T, N, 2]);
step(feedback(Gc_opt * G_new_OpenLoop, 1));
print('../../Figure/P_III/optpid.png','-dpng','-r400');
% optimum pi-d
[Gc_opt1, H, ~, ~, ~] = opt_pid(4, 1, [K, L, T, N, 2]);
step(feedback(Gc_opt1 * G_new_OpenLoop, H));
print('../../Figure/P_III/optpi-d.png','-dpng','-r400');