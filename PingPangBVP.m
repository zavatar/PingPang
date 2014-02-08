function [f H] = PingPangBVP(Pos0, Pos1, Omega, time, p)

M = p(1);
D = p(2);
Rho = p(3);
Cd = p(4);
g = p(5);
itv = p(6);

time = time + itv/2;

C2 = pi*Rho*D*D;
C3 = C2*D;
Ma = C3/6;

%(M + Ma/2) * D2x = C3/8*(Omega(2)*Dz-Omega(3)*Dy) - C2*Cd/8* Dx*Dx;
%(M + Ma/2) * D2y = C3/8*(Omega(3)*Dx-Omega(1)*Dz) - C2*Cd/8* Dy*Dy;
%(M + Ma/2) * D2z = C3/8*(Omega(1)*Dy-Omega(2)*Dx) - C2*Cd/8* Dz*Dz+(Ma-M)*g;

F0 = [Pos0 2 0 1];
tspan = 0:itv:time;
B0 = [Pos0 Pos1];
p = [M+Ma/2, C3*Omega/8, C2*Cd/8, (Ma-M)*g, B0];
sol = bvpinit(tspan, F0);
sol = bvp4c(@ODES, @BC, sol, [], p);
f = deval(sol, tspan)';
xl = find(f(:,1)<0, 1, 'last');
xr = find(f(:,1)>0, 1, 'first');
H = f(xl,3) + abs(f(xl,1))*(f(xr,3)-f(xl,3))/(f(xr,1)-f(xl,1));