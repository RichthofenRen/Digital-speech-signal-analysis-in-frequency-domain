function final = demo_gui(x,Num_of_seg)
global  tim 
%demo
tic

Num_of_seg0 = Num_of_seg;     %  8

speechIn0=x;

final = Recognition(speechIn0,Num_of_seg0);

tim=toc;

