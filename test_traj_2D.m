clear; close all;
load('params');
order_to_minimize = 4;
no_of_segments=1;
x1 = zeros(order_to_minimize+1,1);
x2 = zeros(order_to_minimize+1,1);

x1(1) = 1;
x2(1) = 2;

y1 = zeros(order_to_minimize+1,1);
y2 = zeros(order_to_minimize+1,1);

y1(1) = 3;
y2(1) = 4;

points_x = [x1; x2];
points_y = [y1; y2];

% todo wrap all qp solving stuff into a fit spline function

Q_x = calc_Q(order_to_minimize, degree_of_poly_segment, no_of_segments, T);
% imagesc(Q);
[A_x, b_x]= calc_constraints(order_to_minimize, degree_of_poly_segment, no_of_segments, T);
% figure;
% imagesc(A_x);

Q_y = calc_Q(order_to_minimize, degree_of_poly_segment, no_of_segments, T);
% imagesc(Q_y);
[A_y, b_y]= calc_constraints(order_to_minimize, degree_of_poly_segment, no_of_segments, T)
% figure;
% imagesc(A_y);

b_x = points_x;
b_y = points_y; 

[P_x, ~, ~, ~, ~] = quadprog(Q_x,zeros(length(Q_x),1),[],[],A_x,b_x,[],[],[])
[P_y, ~, ~, ~, ~] = quadprog(Q_y,zeros(length(Q_y),1),[],[],A_y,b_y,[],[],[])

segment_coeff_x{1} = P_x;
segment_coeff_y{1} = P_y;

segment_times = [0 T];
figure;
plot_spline_2D(segment_coeff_x, segment_coeff_y, segment_times);