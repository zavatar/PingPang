function Display()
figure; hold on;
view(3)
[time T] = PingPangIVP(10.44, 15, -30, [0,0,160]);
PingPangBVP([0,0,160], time, T);
[time T] = PingPangIVP(10.44, 15, -15, [0,40,160]);
PingPangBVP([0,40,160], time, T);
[time T] = PingPangIVP(10.44, 15, 0, [0,80,0]);
PingPangBVP([0,80,0], time, T);
[time T] = PingPangIVP(10.44, 15, 15, [0,120,0]);
PingPangBVP([0,120,0], time, T);
[time T] = PingPangIVP(10.44, 15, 30, [0,160,-160]);
PingPangBVP([0,160,-160], time, T);
hold off;