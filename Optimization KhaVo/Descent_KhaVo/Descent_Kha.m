%% UNCONSTRAINED OPTIMISATION 
% Version 1.0
% Author: Kha Vo (voanhkha@yahoo.com)

%% Instruction
% Example:
%     f1 = 'exp(x(1)+3*x(2)-0.1) + exp(x(1)-3*x(2)-0.1) + exp(-x(1)-0.1);';
%     [xf1_all, f1_all] = Descent_Kha(f, [-1; 1] ,'gradient' ,'exact');
  
% FUNCTION EXAMPLES
% f = '1/2*(x(1)^2 + 10*x(2)^2);'   % for Figure 9.2  
% f = 'exp(x(1)+3*x(2)-0.1) + exp(x(1)-3*x(2)-0.1) + exp(-x(1)-0.1);' % for Figure 9.3
% f = 'norm(A*x - b)^2;

% METHOD 
% opt_method =  'gradient' or 'steepest' or 'newton'
% linesearch_method = 'exact' or 'backtrack'
% P = [8 0; 0 2]; % only for steepest descent

function [x_all, f_all] = Descent_Kha(f, x0, opt_method, linesearch_method, P_steepest)
%% TOLERANCE
epsilon = 1e-10;

%% PLOT OPTIONS
plotflag = 1;
n_contours = 5; % number of first contours plotted
plot_range = [-3 2 -1.5 1.5]; %[-3 3 -3 3]  [-5 5 -12 12]

%% MAIN PROGRAM
if nargin < 5
    P_steepest = eye(size(x0));
end
if strcmp(opt_method,'steepest')
     P_inv = inv(P_steepest);
end

 x = sym('x', [size(x0) 1]);
 eval(strcat('f = ', f));
 
 grad_f = gradient(f,x); % calculate gradient of f as a function of x
 hess_f = hessian(f,x);
 
 
 x_value = x0; % initial point x0
 f_value = double(subs(f, x, x0)); % initial f(x0)
 grad_value = double(subs(grad_f, x, x0));
 x_all = [];  % store all values of x after each iteration of index k
 f_all = []; % store all values of f(x)
 
 k = 0; % iteration count
 
 while 1

    switch opt_method
        case 'gradient'
        Delta_x = -grad_value;
        cri = norm(grad_value)^2;
        case 'steepest'  
        Delta_x = -P_inv*grad_value;
        cri = norm(grad_value)^2;
        case 'newton'
        hess_value = double(subs(hess_f, x, x_value));
        Delta_x = -(hess_value\grad_value); % equivalent to -inv(hess_value)*grad_value
        lambda_sq = grad_value'*(hess_value\grad_value);
        cri = lambda_sq/2;
    end
    

    % ------ Begin Stopping Criterion ----------%
    if cri <= epsilon
         break;
    end
    % -------- End Stopping Criterion ------------%
    x_all = [x_all, x_value]; %#ok<*AGROW>
    f_all = [f_all, f_value];
    k = k + 1;
    
    switch linesearch_method
        case 'backtrack'
             t = BackTrack_LineSearch(f, grad_f, x_value, Delta_x);
        case 'exact'
             t = Exact_LineSearch(f, grad_f, x_value, Delta_x);
    end
       
    x_value = x_value + t*Delta_x;
    f_value = double(subs(f, x, x_value));
    grad_value = double(subs(grad_f, x, x_value));

 end    
 
if plotflag == 1
figure 
hold on
fcontour(f,plot_range,'LevelList', f_all(1:n_contours), 'LineStyle', '--')
line(x_all(1,:) , x_all(2,:));
end
