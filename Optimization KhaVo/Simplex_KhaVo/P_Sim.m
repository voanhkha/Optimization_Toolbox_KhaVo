%% SOLVING LP USING PRIMAL SIMPLEX METHOD
function [T,x_opt,z_opt] = P_Sim(A, b, c)
% Solving min(c'x) subject to Ax = b, x>=0.
% Input:  A = m-by-n matrix
%---------b = row vector m-by-1 with no
%---------c = row vector n-by-1
% Output: T = final simplex tableau
%---------x_opt = optimal solution
%---------z_opt = optimal objective value

% Example: A = [-2 -1 -2; 3 3 1]; b = [-4 3]'; c = [4 1 1]';

%% Author: Kha Vo, voanhkha@yahoo.com
% Date Completed: Nov 2017.
stop = 0;
[m, n] = size(A); k = min([m n]);
T = [A, b];

% Phase 1: Find an initial basic feasible solution
for i = 1:m
    if b(i) < 0
       T(i,:) = -T(i,:); % reverse sign to make b(i) >= 0 in the initial tableau for Phase 1
    end
end
T = [T(:,1:end-1), eye(m), T(:,end); zeros(1,n), -1*ones(1,m),0];
[P1_tableau,P1_x,P1_z] = primal_process(T);

if P1_z > 0
    stop = 1;
    fprintf('Problem infeasible.\r') 
end




end