function FMatrix=mfccf(num,s,Fs)


n=512;              
Tf=0.025;           
N=Fs*Tf;            
fn=24;              %滤波器阶数
l=length(s);        
Ts=0.01;            
FrameStep=Fs*Ts;    %每帧步长
a=1;
b=[1, -0.97];       %滤波器参数

noFrames=floor(l/FrameStep);    
FMatrix=zeros(noFrames-2, num); 
lifter=1:num;                   
lifter=1+floor((num)/2)*(sin(lifter*pi/num));

if mean(abs(s)) > 0.01
    s=s/max(s);                     
end


for i=1:noFrames-2
    frame=s((i-1)*FrameStep+1:(i-1)*FrameStep+N);  
    Ce1=sum(frame.^2);          %计算每帧能量
    Ce2=max(Ce1,2e-22);         %认为有效的能量范围
    Ce=log(Ce2);
    framef=filter(b,a,frame);   %滤波器使用！
    F=framef.*hamming(N);       
    FFTo=fft(F,N);              %fft计算
    melf=melbankm(fn,n,Fs);     
    halfn=1+floor(n/2);    
    spectr1=log10(melf*abs(FFTo(1:halfn)).^2);
    spectr=max(spectr1(:),1e-22);
    c=dct(spectr);              %频域转换
    c(1)=Ce;                    
    coeffs=c(1:num);            
    ncoeffs=coeffs.*lifter';    
    FMatrix(i, :)=ncoeffs';      
end

 
d=(deltacoeff(FMatrix)).*0.6;   %计算一阶差分  delta-mfcc
d1=(deltacoeff(d)).*0.4;        %计算二阶差分  delta-delta-mfcc
FMatrix=[FMatrix,d,d1];         %最终MFCC矩阵
