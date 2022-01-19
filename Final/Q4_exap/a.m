clear
s = tf('s');
G = 2*(-s+1)/(s^2+s+2);
Q = 6/(s+6) * (s^2+s+2) / (2*(s+1));
T = 6/(s+6)* (-s+1)/(s+1);
figure(1)
step(T)
figure(2)
Gyd = G*(1-T);
step(Gyd)
figure(3)
step(Q)
K = Q / (1 - G*Q);
syms x
kx = simplify(poly2sym(K.Numerator{1})/poly2sym(K.Denominator{1}, x));
a_r = [3 3 6];
b_r = [1 13 0];