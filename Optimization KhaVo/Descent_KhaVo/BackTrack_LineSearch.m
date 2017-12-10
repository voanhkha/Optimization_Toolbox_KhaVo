function t = BackTrack_LineSearch(f, grad_f,  x_current, Delta_x)
% Author: Kha Vo (voanhkha@yahoo.com)
% Using backtracking line search mentioned in Chapter 9, Convex
% Optimization book, Boyd.
alpha = 0.1;
beta = 0.7;
t = 1;
stopflag = 0;
x = sym('x', [size(x_current) 1]);
while stopflag ~= 1;
    if (double(subs(f, x, x_current + t*Delta_x)) > double(subs(f, x, x_current))...
            + alpha*t*double(subs(grad_f, x, x_current))'*Delta_x)
        t = beta*t;   
    else stopflag = 1;
    end
end