clear;
clc;
%% Quaetion 1 part b
s = tf('s');
G = (-s + 3) / ((s+2) * (s^2 + 2 * s + 4));

[K, L, T] = get_fod(G); % frequency
N = 10;
G_freq = K * exp(-L * s) / (T * s + 1);
G_n = G_freq / s;
G = G / s;
step(G, 5);
hold
step(G_n, 5)
hold off
print('../../Figure/Q2/IDT1.png','-dpng','-r400');
% key = 1 ---> PD, key = 2 ---> PID
[Gc_pd , ~, ~, ~] = foipdt(1, K, L, T, N); % PD
step(feedback(Gc_pd * G, 1));
print('../../Figure/Q2/foipdt_PD.png','-dpng','-r400');
[Gc_pid, ~, ~, ~] = foipdt(2, K, L, T, N); % PID
step(feedback(Gc_pid * G, 1));
print('../../Figure/Q2/foipdt_PID.png','-dpng','-r400');

G = (-s + 3) / ((s+2) * (s^2 + 2 * s + 4));

[K, L, T] = get_fod(G, 1); % transfer function
G_tran = K * exp(-L * s) / (T * s + 1);
G_tran = G_tran / s;
G = G / s;
step(G, 5);
hold
step(G_tran, 5)
hold off
print('../../Figure/Q2/IDT2.png','-dpng','-r400');
% key = 1 PD, 2 PID
% Key1 = 1 : ISE,  2 : ITSE,  3 : ISTSE
[Gc_pd1 , ~, ~, ~] = ipdtctrl(1, 1, K,L,N); % PD ISE
step(feedback(Gc_pd1 * G, 1));
print('../../Figure/Q2/pd1.png','-dpng','-r400');
[Gc_pd2 , ~, ~, ~] = ipdtctrl(1, 2, K,L,N); % PD ITSE
step(feedback(Gc_pd2 * G, 1));
print('../../Figure/Q2/pd2.png','-dpng','-r400');
[Gc_pd3 , ~, ~, ~] = ipdtctrl(1, 3, K,L,N); % PD ISTSE
step(feedback(Gc_pd3 * G, 1));
print('../../Figure/Q2/pd3.png','-dpng','-r400');
[Gc_pid1, ~, ~, ~] = ipdtctrl(2, 1, K,L,N); % PID ISE
step(feedback(Gc_pid1 * G, 1));
print('../../Figure/Q2/pid1.png','-dpng','-r400');
[Gc_pid2, ~, ~, ~] = ipdtctrl(2, 2, K,L,N); % PID ITSE
step(feedback(Gc_pid2 * G, 1));
print('../../Figure/Q2/pid2.png','-dpng','-r400');
[Gc_pid3, ~, ~, ~] = ipdtctrl(2, 3, K,L,N); % PID ISTSE
step(feedback(Gc_pid3 * G, 1));
print('../../Figure/Q2/pid3.png','-dpng','-r400');