%% parameters
clear;
clc;

dataindex = 1;      % this is the column of the raw data corrrsponding to voltage
cutoff = 50;        % this is the threshold to remove background
binary = 1;         % if 1, creates a binary 1-dimensional array of events
event_freq = 2;     % in Hz, how often events are expected

%% import file

[filename, pathname] = uigetfile( ...
       {'*.m;*.fig;*.mat;*.mdl', 'All MATLAB Files (*.m, *.fig, *.mat, *.mdl)';
        '*.m',  'MATLAB Code (*.m)'; ...
        '*.fig','Figures (*.fig)'; ...
        '*.mat','MAT-files (*.mat)'; ...
        '*.mdl','Models (*.mdl)'; ...
        '*.*',  'All Files (*.*)'}, ...
        'Pick a file', ...
        'MultiSelect', 'on');
File = fullfile(pathname, filename);

rawdata = load(File);

time = rawdata.T;
rawvolt = rawdata.Y(:,dataindex);

fprintf('%s \n\n', filename);     


%% plot raw data
figure(1)
hold on
plot(time, rawvolt, 'Color', 'k');
xlabel('Time (??)');
ylabel('Voltage (??)');
hold off


%% identify number of events
min_time = 1/event_freq;
if binary == 1
    binaryevents = rawvolt > cutoff;
    eventtimes = time(binaryevents);
    uniqueevents = [];
    uniqueevents(1) = eventtimes(1);
    for i = 1:length(eventtimes)-1
        diff_evtimes = eventtimes(i+1) - eventtimes(i);
        if diff_evtimes > min_time
            uniqueevents = [uniqueevents, eventtimes(i+1)];
        end
    end
end
no_events = numel(uniqueevents);
fprintf('Number of events = %d \n\n', no_events)












