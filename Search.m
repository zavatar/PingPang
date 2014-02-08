function Search()
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
Pos1 = [L2 W/2 0];

Omega = [0 0 0];
optOmega = [0 0 0];
time = Tmax;

[time minH] = minTime(Pos0, Pos1, Omega, time, H, p);
figure; hold on;
view(3)
for wx = -160:40:160
    fprintf('.');
    for wy = -160:40:160
        for wz = -160:40:160
            Omega = [wx wy wz];
            [tmpT tmpH] = minTime(Pos0, Pos1, Omega, time, H, p);
            [f] = PingPangBVP(Pos0, Pos1, Omega, time, p);
            plot3(f(:,1), f(:,2), f(:,3), 'o', ...
                'Color', rand(1,3), 'LineWidth', 2, 'MarkerSize', 7);
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

[f] = PingPangBVP(Pos0, Pos1, optOmega, time, p);
plot3(f(:,1), f(:,2), f(:,3), 'o', ...
    'Color', rand(1,3), 'LineWidth', 2, 'MarkerSize', 7);

grid on;
axis([-2 2 -3 3 -0.15 0.4])
hold off;

function [time minH] = minTime(Pos0, Pos1, Omega, time, H, p)
[f minH] = PingPangBVP(Pos0, Pos1, Omega, time, p);
%minH = PingPangEvent(Pos0, V0, Omega);
while true
    [f tmpH] = PingPangBVP(Pos0, Pos1, Omega, time-0.01, p);
    %tmpH = PingPangEvent(Pos0, V0, Omega);
    if tmpH > H
        minH = tmpH;
        time = time-0.01;
    else
        break;
    end
end
