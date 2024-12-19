% MATLAB Script to Plot Signal Constellation Diagram using polarplot and polarscatter

% Define energy of the signals (E1 = 1 for simplicity)
E1 = 1;

% Define signal vectors (radii and angles in polar coordinates)
radii = [sqrt(E1), sqrt(E1), 2*sqrt(E1), 2*sqrt(E1)]; % Magnitudes
angles = [0, atan(sqrt(1/3)), pi, pi + atan(sqrt(1/3))]; % Angles in radians

% Convert to Cartesian coordinates for additional plotting
[x, y] = pol2cart(angles, radii);

% Plotting the signal constellation using polarscatter
figure;
h = polaraxes;
h.ThetaZeroLocation = 'top';
h.ThetaDir = 'counterclockwise';

% Scatter points
polarscatter(angles, radii, 100, 'filled', 'r');
hold on;

% Label points with their respective signal vectors
text(x(1), y(1), 's_1', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
text(x(2), y(2), 's_2', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
text(x(3), y(3), 's_3', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
text(x(4), y(4), 's_4', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

% Add grid for better clarity
polarplot([0, angles(1)], [0, radii(1)], 'k--');
polarplot([0, angles(2)], [0, radii(2)], 'k--');
polarplot([0, angles(3)], [0, radii(3)], 'k--');
polarplot([0, angles(4)], [0, radii(4)], 'k--');

% Overlay Cartesian axes for clarity
cartesian_axes_limits = 2.5; % Define limits for the Cartesian axes
plot([-cartesian_axes_limits, cartesian_axes_limits], [0, 0], 'k-', 'LineWidth', 1.5); % X-axis
plot([0, 0], [-cartesian_axes_limits, cartesian_axes_limits], 'k-', 'LineWidth', 1.5); % Y-axis

% Label axes
txt_offset = 0.2; % Offset for axis labels
text(cartesian_axes_limits - txt_offset, 0, 'x', 'FontSize', 10, 'HorizontalAlignment', 'center');
text(0, cartesian_axes_limits - txt_offset, 'y', 'FontSize', 10, 'HorizontalAlignment', 'center');

% Add decision regions (triangular boundaries for simplicity)
fill([x(1), x(2), 0], [y(1), y(2), 0], 'b', 'FaceAlpha', 0.1, 'EdgeColor', 'none'); % Region for s1
fill([x(2), x(4), 0], [y(2), y(4), 0], 'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none'); % Region for s2
fill([x(3), x(1), 0], [y(3), y(1), 0], 'r', 'FaceAlpha', 0.1, 'EdgeColor', 'none'); % Region for s3
fill([x(4), x(3), 0], [y(4), y(3), 0], 'y', 'FaceAlpha', 0.1, 'EdgeColor', 'none'); % Region for s4

% Add title
title('Signal Constellation Diagram with Decision Regions');

% Customize and hold off
hold off;
