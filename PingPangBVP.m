function PingPangBVP(Omega, time, T)

M = 0.0027;
D = 0.04;
Rho = 1.205;
Cd = 0.2;
g = 9.8;

C2 = pi*Rho*D*D;
C3 = C2*D;
Ma = C3/6;

%(M + Ma/2) * D2x = C3/8*(Omega(2)*Dz-Omega(3)*Dy) - C2*Cd/8* Dx*Dx;
%(M + Ma/2) * D2y = C3/8*(Omega(3)*Dx-Omega(1)*Dz) - C2*Cd/8* Dy*Dy;
%(M + Ma/2) * D2z = C3/8*(Omega(1)*Dy-Omega(2)*Dx) - C2*Cd/8* Dz*Dz+(Ma-M)*g;

F0 = [0 0 0 2 0 1];
tspan = 0:0.01:time;
B0 = [0 0 0 T];
p = [M+Ma/2, C3*Omega/8, C2*Cd/8, (Ma-M)*g, B0];
sol = bvpinit(tspan, F0);
sol = bvp4c(@ODES, @BC, sol, [], p);
f = deval(sol, tspan)';
lz = find(f(:,3)>0, 1, 'last');
plot3(f(1:lz,1), f(1:lz,2), f(1:lz,3), 'o', ...
    'Color', rand(1,3), 'LineWidth', 2, 'MarkerSize', 7);
xlabel('ˮƽλ��(m)')
ylabel('����λ��(m)')
zlabel('��ֱλ��(m)')
grid on;
axis([0 5 -3 3 -0.15 0.4])