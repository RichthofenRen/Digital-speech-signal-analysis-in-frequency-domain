function FMatrix=mfccf(num,s,Fs)


n=512;              
Tf=0.025;           
N=Fs*Tf;            
fn=24;              %�˲�������
l=length(s);        
Ts=0.01;            
FrameStep=Fs*Ts;    %ÿ֡����
a=1;
b=[1, -0.97];       %�˲�������

noFrames=floor(l/FrameStep);    
FMatrix=zeros(noFrames-2, num); 
lifter=1:num;                   
lifter=1+floor((num)/2)*(sin(lifter*pi/num));

if mean(abs(s)) > 0.01
    s=s/max(s);                     
end


for i=1:noFrames-2
    frame=s((i-1)*FrameStep+1:(i-1)*FrameStep+N);  
    Ce1=sum(frame.^2);          %����ÿ֡����
    Ce2=max(Ce1,2e-22);         %��Ϊ��Ч��������Χ
    Ce=log(Ce2);
    framef=filter(b,a,frame);   %�˲���ʹ�ã�
    F=framef.*hamming(N);       
    FFTo=fft(F,N);              %fft����
    melf=melbankm(fn,n,Fs);     
    halfn=1+floor(n/2);    
    spectr1=log10(melf*abs(FFTo(1:halfn)).^2);
    spectr=max(spectr1(:),1e-22);
    c=dct(spectr);              %Ƶ��ת��
    c(1)=Ce;                    
    coeffs=c(1:num);            
    ncoeffs=coeffs.*lifter';    
    FMatrix(i, :)=ncoeffs';      
end

 
d=(deltacoeff(FMatrix)).*0.6;   %����һ�ײ��  delta-mfcc
d1=(deltacoeff(d)).*0.4;        %������ײ��  delta-delta-mfcc
FMatrix=[FMatrix,d,d1];         %����MFCC����
