% This script will plot piezo position, command and neural frames
% helps to investigate potential problems with piezo position/timing/etc.
%
% load Timeline into the workspace (variable Timeline)
% run this script

figure;
indPiezoCommand = Timeline.hw.inputs(find(ismember({Timeline.hw.inputs.name}, 'piezoCommand'))).arrayColumn;
indPiezoPos = Timeline.hw.inputs(find(ismember({Timeline.hw.inputs.name}, 'piezoPosition'))).arrayColumn;
indFrames = Timeline.hw.inputs(find(ismember({Timeline.hw.inputs.name}, 'neuralFrames'))).arrayColumn;
t = Timeline.rawDAQTimestamps/60; % in minutes
piezoCommand = Timeline.rawDAQData(:, indPiezoCommand);
piezoPosition = Timeline.rawDAQData(:, indPiezoPos);
frameCounter = Timeline.rawDAQData(:, indFrames);
frameCounter = frameCounter/max(frameCounter);
plot(t, [piezoCommand, piezoPosition])
hold on;
plot(t, frameCounter*10, 'LineWidth', 2);
axis tight
title(strrep(Timeline.expRef, '_', '\_'))
xlabel('time [min]')
ylabel('Voltage [V]')
legend('piezo command', 'piezo position', 'frame counter (scaled)');