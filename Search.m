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
Tmax = 0.5;

PosA = [[-L2/3 W/2 H/3];
        [-L2/3 0 H/3];
        [-L2/3 -W/2 H/3];
        [-L2/3 W/2 2*H/3];
        [-L2/3 0 2*H/3];
        [-L2/3 -W/2 2*H/3];
        [-L2/3 W/2 H];
        [-L2/3 0 H];
        [-L2/3 -W/2 H]];
PosB = [[L2 W/2 0];
        [L2 W/4 0];
        [L2 0 0];
        [L2 -W/4 0];
        [L2 -W/2 0]];

for k = 1:9
    H0 = figure; hold on; grid on;
    view(3)
    Hi = figure; hold on; grid on;
    view(3)
    for i = 1:5
        c = clock;
        Clock = fix(c(4:6))
        figure(H0);
        time = Tmax;
        Omega = [0 0 0];
        optOmega = [0 0 0];
        [time minH] = minTime(PosA(k,:), PosB(i,:), Omega, time, H, p);
        for wx = -160:40:160
            fprintf('.');
            for wy = -160:40:160
                for wz = -160:40:160
                    Omega = [wx wy wz];
                    [tmpT tmpH] = minTime(PosA(k,:), PosB(i,:), Omega, time, H, p);
                    %{
                    if tmpH > H
                        [f] = PingPangBVP(PosA(k,:), PosB(i,:), Omega, time, p);
                        plot3(f(:,1), f(:,2), f(:,3), 'o', ...
                            'Color', rand(1,3), 'LineWidth', 2, 'MarkerSize', 7);
                    end
                    %}
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

        figure(Hi);
        [f] = PingPangBVP(PosA(k,:), PosB(i,:), optOmega, time, p);
        plot3(f(:,1), f(:,2), f(:,3), 'o', ...
            'Color', rand(1,3), 'LineWidth', 2, 'MarkerSize', 7);
        V = [f(1,4), f(1,5), f(1,6)]
    end
    figure(H0);
    hold off;
    figure(Hi);
    %axis([-2 2 -3 3 -0.15 0.4])
    hold off;
end

for k = 1:9
    H0 = figure; hold on; grid on;
    view(3)
    Hi = figure; hold on; grid on;
    view(3)
    for i = 1:5
        c = clock;
        Clock = fix(c(4:6))
        figure(H0);
        time = Tmax;
        Omega = [0 0 0];
        optOmega = [0 0 0];
        [time minH] = minTime(PosA(k,:), PosB(i,:), Omega, time, H, p);
        for wx = -160:20:160
            fprintf('.');
            for wy = -160:20:160
                for wz = -160:20:160
                    Omega = [wx wy wz];
                    [tmpT tmpH] = minTime(PosA(k,:), PosB(i,:), Omega, time, H, p);
                    %{
                    if tmpH > H
                        [f] = PingPangBVP(PosA(k,:), PosB(i,:), Omega, time, p);
                        plot3(f(:,1), f(:,2), f(:,3), 'o', ...
                            'Color', rand(1,3), 'LineWidth', 2, 'MarkerSize', 7);
                    end
                    %}
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

        figure(Hi);
        [f] = PingPangBVP(PosA(k,:), PosB(i,:), optOmega, time, p);
        plot3(f(:,1), f(:,2), f(:,3), 'o', ...
            'Color', rand(1,3), 'LineWidth', 2, 'MarkerSize', 7);
        V = [f(1,4), f(1,5), f(1,6)]
    end
    figure(H0);
    hold off;
    figure(Hi);
    %axis([-2 2 -3 3 -0.15 0.4])
    hold off;
end

function [time minH] = minTime(Pos0, Pos1, Omega, time, H, p)
[f minH] = PingPangBVP(Pos0, Pos1, Omega, time, p);
%minH = PingPangEvent(Pos0, V0, Omega);
while true
    [f tmpH] = PingPangBVP(Pos0, Pos1, Omega, time-0.01, p);
    %tmpH = PingPangEvent(Pos0, V0, Omega);
    if tmpH > H
        minH = tmpH;
        time = time-0.01;
        plot3(f(:,1), f(:,2), f(:,3), 'o', ...
            'Color', rand(1,3), 'LineWidth', 2, 'MarkerSize', 7);
    else
        break;
    end
end
