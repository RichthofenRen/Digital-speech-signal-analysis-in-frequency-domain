%function final = demo(speechIn0,Num_of_seg)
%demo

%1996 nian

clc
clear all; 
close all;
 fs = 16000;
 Num_of_seg0 = 10;     %  8
% record_time = 1.5*Num_of_seg0;
% fprintf('Recording speech...\n\n'); 
% 
% 
% recorder = audiorecorder(fs, 16,1);
% recordblocking(recorder,record_time);
% speechIn0 = getaudiodata(recorder);
% fprintf('Finished recording.\n\n');
% 
% audiowrite('20161102.wav',speechIn0,fs); 
fileName = 'C:\Users\Lenovo\Desktop\demo1103\2140504018.wav';
[speechIn0, fs] =audioread(fileName);

fprintf('System is trying to recognize what you have spoken...\n\n');

Recognition(speechIn0,Num_of_seg0);

