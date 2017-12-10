function [a, b] = MainPhase(d, bmin, bmax, mu, W, ind)
L_d = length(d);
i = 2*bmax + 1;
while (i <= L_d && i - bmin > 2*bmin)
    w = [];
    for j = max([i - bmax, 2*bmin]):i-bmin
        w(j) = W(j) + Cost(d(j+1:i),mu);
    end
    w_temp = w;  w_temp(w_temp<=0) = NaN; % change 0 values to NaN to get non-zero min
    [W(i),  ind(i)] = min(w_temp);
    i = i + 1;
end

% Trace back the segmented
i = L_d;
cnt = 1;
while i ~= 0
    Idx(cnt) = ind(i);
    i = Idx(cnt);
    cnt = cnt +1 ;
end

figure; hold on;
 plot(d)
for idx = 1 : length(Idx)
    plot([Idx(idx) Idx(idx)], [-1 1]);
end