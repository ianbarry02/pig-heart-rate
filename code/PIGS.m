% Ian Barry 2023
% Code derived from Image Analyst Find Peaks in Data documentation
% https://www.mathworks.com/help/signal/ug/find-peaks-in-data.html
% and findpeaks documentation
% https://www.mathworks.com/help/signal/ug/find-peaks-in-data.html

% Choose .csv        
[filename, pathname] = uigetfile(...
      {'*.csv'},...
      'Choose the CSV file...');
if pathname == 0; return; end
dataFldr = pathname;

% Convert .csv to .mat
file = fullfile(pathname, filename)
T = readtable(file)
p=T{:,1};
q=T{:,2};
r=T{:,3};
save('data.mat', 'p', 'q', 'r')

% Peaks
new_file = load ('data.mat');

figure

time = new_file.q;
intensity = new_file.r;

[pks, locs] = findpeaks(intensity, time, 'MinPeakProminence', 0.5)

plot(time, intensity, locs, pks, 'o'); grid on
ax = axis; axis([ax(1:2) 0 260])
title('Mean Gray Level Fluctuations')
xlabel('Time (s)'); ylabel('Mean Gray Level')
legend('Mean Gray Level', 'Peaks')

%A = [intensity; locs];
%fileID = fopen('f.txt','w');
%fprintf(fileID,'%6s %12s\n','intensity','A');
%fprintf(fileID,'%6.2f %12.8f\n',A);
%fclose(fileID);

% Write file
new_file = 'locs.xls';
writematrix(locs, new_file)

