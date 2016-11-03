%语音端点检测与分段，调用时采用循环调用，检测到一段语音信号后，计算其短时过零率和短时能量，随后将其从整段信号中删除，继续进行下一段语音信号的端点检测
function [xx1,xx2] = voice_segment(x)
  %x=audioread('C:\Users\Lenovo\Desktop\DSP_experiments\chinese_1357924680.wav');
  %x=audioread('C:\Users\Lenovo\Desktop\DSP_experiments\test_10_groups\0.1.wav');
%  
%幅度归一化到[-1,1]
x = double(x);
x = x / max(abs(x));
 
%常数设置
FrameLen = 400;%帧长为400点
FrameInc = 200;%帧移为200点
 
amp1 = 12;%初始短时能量高门限12
amp2 = 6;%初始短时能量低门限6
zcr1 = 10;%初始短时过零率高门限10
zcr2 = 2;%初始短时过零率低门限2
 
maxsilence = 8;  % 8*10ms  = 80ms
%语音段中允许的最大静音长度，如果语音段中的静音帧数未超过此值，则认为语音还没结束；如果超过了
%该值，则对语音段长度count进行判断，若count<minlen，则认为前面的语音段为噪音，舍弃，跳到静音
%状态0；若count>minlen，则认为语音段结束；

minlen  = 15;    % 15*10ms = 150ms
%语音段的最短长度，若语音段长度小于此值，则认为其为一段噪音

status  = 0;     %初始状态为静音状态
count   = 0;     %初始语音段长度为0
silence = 0;     %初始静音段长度为0
 
%计算过零率
tmp1  = enframe(x(1:end-1), FrameLen, FrameInc);
tmp2  = enframe(x(2:end)  , FrameLen, FrameInc);
signs = (tmp1.*tmp2)<0;
diffs = (tmp1 -tmp2)>0.02;
zcr   = sum(signs.*diffs, 2);
 
%计算短时能量
%amp = sum(abs(enframe(filter([1 -0.9375], 1, x), FrameLen, FrameInc)), 2);
amp = sum(abs(enframe(x, FrameLen, FrameInc)), 2);
 
%调整能量门限
amp1 = min(amp1, max(amp)/4);
amp2 = min(amp2, max(amp)/8);
 
%开始端点检测
x1 = 0;
x2 = 0;
for n=1:length(zcr)
   goto = 0;
   switch status
   case {0,1}                   
      if amp(n) > amp1          
         x1 = max(n-count-1,1);
         status  = 2;
         silence = 0;
         count   = count + 1;
      elseif amp(n) > amp2 | ... 
             zcr(n) > zcr2
         status = 1;
         count  = count + 1;
      else                      
         status  = 0;
         count   = 0;
      end
   case 2,                       
      if amp(n) > amp2 | ...     
         zcr(n) > zcr2
         count = count + 1;
      else                       
         silence = silence+1;
         if silence < maxsilence 
            count  = count + 1;
         elseif count < minlen   
            status  = 0;
            silence = 0;
            count   = 0;
         else                    
            status  = 3;
         end
      end
   case 3,
      break;
   end
end  

count = count-silence/2;
x2 = x1 + count -1;


% figure;
% plot(x);
% axis([1 length(x) -1 1]) ;   %函数中的四个参数分别表示xmin,xmax,ymin,ymax，即轴的范围
% ylabel('Speech');
% line([x1*FrameInc x1*FrameInc], [-1 1], 'Color', 'red');
% %这里作用为用直线画出语音段的起点和终点，看起来更直观。第一个[]中的两个参数为线起止点的横坐标，
% %第二个[]中的两个参数为线起止点的纵坐标。最后两个参数设置了线的颜色。
% line([x2*FrameInc x2*FrameInc], [-1 1], 'Color', 'red');

 xx1=x1*FrameInc;
 xx2=x2*FrameInc;
