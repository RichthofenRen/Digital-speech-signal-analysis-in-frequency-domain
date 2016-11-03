function total =Recognition(fileName,Num_of_seg)
global kk

kk=0;
hwait=waitbar(0,'��ȴ�...');
steps=Num_of_seg*100;
step=steps/100;

ncoeff = 13;          
N = 10;     %��������          
k = 3;      %ѡȡ����ڸ���        
fs=16000;   %������          
NSgroup = 10;   %ѵ������  10�顣

speechIn0 = fileName;
total = [];
for iii=1:Num_of_seg
    
    
    [x1, x2]=voice_segment(speechIn0);   %��Ч����Ƭ�ηָ�
    speechIn1=speechIn0(x1:x2);
    
    
    rMatrix1 = mfccf(ncoeff,speechIn1,fs);      %MFCC�����ɡ�
    
    rMatrix = rMatrix1;
    
    %audiowrite('pure.wav',speechIn,fs);
    
    Dis = DTWScores(rMatrix,N);         %DTW�ļ���
    [SortedScores,EIndex] = sort(Dis);  %  100��  ��������
    K_Vector = EIndex(1:k);
    Neighbors = zeros(1,k);
    
    %�����������
    for t = 1:k
        u = K_Vector(t);
        for r = 1:NSgroup-1
            if u <= (N)
                break
            else u = u - (N);
            end
                  kk=kk+10;
                if steps-kk<=15
                    waitbar(kk/steps,hwait,'�������');
%                     pause(0.001);
                else
                    PerStr=fix(kk/step);
                    str=['���ڷ���... ',num2str(PerStr),'%'];
                    waitbar(kk/steps,hwait,str);
%                     pause(0.001);
                end
            
        end
        Neighbors(t) = u;
    end
    
    
    %KNN�㷨Ӧ��
    
    Nbr = Neighbors;
    output = Nbr-1;    % ��Ϊ��һ������ 0    ���Լ�ȥ1
    %sortk = sort(Nbr);
    [Modal,Freq] = mode(Nbr);   %ȡ�����Ƶ�����Լ���Ƶ��
    
    
    %Word = strvcat('One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Zero');
    Word = strvcat('0','1','2','3','4','5','6','7','8','9');
    
    if mean(abs(speechIn1)) < 0.01
        fprintf('You may have said nothing\n');
    elseif ((k/Freq) > 2)
        fprintf('The word you have said could not be properly recognised.\n');
    else
        fprintf('You have just said %s. The nearest %s neighbors of it are %s .\n',Word(Modal,:),num2str(k),num2str(output)); %Prints recognized word
    end
    
    
    speechIn0 = speechIn0(x2:size(speechIn0,1),:);
    
    total = [total Modal-1];   %���鱣������ֵ
    
end
close(hwait);
fprintf('All you said were "%s" .Is that the right answer?\n',num2str(total));


