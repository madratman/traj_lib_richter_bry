function Q_final = calc_Q(order_to_minimize, degree_of_poly_segment, no_of_segments, T)

% Q is block diag of no_of_segments submatrices.
% For each segment, Q_i will be of size [order_of_poly,order_of_poly]
% size of Q_final is then [degree_of_poly_segment*order_to_minimize,
% degree_of_poly_segment*order_to_minimize]
no_of_Q = no_of_segments;
Q_final = []; %

for idx_Q = 1:no_of_segments
    Q_curr = zeros([degree_of_poly_segment+1, degree_of_poly_segment+1]);
    for row_idx = 1:size(Q_curr,1)
        for col_idx = 1:size(Q_curr,1)
            i = row_idx-1; % eqn 14 is zero indexed
            l = col_idx-1;
    
            m = 0:order_to_minimize-1; % see eqn 14. We need to take prod of stuff defined inside series from m = [0, r-1]
            stuff_to_multiply = zeros(size(m));
        
            if i>=order_to_minimize && l>=order_to_minimize
                % (row_idx-m), (col_idx-m), and third term are of length order_to_minimize
                stuff_to_multiply = (i-m).*(l-m); % eqn 14
                % just prod of series
                Q_curr(row_idx, col_idx) = 2*prod(stuff_to_multiply)*...
                    T^(i+l-2*order_to_minimize+1) / (i+l-2*order_to_minimize+1);
            end
   
        end
    end
    Q_final = blkdiag(Q_final, Q_curr);
end
