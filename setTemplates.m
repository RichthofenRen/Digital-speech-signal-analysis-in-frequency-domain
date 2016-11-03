

ncoeff=13;                      %Required number of mfcc coefficients
fMatrix1 = cell(1,20);
fMatrix2 = cell(1,20);
fMatrix3 = cell(1,20);
fMatrix4 = cell(1,20);
fMatrix5 = cell(1,20);

for j = 1:20
    q = ['C:\SpeechData\Tope\5_' num2str(j) '.wav'];
    [speechIn1,FS1] = wavread(q);
    speechIn1 = myVAD(speechIn1); %Speech endpoint trimming
    fMatrix1(1,j) = {mfccf(ncoeff,speechIn1,FS1)}; %MFCC coefficients are 
                                                %computed here
end

for k = 1:20
    q = ['C:\SpeechData\Ayo\5_' num2str(k) '.wav'];
    [speechIn2,FS2] = wavread(q);
    speechIn2 = myVAD(speechIn2); 
    fMatrix2(1,k) = {mfccf(ncoeff,speechIn2,FS2)}; 
end

for l = 1:20
    q = ['C:\SpeechData\Sameh\5_' num2str(l) '.wav'];
    [speechIn3,FS3] = wavread(q);
    speechIn3 = myVAD(speechIn3); 
    fMatrix3(1,l) = {mfccf(ncoeff,speechIn3,FS3)};
end

for m = 1:20
    q = ['C:\SpeechData\Jim\5_' num2str(m) '.wav'];
    [speechIn4,FS4] = wavread(q);
    speechIn4 = myVAD(speechIn4); 
    fMatrix4(1,m) = {mfccf(ncoeff,speechIn4,FS4)}; 
end

for n = 1:20
    q = ['C:\SpeechData\Amir\5_' num2str(n) '.wav'];
    [speechIn5,FS5] = wavread(q);
    speechIn5 = myVAD(speechIn5); 
    fMatrix5(1,n) = {mfccf(ncoeff,speechIn5,FS5)}; 
end

%Converts the cells containing all matrices to structures and save
%structures in matlab .mat files in the working directory.
fields = {'One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten','Yes','No','Hello','Open','Close','Start','Stop','Dial','On','Off'};
s1 = cell2struct(fMatrix1, fields, 2);
save Vectors1.mat -struct s1;
s2 = cell2struct(fMatrix2, fields, 2);
save Vectors2.mat -struct s2;
s3 = cell2struct(fMatrix3, fields, 2);
save Vectors3.mat -struct s3;
s4 = cell2struct(fMatrix4, fields, 2);
save Vectors4.mat -struct s4;
s5 = cell2struct(fMatrix5, fields, 2);
save Vectors5.mat -struct s5;
    
