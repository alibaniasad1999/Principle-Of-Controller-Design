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
G_opt = K * exp(-L * s) / (T * s + 1); % change G_opt shape

N = 10;
% ziegler nichols
[Gc_zn, ~, ~, ~, ~] = ziegler_nic(3, [K, L, T, N]);
% refined ziegler nichols
[Gc_rzn, ~, ~, ~, ~, ~] = rziegler_nic([K, L, T, N, Kc, Tc]);
% modified ziegler nichols
% Cohen Coon
[Gc_cc, ~, ~, ~, ~] = cohen_pid(3, 1,[K, L, T, N]);
% Cohen Coon revisited
[Gc_ccr, ~, ~, ~, ~] = cohen_pid(3, 2,[K, L, T, N]);
% % Astrom Hagglund
% [Gc_ah, ~, ~, ~, ~] = AH(2, 1, [K, L, T, N]);
% % Frequency Astrom Hagglund
% [Gc_fah, ~, ~, ~, ~] = AH(2, 2, [dcgain(G), Kc, Tc, N]);