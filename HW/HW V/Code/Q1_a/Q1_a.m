s = tf('s');
G = (s + 1) / (s^2 - 2 * s + 4);
rlocus(G);
print('../../Figure/Q1/Q1_a/rlocus.png','-dpng','-r400');
step(feedback(G, 1));
print('../../Figure/Q1/Q1_a/feedback_step.png','-dpng','-r400');
bode(feedback(G, 1));
print('../../Figure/Q1/Q1_a/feedback_bode.png','-dpng','-r400t');
bode(G);
print('../../Figure/Q1/Q1_a/openloop_bode.png','-dpng','-r400');
s_function = 1 / (1 + G);
bode(s_function);
print('../../Figure/Q1/Q1_a/s_bode.png','-dpng','-r400');
t_function = G / (1 + G);
bode(t_function);
print('../../Figure/Q1/Q1_a/t_bode.png','-dpng','-r400');