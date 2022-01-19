Q2;
syms s a b c
Q = (a*s+b)/(s+c);
K = collect((X+Ms*Q)/(Y-Ns*Q),s);
c = 0.5;
b = 17*c; a = -(6*b+13*c+34)/2;
K = subs(K);
[Kn,Kd] = numden(K);
K = tf(sym2poly(Kn),sym2poly(Kd));
G_cl = feedback(K*G,1);
figure(3)
step(G_cl)
figure(4)
s = tf('s');
impulse(1/s - 1/s*G_cl)
isstable(k)