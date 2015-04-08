function deriv = dydt(t, y, obj, u)

X_g = y(1:3);
X_b_dot = y(4:6);

phi = X_g(3);
gbR = [cos(phi), -sin(phi), 0;
       sin(phi),  cos(phi), 0;
              0,         0, 1];

dPhiDt = [0 0 1]*X_b_dot;

X_b_dot_dot = obj.A_1*X_b_dot + obj.A_2*X_b_dot*dPhiDt + obj.B*u;
deriv = [gbR*X_b_dot; X_b_dot_dot];
