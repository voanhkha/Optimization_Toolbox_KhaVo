function t = Exact_LineSearch(f, grad_f,  x_value, Delta_x)
% Author: Kha Vo (voanhkha@yahoo.com)
% Using Golden Section Method as mentioned in Appendix C,
% Nonlinear Programming book, Bertsekas.
tolerance = 1e-5;
tau = (3-sqrt(5))/2;
t = 1;
stopflag = 0;
x = sym('x', [size(x_value) 1]);

% Determine first two ends (a1,a2) by searching for f'(a1)<0 and f'(a2)>0
a2 = 0;
dev_a2 = -1;
while dev_a2 < 0
a1 = a2;
a2 = a2 + 0.5;
dev_a2 =  double(subs(grad_f, x, x_value + a2*Delta_x))'*Delta_x;
end

% Golden Section Method
while stopflag ~= 1;
    if a2-a1 > tolerance        
        b1 = a1 + tau*(a2 - a1);
        b2 = a2 - tau*(a2 - a1);
        ga1 = double(subs(f, x, x_value + a1*Delta_x));
        ga2 = double(subs(f, x, x_value + a2*Delta_x));
        gb1 = double(subs(f, x, x_value + b1*Delta_x));
        gb2 = double(subs(f, x, x_value + b2*Delta_x));    
        if gb1 < gb2
            if ga1 <= gb1
              a2 = b1;
            else
              a2 = b2;
            end            
        elseif gb1 > gb2
            if gb2 >= ga2
                a1 = b2;
            else
                a1 = b1;
            end
        else
           a1 = b1; a2 = b2;          
        end       
    else stopflag = 1;
    end
    
    t = (a2+a1)/2;
end