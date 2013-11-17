function Display()
figure; hold on;
view(3)
PingPang(10.44, 15, -30, [0,0,160]);
PingPang(10.44, 15, -15, [0,40,160]);
PingPang(10.44, 15, 0, [0,80,0]);
PingPang(10.44, 15, 15, [0,120,0]);
PingPang(10.44, 15, 30, [0,160,-160]);
hold off;