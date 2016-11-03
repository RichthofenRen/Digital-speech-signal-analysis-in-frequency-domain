%�����˵�����ֶΣ�����ʱ����ѭ�����ã���⵽һ�������źź󣬼������ʱ�����ʺͶ�ʱ�����������������ź���ɾ��������������һ�������źŵĶ˵���
function [xx1,xx2] = voice_segment(x)
  %x=audioread('C:\Users\Lenovo\Desktop\DSP_experiments\chinese_1357924680.wav');
  %x=audioread('C:\Users\Lenovo\Desktop\DSP_experiments\test_10_groups\0.1.wav');
%  
%���ȹ�һ����[-1,1]
x = double(x);
x = x / max(abs(x));
 
%��������
FrameLen = 400;%֡��Ϊ400��
FrameInc = 200;%֡��Ϊ200��
 
amp1 = 12;%��ʼ��ʱ����������12
amp2 = 6;%��ʼ��ʱ����������6
zcr1 = 10;%��ʼ��ʱ�����ʸ�����10
zcr2 = 2;%��ʼ��ʱ�����ʵ�����2
 
maxsilence = 8;  % 8*10ms  = 80ms
%���������������������ȣ�����������еľ���֡��δ������ֵ������Ϊ������û���������������
%��ֵ����������γ���count�����жϣ���count<minlen������Ϊǰ���������Ϊ��������������������
%״̬0����count>minlen������Ϊ�����ν�����

minlen  = 15;    % 15*10ms = 150ms
%�����ε���̳��ȣ��������γ���С�ڴ�ֵ������Ϊ��Ϊһ������

status  = 0;     %��ʼ״̬Ϊ����״̬
count   = 0;     %��ʼ�����γ���Ϊ0
silence = 0;     %��ʼ�����γ���Ϊ0
 
%���������
tmp1  = enframe(x(1:end-1), FrameLen, FrameInc);
tmp2  = enframe(x(2:end)  , FrameLen, FrameInc);
signs = (tmp1.*tmp2)<0;
diffs = (tmp1 -tmp2)>0.02;
zcr   = sum(signs.*diffs, 2);
 
%�����ʱ����
%amp = sum(abs(enframe(filter([1 -0.9375], 1, x), FrameLen, FrameInc)), 2);
amp = sum(abs(enframe(x, FrameLen, FrameInc)), 2);
 
%������������
amp1 = min(amp1, max(amp)/4);
amp2 = min(amp2, max(amp)/8);
 
%��ʼ�˵���
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
% axis([1 length(x) -1 1]) ;   %�����е��ĸ������ֱ��ʾxmin,xmax,ymin,ymax������ķ�Χ
% ylabel('Speech');
% line([x1*FrameInc x1*FrameInc], [-1 1], 'Color', 'red');
% %��������Ϊ��ֱ�߻��������ε������յ㣬��������ֱ�ۡ���һ��[]�е���������Ϊ����ֹ��ĺ����꣬
% %�ڶ���[]�е���������Ϊ����ֹ��������ꡣ������������������ߵ���ɫ��
% line([x2*FrameInc x2*FrameInc], [-1 1], 'Color', 'red');

 xx1=x1*FrameInc;
 xx2=x2*FrameInc;
