%% PRIMAL SIMPLEX PROCEDURES
function [T,x_opt,z_opt] = primal_process(T0)
% The Primal Simplex procedure begins with the input tableau [A, b; -c', 0], 
% where b must be nonnegative and A must contain identity basis column vectors
% i.e., A = [3 0 4 1; 2 1 5 0] is good.

%% Author: Kha Vo, voanhkha@yahoo.com
% Date Completed: Nov 2017.

stop = 0; iter = 0; T = T0; max_iter = 1000;
m = size(T, 1)-1; n = size(T, 2)-1;
k = min([m, n]); I = eye(k);

% Check if B is nonnegative
if ~all(T(:,end)>=0)
     stop = 1; z_opt = nan;
     fprintf('Error: b must be nonnegative\r')
end

% Check if there is an identity matrix embedded in A and
% make the cost coefficients under basic variables to be zeros.
for i = 1:k
     if ~ismember(I(i,:),T(1:end-1, 1:end-1)','rows')
            stop = 1; z_opt = nan;
            fprintf('Error: Matrix A must contain identity basis vectors\r')
            break
         else
            [~,idx]=ismember(I(i,:),T(1:end-1, 1:end-1)','rows');
            if T(end,idx)~=0
            T = pivot(T, i, idx);
            end
     end
end


%% Main protocol
while stop ~= 1
    
if iter > max_iter
    fprintf('Has iterated %0.0f times. Terminated. \r', max_iter) 
    stop = 1; z_opt = nan;
end

iter = iter + 1;  
[piv_c_value, piv_c] = max(T(end, 1:end-1));

if piv_c_value > 0 
eps = T(1:end-1, end)./T(1:end-1, piv_c);
eps(eps<0) = nan;
[piv_r_val, piv_r] = min(eps,[], 'omitnan');

    if isnan(piv_r_val)
    stop = 1; z_opt = nan;
    fprintf('Program unbounded.') 
    else
    T = pivot(T, piv_r, piv_c);
    end

else
stop = 1; z_opt = T(end, end);
end
end


% x_opt and z_opt extraction from T
if ~isnan(z_opt)
    x_opt = zeros(n, 1);
    for i = 1:k
    [~,idx]=ismember(I(i,:),T(1:end-1, 1:end-1)','rows');
    x_opt(idx) = T(i, end);
    end
else
   x_opt = nan; 
end

T = round(T,9); z_opt = round(z_opt, 9); x_opt=round(x_opt,9);

end