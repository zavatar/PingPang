function [time Pos1] = PingPangIVP(varargin)
if nargin == 3
    [time Pos1] = PingPangIVP3(varargin{1}, varargin{2}, varargin{3});
elseif nargin == 5
    [time Pos1] = PingPangIVP5(varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5});
end

function [time Pos1] = PingPangIVP5(Pos0, V, Theta, Phi, Omega)

theta = Theta*pi/180;
phi = Phi*pi/180;
Vx0 = cos(phi) * cos(theta) * V;
Vy0 = sin(phi) * cos(theta) * V;
Vz0 = sin(theta) * V;

V0 = [Vx0 Vy0 Vz0];

[time Pos1] = PingPangIVP(Pos0, V0, Omega);

function [time Pos1] = PingPangIVP3(Pos0, V0, Omega)

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
[t, f] = ode45(@ODES, tspan, F0, [], p);
lz = find(f(:,3)>0, 1, 'last');
plot3(f(1:lz,1), f(1:lz,2), f(1:lz,3), 'o', ...
    'Color', rand(1,3), 'LineWidth', 2, 'MarkerSize', 7);
time = (lz-1)*itv;
Pos1 = [f(lz,1) f(lz,2) f(lz,3)];