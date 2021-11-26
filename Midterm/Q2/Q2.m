s = tf('s');
G = (s + 4) / (s * (s^2 + 0.6 * s + 1) * (s + 6));
G_1 = 1 / G;
theta = 0:0.01:2*pi;
plot(-1 + 0.5*exp(i*theta));
hold
nyquist(G_1);
nyquist(0.5*G_1);
nyquist(0.45*G_1);
