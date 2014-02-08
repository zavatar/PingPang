function Search()
figure; hold on;
view(3)

H = 0.1525;
W = 1.525;
L = 2.74;
L2 = L/2;
Tmax = 1.0;

Omega = [0 0 0];
optOmega = [0 0 0];
Pos0 = [-L2/3 0 0];
Pos1 = [L2 W/2 0];
time = Tmax;

[time minH] = minTime(Pos0, Pos1, Omega, time, H);

for wx = -160:40:160
    fprintf('.');
    for wy = -160:40:160
        for wz = -160:40:160
            Omega = [wx wy wz];
            [tmpT tmpH] = minTime(Pos0, Pos1, Omega, time, H);
            if tmpT < time || tmpT == time && tmpH > H && tmpH < minH
                minH = tmpH;
                time = tmpT;
                optOmega = Omega;
            end
        end
    end
end

minH
time
optOmega
[V0 V1] = PingPangBVP(Pos0, Pos1, optOmega, time, 1);

grid on;
axis([-2 2 -3 3 -0.15 0.4])
hold off;

function [time minH] = minTime(Pos0, Pos1, Omega, time, H)
[V0 V1] = PingPangBVP(Pos0, Pos1, Omega, time, 0);
minH = PingPangEvent(Pos0, V0, Omega);
while true
    [V0 V1] = PingPangBVP(Pos0, Pos1, Omega, time-0.01, 0);
    tmpH = PingPangEvent(Pos0, V0, Omega);
    if tmpH > H
        minH = tmpH;
        time = time-0.01;
    else
        break;
    end
end
