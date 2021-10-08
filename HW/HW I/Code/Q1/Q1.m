% declare transfer function
s   = tf('s');
tau = 1;
G   = exp(-tau * s);
% plot bode
bode(G)
print('../../Figure/Q1/bode','-dpng','-r400');
% plot nyquist
nyquist(G)
print('../../Figure/Q1/nyquist','-dpng','-r400');