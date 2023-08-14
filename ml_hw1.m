% Solve system of equations
syms a b c d
eqns = [(a+b)*(a+c) == a, (a+b)*(b+d) == b, (c+d)*(a+c)==c, (c+d)*(b+d)==d, a+b+c+d ==1];
S = solve(eqns)