clear
s = tf('s');
G = (3*s-1)/((s-1)*(s+2));
% rlocus(G)
[Ns, Ms, X, Y] = Euclid3_XY (G);
Ns = -1*Ns; X= -1*X;
Ms = -1*Ms; Y= -1*Y;
K = X/Y;
K_1 = -4.5/(10.5/(s + 2.0) - 1.0);
G_cl = feedback(K_1*G,1);
figure(1)
step(G_cl)
figure(2)
impulse(1/s - 1/s*G_cl)
isstable(K_1)
