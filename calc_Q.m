function Q_final = calc_Q(order_to_minimize, degree_of_poly_segment, no_of_segments, T)

% Q is block diag of no_of_segments submatrices.
% For each segment, Q_i will be order_of_poly*order_of_poly
% size of Q_final is then [degree_of_poly_segment*order_to_minimize,
% degree_of_poly_segment*order_to_minimize]
no_of_Q = no_of_segments;
Q_final = []; %

for idx_Q = 1:no_of_segments
    Q_curr = zeros([degree_of_poly_segment, degree_of_poly_segment]);
    for row_idx = 1:size(Q_curr,1)
        for col_idx = 1:size(Q_curr,1)
            m = 0:order_to_minimize-1; % see eqn 14. We need to take prod of stuff defined inside series from m = [0, r-1]
            stuff_to_multiply = zeros(size(m));
        
            if row_idx>=order_to_minimize && col_idx>=order_to_minimize
                % (row_idx-m), (col_idx-m), and third term are of length order_to_minimize
                stuff_to_multiply = (row_idx-m).*(col_idx-m).* ...
                    ( (T^(row_idx+col_idx-2*order_to_minimize+1)) / (row_idx+col_idx-2*order_to_minimize+1) ); % eqn 14
                % just prod of series
                Q_curr(row_idx, col_idx) = 2*prod(stuff_to_multiply);
            else 
                Q_curr(row_idx, col_idx) = 0;
            end
   
        end
    end
    
    Q_final = blkdiag(Q_final, Q_curr);
end



