function Display()
M = 0.0027;
D = 0.04;
Rho = 1.205;
Cd = 0.2;
g = 9.8;
itv = 0.01;
p = [M, D, Rho, Cd, g, itv];

H = 0.1525;
W = 1.525;
L = 2.74;
L2 = L/2;
Tmax = 1.0;

Pos0 = [-L2/3 0 0];

figure; hold on;
view(3)

[time Pos1] = PingPangIVP(Pos0, 10.44, 15, -30, [0,0,160]);
PingPangBVP(Pos0, Pos1, [0,0,160], time, p);
[time Pos1] = PingPangIVP(Pos0, 10.44, 15, -15, [0,40,160]);
PingPangBVP(Pos0, Pos1, [0,40,160], time, p);
[time Pos1] = PingPangIVP(Pos0, 10.44, 15, 0, [0,80,0]);
PingPangBVP(Pos0, Pos1, [0,80,0], time, p);
[time Pos1] = PingPangIVP(Pos0, 10.44, 15, 15, [0,120,0]);
PingPangBVP(Pos0, Pos1, [0,120,0], time, p);
[time Pos1] = PingPangIVP(Pos0, 10.44, 15, 30, [0,160,-160]);
PingPangBVP(Pos0, Pos1, [0,160,-160], time, p);

xlabel('ˮƽλ��(m)')
ylabel('����λ��(m)')
zlabel('��ֱλ��(m)')
grid on;
axis([-2 2 -3 3 -0.15 0.4])
hold off;