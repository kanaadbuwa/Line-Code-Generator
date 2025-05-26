clc;
clear all;
close all;

% Get binary input
data = input('Enter binary data (e.g., [1 0 1 1 0 0 1]): ');

% Validation
if ~isvector(data) || ~all(ismember(data, [0 1]))
    error('Input must be a binary vector like [1 0 1 1]');
end

% Ensure even length for quaternary
if mod(length(data), 2) ~= 0
    data(end+1) = 0; % Pad with zero
end

bit_duration = 1;
fs = 100;  % samples per bit
n = length(data);
t_bit = linspace(0, n, n*fs);
quaternary_data = reshape(data, 2, [])'; % reshape for 2-bit symbols

% Preallocate
NRZ_L = zeros(1, n*fs);
NRZ_I = zeros(1, n*fs);
RZ = zeros(1, n*fs);
Manchester = zeros(1, n*fs);
Diff_Manchester = zeros(1, n*fs);
AMI = zeros(1, n*fs);
Pseudoternary = zeros(1, n*fs);
Quaternary = zeros(1, length(quaternary_data)*2*fs);  % 2 bits = 1 symbol

% --- Line Code Generation ---
% NRZ-L
for i = 1:n
    NRZ_L((i-1)*fs+1:i*fs) = 2*data(i)-1;
end

% NRZ-I
prev = 1;
for i = 1:n
    if data(i) == 1
        prev = -prev;
    end
    NRZ_I((i-1)*fs+1:i*fs) = prev;
end

% RZ
for i = 1:n
    if data(i) == 1
        RZ((i-1)*fs+1:i*fs/2) = 1;
    end
end

% Manchester
for i = 1:n
    if data(i) == 1
        Manchester((i-1)*fs+1:(i-1)*fs+fs/2) = 1;
        Manchester((i-1)*fs+fs/2+1:i*fs) = -1;
    else
        Manchester((i-1)*fs+1:(i-1)*fs+fs/2) = -1;
        Manchester((i-1)*fs+fs/2+1:i*fs) = 1;
    end
end

% Differential Manchester
prev = -1;
for i = 1:n
    if data(i) == 0
        prev = -prev;
    end
    Diff_Manchester((i-1)*fs+1:(i-1)*fs+fs/2) = prev;
    Diff_Manchester((i-1)*fs+fs/2+1:i*fs) = -prev;
end

% AMI
last = -1;
for i = 1:n
    if data(i) == 1
        last = -last;
        AMI((i-1)*fs+1:i*fs) = last;
    end
end

% Pseudoternary
last = -1;
for i = 1:n
    if data(i) == 0
        last = -last;
        Pseudoternary((i-1)*fs+1:i*fs) = last;
    end
end

% Quaternary
for i = 1:size(quaternary_data,1)
    bits = quaternary_data(i,:);
    idx = (i-1)*2*fs + 1 : i*2*fs;
    if isequal(bits, [0 0])
        Quaternary(idx) = -3;
    elseif isequal(bits, [0 1])
        Quaternary(idx) = -1;
    elseif isequal(bits, [1 0])
        Quaternary(idx) = 1;
    elseif isequal(bits, [1 1])
        Quaternary(idx) = 3;
    end
end

% --- Plotting Setup ---
linecodes = {NRZ_L, NRZ_I, RZ, Manchester, Diff_Manchester, AMI, Pseudoternary, Quaternary};
titles = {'NRZ-L', 'NRZ-I', 'RZ', 'Manchester', 'Differential Manchester', 'AMI', 'Pseudoternary', 'Quaternary'};
colors = {'b','r','g','m','k','c','y',[0.4940 0.1840 0.5560]};

figure('Name','All Line Codes with Graph Paper Background','NumberTitle','off');

for i = 1:length(linecodes)
    subplot(4,2,i);
    y = linecodes{i};
    if i == 8
        t_plot = linspace(0, length(y)/fs, length(y)); % quaternary has half the number of symbols
    else
        t_plot = t_bit;
    end
    plot(t_plot, y, 'Color', colors{i}, 'LineWidth', 2);
    title(titles{i});
    xlabel('Time');
    ylabel('Amplitude');
    ylim([-4.5 4.5]);
    xlim([0 max(t_plot)]);
    
    % Graph background
    ax = gca;
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    ax.GridColor = [0.7 0.7 0.7];
    ax.GridAlpha = 0.6;
    ax.Layer = 'top';
    
    % Add bit separators
    hold on;
    for x = 0:1:max(t_plot)
        xline(x, '--k', 'Alpha', 0.2);
    end
end

sgtitle('Digital Line Coding Techniques');

