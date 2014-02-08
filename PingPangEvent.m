function H = PingPangEvent(Pos0, V0, Omega)

M = 0.0027;
D = 0.04;
Rho = 1.205;
Cd = 0.2;
g = 9.8;
itv = 0.01;

C2 = pi*Rho*D*D;
C3 = C2*D;
Ma = C3/6;

%(M + Ma/2) * D2x = C3/8*(Omega(2)*Dz-Omega(3)*Dy) - C2*Cd/8* Dx*Dx;
%(M + Ma/2) * D2y = C3/8*(Omega(3)*Dx-Omega(1)*Dz) - C2*Cd/8* Dy*Dy;
%(M + Ma/2) * D2z = C3/8*(Omega(1)*Dy-Omega(2)*Dx) - C2*Cd/8* Dz*Dz+(Ma-M)*g;

F0 = [Pos0 V0];
tspan = 0:itv:1;
p = [M+Ma/2, C3*Omega/8, C2*Cd/8, (Ma-M)*g];
options = odeset('Events', @pendevent);
[t, f, te, fe, ie] = ode45(@ODES, tspan, F0, options, p);
H = fe(3);

function [lookfor stop direction] = pendevent(t, f, p)
lookfor = f(1);
stop = 1;
direction = 0;