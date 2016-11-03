% pwd='C:\Users\Lenovo\Desktop\DSP_experiments\test_10_groups';
% addpath(pwd);   
%pwd='C:\Users\Lenovo\Documents\WeChat Files\rzq273\Attachment';
pwd='F:\MFCC\my-wavs';
addpath(pwd);  
G=0;




% for ii = 1:1    
%     for j = 1:10 
%         fileName = [num2str(ii) '.' num2str(j-1) '.wav'];
%         x=audioread(fileName);
%         [x1, x2]=voice_segment(x);
%         x0=x(x1:x2);
%         Name = ['segment_miao_' num2str(ii) '.' num2str(j-1) '.wav'];
%         wavwrite(x0,16000,Name);
%     end   
% end


for ii = 1:10   
    
    for j = 0:9 
        fileName = ['segment_ren_' num2str(ii) '.' num2str(j) '.wav'];
        %pureNmae = ['pure_' num2str(ii) '.' num2str(j) '.wav'];
        [x, fs] =audioread(fileName);
             
        % remove the noise
%         speechIn1 = x;
%         speechIn2 = speechIn1.*G;
%         speechIn3 = speechIn2 - mean(speechIn2);         %DC offset elimination
%         speechIn = nreduce(speechIn3,fs);                %Applies spectral subtraction
%         wavwrite(speechIn,44100,pureNmae);
        rMatrix = mfccf(13,x,fs);
        
        
        %rMatrix = rMatrix1;
             
        if(j==0)
            zero= rMatrix;
        end
        if(j==1)
            one= rMatrix;
        end
        if(j==2)
            two= rMatrix;
        end
        if(j==3)
            three= rMatrix;
        end
        if(j==4)
            four= rMatrix;
        end
        if(j==5)
            five= rMatrix;
        end
        if(j==6)
            six= rMatrix;
        end
        if(j==7)
            seven= rMatrix;
        end
        if(j==8)
            eight= rMatrix;
        end
        if(j==9)
            nine= rMatrix;
        end
    end 
    matName = ['n_group_ren_' num2str(ii) '.mat'];
    save(matName,'zero','one','two','three','four','five','six','seven','eight','nine');
end


% rMatrix1 = mfccf(ncoeff,speechIn,fs);            %Compute test feature vector
% rMatrix = CMN(rMatrix1);                         %Removes convolutional noise



