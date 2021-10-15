% lag compensation
gamma     = 45;     % degree
gamma_bar = 45 + 5; % degree
% K from part a
K = 5.1300;
% solve phase equation (omega_g)
syms omega_g
% phase equation
eq1 = atan(omega_g / 0.5) - atan(omega_g / 1) - 3 * atan(omega_g / 1.5) ...
    - atan(omega_g / 2) == -130 / 180 * pi;
% solve equation 
omega_g_ans = double(vpasolve(eq1)); % convert syms to double
% solve amplitude ratio
beta = K*50 * sqrt((omega_g_ans^2 + 0.25)) / ...
(sqrt((omega_g_ans^2 + 1)) * sqrt((omega_g_ans^2 + 2.25))^3 *...
sqrt((omega_g_ans^2 + 4)));
T = 2 / omega_g_ans;
K_c = K / beta;
% define lag compensation
s = tf('s');
G_c = K_c * (s + 1 / T) / (s + 1 / (beta * T));
bode(G_c);
print('../../../Figure/Q1/b/controller.png','-dpng','-r400');
G   = 50 * (s+ 0.5)/((s+1)*(s+1.5)^3*(s+2));
margin(G_c * G);
print('../../../Figure/Q1/b/new_margin.png','-dpng','-r400');
bode(G_1);
hold;
bode(G_c);
bode(G_c*G);
legend('system', 'lead compensation', 'system with lead compensation');
print('../../../Figure/Q1/b/all_in_one.png','-dpng','-r400');


