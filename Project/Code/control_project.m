clc
clear all

%system specifications
m = 1;%ball weight (kg)
d = 0.05;%gear rediuce (m)
a = 0.02;%ball rediuce (m)
L = 1;%bar length (m)
g = 9.8;%m/s^2

%transfer functions
s=tf('s');
R_thetagear = m*g*d/(7/5*L*s^2);
thetamotor_V = 0.0274/(0.003228*s^2+0.003508*s);%Inner loop system tf
thetagear_thetamotor = 1/5;%gearbox ratio

R_thetamotor = R_thetagear * thetagear_thetamotor;%outer loop system tf


G_R_V = R_thetagear * thetagear_thetamotor * thetamotor_V