s = tf('s');
a = 1;
K = 1;
G = K/(s * (s^2 + s + a));
nyquist(G);
print('../../Figure/Q2/MATAB-Nyquist','-dpng','-r400');
% a is bigger than K
a = 10;
K = 1;
G = K/(s * (s^2 + s + a));
nyquist(G);
print('../../Figure/Q2/MATAB-Nyquist_a_bigger','-dpng','-r400');
% K is bigger than a
a = 1;
K = 10;
G = K/(s * (s^2 + s + a));
nyquist(G);
print('../../Figure/Q2/MATAB-Nyquist_K_bigger','-dpng','-r400');

