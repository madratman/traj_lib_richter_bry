function [A_final, b_final]= calc_constraints(order_to_minimize, degree_of_poly_segment, no_of_segments, T)

% A, like Q, is a block diag of no_of_segments submatrices, where each
% submatrix is of size [2*order_to_minimize, degree_of_poly_segment]
% So size of A_final will be [2*order_to_minimize*no_of_segments,
% degree_of_poly_segment*order_to_minimize]

A_final = []; % to init zeros or not to init zeros?
b_final= [];

for idx_Q = 1:no_of_segments
    % A_curr is [A_not; A_t]
    % A_curr = zeros(2*order_to_minimize, degree_of_poly_segment);
    A_not= zeros(order_to_minimize, degree_of_poly_segment);
    A_t = zeros(order_to_minimize, degree_of_poly_segment);

    for r = 1:size(A_not,1)
        for n = 1:size(A_not,2)
            if r == n
                m = 0:r-1;
                stuff_to_multiply = r-m;
                A_not(r,n) = prod(stuff_to_multiply); % eqn 18
            end
             if n >= r-1
                m = 0:r-1;
                stuff_to_multiply = n-m;% eqn 20. 
                % this expression is wrong in the RSS paper (should have been n-m instead of r-m) 
                % Check Bry's thesis, pg 38, eqn 3.36 for correct exp 
                A_t(r,n) = prod(stuff_to_multiply)*T^(n-r);
            end
        end
    end
    A_curr = [A_not; A_t];
    A_final = blkdiag(A_final, A_curr);
end
