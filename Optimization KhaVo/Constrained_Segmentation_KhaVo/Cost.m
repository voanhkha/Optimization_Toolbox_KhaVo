function y = Cost(x, mu)

L_mu = length(mu);
x_resampled = resample(x,L_mu,length(x));
L_x_resampled = length(x_resampled);
y = sum((x_resampled(1:min(L_x_resampled,L_mu)) - mu(1:min(L_x_resampled,L_mu))).^2);