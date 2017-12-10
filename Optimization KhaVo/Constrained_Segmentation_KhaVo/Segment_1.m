% Segmenting with no interpolation

clear all
load('data1.mat');

sig3 = sig(1:5000);
Signal = sig3;

sample_rate = 360;  % in Hz
min_Pattern_Length = 0.6*sample_rate; % in seconds
max_Pattern_Length = 1*sample_rate;   % in seconds
Window_Length = 2*min_Pattern_Length;
step = 5; % step for interpolation optimization
% Objective = zeros(Window_Length - min_Pattern_Length);
min_Window_Length = 2*min_Pattern_Length - max_Pattern_Length;

begin_Index = 1;
p = 1;

while begin_Index + Window_Length < length(Signal);
    
iter = 0;
for w = (Window_Length - max_Pattern_Length):(Window_Length - min_Pattern_Length)
    iter = iter + 1;
    P2 = Signal(Window_Length + begin_Index - w:begin_Index+Window_Length-1); %P2: second pattern
    P1 = Signal(begin_Index:begin_Index+w-1); %P1: first pattern

    Objective(iter) =sum((P1 - P2).^2);
end

[~,par] = min(Objective);
Partition_Position(p) = begin_Index + max_Pattern_Length - par;
begin_Index = Partition_Position(p);
p = p + 1;
end

figure; hold on;
 plot(Signal)
for idx = 1 : length(Partition_Position)
    plot([Partition_Position(idx) Partition_Position(idx)], [-1 1]);
end
