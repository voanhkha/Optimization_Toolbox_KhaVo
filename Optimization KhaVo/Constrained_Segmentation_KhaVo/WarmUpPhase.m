function [W, ind] = WarmUpPhase(d, bmin, bmax, mu)

i = 2*bmin - 1;
while i < 2*bmax
    i = i+1;
    w = [];
    for j = max([bmin, i - bmax]):min([bmax, i - bmin])
        w(j) = Cost(d(1:j),mu) + Cost(d(j+1:i), mu);   
    end
    w_temp = w;  w_temp(w_temp<=0) = NaN;
    [W(i),  ind(i)] = min(w_temp);
    k = floor(i/bmin);
    if k >= 3
           w1 = [];
           for j = (k-1)*bmin:i-bmin
             w1(j) = W(j) + Cost(d(j-1:i),mu);
           end
           w1_temp = w1;  w1_temp(w1_temp<=0) = NaN;
           W1 = min(w1_temp);
           W(i) = min([W(i), W1]);
    end
end