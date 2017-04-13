function setup = spcplot_setup
% setup = spcplot_setup
% spcplot default setting

% X, Y scales
setup.xScale = 'linear';  % 'log', 'linear'
setup.yScale = 'linear';

% Legend format
setup.legend = 'short'; % 'long', 'short', 'null'
setup.legendWidth = 24;
setup.legendLocation = 'NorthWest';

% Color scheme
setup.colorScheme = 'contrast';    % 'contrast', 'jet', 'custom'
setup.color=[];

% Whether to show lines in addition to symbols
setup.showLine = 1;