clear;
clc;
%% Quaetion 1 part b
s = tf('s');
G = (-s + 3) / ((s+1) * (s+2) * (s^2 + 2 * s + 4));
[Kc, pp, wg, wp] = margin(G);
Tc = 2 * pi / wg;
% G_opt = opt_app(G, 0, 1, 1); % optimization
K = 0.9794 *  0.383;
L = 1.38;
T = 0.9794;
Kp = dcgain(G);

G_opt = K * exp(-L * s) / (T * s + 1); % change G_opt shape

N = 10;

% ziegler nichols
[Gc_zn, ~, ~, ~, ~] = ziegler_nic(3, [K, L, T, N]);
step(feedback(Gc_zn * G, 1));
print('../../Figure/Q1/b/zn.png','-dpng','-r400');
% refined ziegler nichols
[Gc_rzn, H, ~, ~, ~, ~] = rziegler_nic([K, L, T, N, Kc, Tc]);
step(feedback(Gc_rzn * G, H));
print('../../Figure/Q1/b/rzn.png','-dpng','-r400');
% modified ziegler nichols
rb = 1;
for pb = 5:5:35
    [Gc_mzn, ~, ~, ~, ~] = ziegler_nic(3, [K, Tc, rb, pb, N]);
    step(feedback(Gc_mzn * G, 1), 50)
    hold on;
end
legend('$r_b = 5$', '$r_b = 10$', '$r_b = 15$', '$r_b = 20$', ...
     '$r_b = 25$', '$r_b = 30$', '$r_b = 35$', 'interpreter', 'latex')
print('../../Figure/Q1/b/mzn.png','-dpng','-r400');
hold off
% Cohen Coon
[Gc_cc, ~, ~, ~, ~] = cohen_pid(3, 1,[K, L, T, N]);
step(feedback(Gc_cc * G, 1));
print('../../Figure/Q1/b/cc.png','-dpng','-r400');
% Cohen Coon revisited
[Gc_ccr, ~, ~, ~, ~] = cohen_pid(3, 2,[K, L, T, N]);
step(feedback(Gc_ccr * G, 1));
print('../../Figure/Q1/b/ccr.png','-dpng','-r400');
% Astrom Hagglund
[Gc_ah, ~, ~, ~, ~] = AH_pid(2, [K, L, T, N], 0);
step(feedback(Gc_ah * G, 1));
print('../../Figure/Q1/b/ah.png','-dpng','-r400');
% Frequency based Astrom Hagglund
[Gc_fah, ~, ~, ~, ~] = AH_pid(2, [Kc, Tc, Kp, N], 1);
step(feedback(Gc_fah * G, 1));
print('../../Figure/Q1/b/fah.png','-dpng','-r400');
% CHR 0 overshoot
[Gc_chrzero,~ , ~, ~, ~] = chr_pid(3, 1, [K, L, T, N, 0]);
step(feedback(Gc_chrzero * G, 1));
print('../../Figure/Q1/b/chr0.png','-dpng','-r400');
% CHR 20 overshoot
[Gc_chrtwenty,~ , ~, ~, ~] = chr_pid(3, 1, [K, L, T, N, 1]);
step(feedback(Gc_chrtwenty * G, 1));
print('../../Figure/Q1/b/chr20.png','-dpng','-r400');
% WJC 
[Gc_wjc, ~, ~, ~] = wjcpid([K, L, T, N]);
step(feedback(Gc_wjc * G, 1));
print('../../Figure/Q1/b/wjc.png','-dpng','-r400');
% optimum pid
[Gc_opt, ~, ~, ~, ~] = opt_pid(3, 1, [K, L, T, N, 2]);
step(feedback(Gc_opt * G, 1));
print('../../Figure/Q1/b/optpid.png','-dpng','-r400');
% optimum pi-d
[Gc_opt1, H, ~, ~, ~] = opt_pid(4, 1, [K, L, T, N, 2]);
step(feedback(Gc_opt1 * G, H));
print('../../Figure/Q1/b/optpi-d.png','-dpng','-r400');