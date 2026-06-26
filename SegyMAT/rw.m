clc
clear all
% [Data,SegyTraceHeaders,SegyHeader]=ReadSegy('5234ban.sgy');
data=importdata('dilate_signal.mat');
WriteSegy('dilate_signal.sgy',data);