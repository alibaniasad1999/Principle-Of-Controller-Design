% use stabilizer controller (PD) that tuned in siumulink %
s = tf('s');
P = 364.461239888647;
D = 249.306365660084;
N = 544.288628584821;
stabilizer_controller_tf = P + D * N / (1 + N / s);