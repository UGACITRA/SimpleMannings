% Step 2: Solve Mannings for y
y = 10;
LHS = 1;
RHS = 0;
iter = 0;
maxi = 100000;
tol = 1e-4;
while abs(LHS-RHS) > tol
    b = by_ratio*y;
    A = b*y + z*(y^2);
    R = A/(b + 2*y*sqrt(z^2+1));
    LHS = A*R^(2/3);
    RHS = (Q*n)/(Phi*sqrt(So));
    y = y - yInc;
    iter = iter + 1;

    if y < 0
        error('y is negative')
    end

    if iter > maxi
        error('maximum iteration reached without convergence')
    end
end
