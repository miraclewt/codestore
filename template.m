% Generate data
x = 0:0.1:10;
y = sin(x);

% Set figure size and position
figure('Position', [100 100 800 600]);

% Plot data
plot(x, y, 'LineWidth', 2);

% Add labels and title
xlabel('X');
ylabel('Y');
title('Sine Function');

% Set font size and axis limits
set(gca, 'FontSize', 12);
xlim([0 10]);
ylim([-1 1]);

% Add grid
grid off;

% Set font to Times New Roman
set(gcf, 'Color', 'none');
set(gca, 'FontName', 'Times New Roman');
set(gca, 'TitleFontWeight', 'normal');
set(gca, 'TitleFontSizeMultiplier', 1.5);

% Export figure to high-resolution image using export_fig
% export_fig('sine_function.png', '-m2', '-dpi', 600);
export_fig('sin_plot_high_res.png', '-png', '-transparent', '-r600');