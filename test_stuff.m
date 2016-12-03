clear; clc; close all;
load('params');
Q_final = calc_Q(order_to_minimize, degree_of_poly_segment, no_of_segments, T);
imagesc(Q_final);
[A_final, b_final]= calc_constraints(order_to_minimize, degree_of_poly_segment, no_of_segments, T)
figure;
imagesc(A_final);