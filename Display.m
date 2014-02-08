function Display()
L = 2.74;
L2 = L/2;
Pos0 = [-L2/3 0 0];
figure; hold on;
view(3)
[time Pos1] = PingPangIVP(Pos0, 10.44, 15, -30, [0,0,160]);
[V0 V1] = PingPangBVP(Pos0, Pos1, [0,0,160], time);
%{
[time Pos1] = PingPangIVP(Pos0, 10.44, 15, -15, [0,40,160]);
PingPangBVP(Pos0, Pos1, [0,40,160], time);
[time Pos1] = PingPangIVP(Pos0, 10.44, 15, 0, [0,80,0]);
PingPangBVP(Pos0, Pos1, [0,80,0], time);
[time Pos1] = PingPangIVP(Pos0, 10.44, 15, 15, [0,120,0]);
PingPangBVP(Pos0, Pos1, [0,120,0], time);
[time Pos1] = PingPangIVP(Pos0, 10.44, 15, 30, [0,160,-160]);
PingPangBVP(Pos0, Pos1, [0,160,-160], time);
%}
xlabel('水平位移(m)')
ylabel('横向位移(m)')
zlabel('垂直位移(m)')
grid on;
axis([-2 2 -3 3 -0.15 0.4])
hold off;