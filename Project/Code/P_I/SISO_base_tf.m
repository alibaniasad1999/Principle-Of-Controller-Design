run('../Base/Base_TF');
stabilizer_controller;
G_all_OL = R_V * theta_motor_V * ...
    feedback(stabilizer_controller_tf * R_theta_motor, 1);