% ss error
G_gain = 50 * 0.5 / (1 * 1.5^3 * 2);
K      = 19 / G_gain;
% define omega
syms omega_g;
% define equation
eq1 = 2500 * (omega_g^2 + 0.25) == ...
(omega_g^2 + 1) * (omega_g^2 + 2.25)^3 * (omega_g^2 + 4);
% solve numerically
answer_eq1 = vpasolve(eq1);
% find answe
omega_g_ans = 0;
for i = 1:length(answer_eq1)
    if isreal(answer_eq1(i)) && answer_eq1(i) > 0
        omega_g_ans = answer_eq1(i);
    end
end
% find phase margin
gamma = pi + atan(omega_g_ans/0.5) - atan(omega_g_ans/1) - ...
          3 * atan(omega_g_ans/1.5) - atan(omega_g_ans/2);
gamma = gamma * 180 / pi;
% add transfer function and check margin
s = tf('s');
G = 50 * (s+ 0.5)/((s+1)*(s+1.5)^3*(s+2));
margin(G);
print('../../../Figure/Q1/a/margin.png','-dpng','-r400');
gamma_bar = 45 + 5; % from qestion + 5 degree
phi_m     = gamma_bar - gamma;
alpha     = (1 - sin(phi_m*pi/180)) / (1 + sin(phi_m*pi/180));
% omega_m
% define omega_m
syms omega_m;
eq2 = K^2 * 2500 * (omega_m^2 + 0.25) == ...
alpha * ((omega_m^2 + 1) * (omega_m^2 + 2.25)^3 * (omega_m^2 + 4));
K_c = K / alpha;
answer_eq2 = vpasolve(eq2);
omega_m_ans = 0;
for i = 1:length(answer_eq2)
    if isreal(answer_eq2(i)) && answer_eq2(i) > 0
        omega_m_ans = answer_eq2(i);
    end
end
T = 1 / (omega_m_ans * sqrt(alpha));
% Syms to double
K_c   = double(K_c);
alpha = double(alpha);
T     = double(T);
% make lead controler
G_c = K_c * (s + 1 / T) / (s + 1 / (T * alpha));
% add controller to system
margin(G_c * G);