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