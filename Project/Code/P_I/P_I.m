% part I %
opt = stepDataOptions('StepAmplitude',0.5);
step(feedbacl(C_LQC*G_R_V), opt);