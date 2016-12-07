function plot_splines_2D(segment_coeff_x, segment_coeff_y, segment_times)

% todo if time : Doxy?
% segment coeff cell has no_of_segments elements, each being an array of
% length = degree of respective segment
% points is an array of n waypoints. size should be [n, 2]. ofc no of
% points = no of polynomial segments-1
% times are ending times for each traj. we'll make a linspace of timesteps 
% and polyeval it at each timestep

no_of_timesteps_per_segment = 100; % todo maybe this should be param with default
coord_x = {};
coord_y = {};

for segment_idx = 1:length(segment_coeff_x)
    % segment_idx
%     hold on;
    coeff_x = segment_coeff_x{segment_idx}; % lowest order to highest order 
    coeff_x = fliplr(coeff_x); % highest order to lowest order
    coeff_y = segment_coeff_y{segment_idx}; 
    coeff_y = fliplr(coeff_y); 
    timesteps = linspace(segment_times(segment_idx), segment_times(segment_idx+1), no_of_timesteps_per_segment);

    coord_x{segment_idx} = polyval(coeff_x, timesteps);
    coord_y{segment_idx} = polyval(coeff_y, timesteps);
    plot(coord_x{segment_idx}, coord_y{segment_idx}); % todo diff colors
end