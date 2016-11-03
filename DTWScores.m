function AllScores = DTWScores(rMatrix,N)


%初始化score向量
Scores1 = zeros(1,N);                
Scores2 = zeros(1,N);
Scores3 = zeros(1,N);
Scores4 = zeros(1,N);
Scores5 = zeros(1,N);
Scores6 = zeros(1,N);                
Scores7 = zeros(1,N);
Scores8 = zeros(1,N);
Scores9 = zeros(1,N);
Scores10 = zeros(1,N);

%好不容易录好音   计算完的训练MFCC参数
s1 = load('group_ren_1.mat');
fMatrixall1 = struct2cell(s1);
s2 = load('group_ren_2.mat');
fMatrixall2 = struct2cell(s2);
s3 = load('group_ren_3.mat');
fMatrixall3 = struct2cell(s3);
s4 = load('group_ren_4.mat');
fMatrixall4 = struct2cell(s4);
s5 = load('group_ren_5.mat');
fMatrixall5 = struct2cell(s5);
s6 = load('group_ren_6.mat');
fMatrixall6 = struct2cell(s6);
s7 = load('group_ren_7.mat');
fMatrixall7 = struct2cell(s7);
s8 = load('group_ren_8.mat');
fMatrixall8 = struct2cell(s8);
s9 = load('group_li_9.mat');
fMatrixall9 = struct2cell(s9);
s10 = load('group_li_10.mat');
fMatrixall10 = struct2cell(s10);

%   10组   每组计算DTW
for i = 1:N
    fMatrix1 = fMatrixall1{i,1};
    %fMatrix1 = CMN(fMatrix1);
    Scores1(i) = myDTW(fMatrix1,rMatrix);
end

for j = 1:N
    fMatrix2 = fMatrixall2{j,1};
    %fMatrix2 = CMN(fMatrix2);
    Scores2(j) = myDTW(fMatrix2,rMatrix);
end

for m = 1:N
    fMatrix3 = fMatrixall3{m,1};
    %fMatrix3 = CMN(fMatrix3);
    Scores3(m) = myDTW(fMatrix3,rMatrix);
end

for p = 1:N
    fMatrix4 = fMatrixall4{p,1};
    %fMatrix4 = CMN(fMatrix4);
    Scores4(p) = myDTW(fMatrix4,rMatrix);
end

for q = 1:N
    fMatrix5 = fMatrixall5{q,1};
    %fMatrix5 = CMN(fMatrix5);
    Scores5(q) = myDTW(fMatrix5,rMatrix);
end

for ii = 1:N
    fMatrix6 = fMatrixall6{ii,1};
    %fMatrix6 = CMN(fMatrix6);
    Scores6(ii) = myDTW(fMatrix6,rMatrix);
end

for jj = 1:N
    fMatrix7 = fMatrixall7{jj,1};
    %fMatrix7 = CMN(fMatrix7);
    Scores7(jj) = myDTW(fMatrix7,rMatrix);
end

for mm = 1:N
    fMatrix8 = fMatrixall8{mm,1};
    %fMatrix8 = CMN(fMatrix8);
    Scores8(mm) = myDTW(fMatrix8,rMatrix);
end

for pp = 1:N
    fMatrix9 = fMatrixall9{pp,1};
    %fMatrix9 = CMN(fMatrix9);
    Scores9(pp) = myDTW(fMatrix9,rMatrix);
end

for qq = 1:N
    fMatrix10 = fMatrixall10{qq,1};
    %fMatrix10 = CMN(fMatrix10);
    Scores10(qq) = myDTW(fMatrix10,rMatrix);
end


%   10*10向量拼接    总的得分向量   100维
AllScores = [Scores1,Scores2,Scores3,Scores4,Scores5,Scores6,Scores7,Scores8,Scores9,Scores10];


%AllScores = [Scores1,Scores2];
































% function AllScores = DTWScores(rMatrix,N)
% 
% 
% %Vectors to hold DTW scores
% Scores1 = zeros(1,N);                
% Scores2 = zeros(1,N);
% Scores3 = zeros(1,N);
% Scores4 = zeros(1,N);
% Scores5 = zeros(1,N);
% 
% %Load the refernce templates from file
% s1 = load('Vectors1.mat');
% fMatrixall1 = struct2cell(s1);
% s2 = load('Vectors2.mat');
% fMatrixall2 = struct2cell(s2);
% s3 = load('Vectors3.mat');
% fMatrixall3 = struct2cell(s3);
% s4 = load('Vectors4.mat');
% fMatrixall4 = struct2cell(s4);
% s5 = load('Vectors5.mat');
% fMatrixall5 = struct2cell(s5);
% 
% %Compute DTW scores for test template against all reference templates
% for i = 1:N
%     fMatrix1 = fMatrixall1{i,1};
%     fMatrix1 = CMN(fMatrix1);
%     Scores1(i) = myDTW(fMatrix1,rMatrix);
% end
% 
% for j = 1:N
%     fMatrix2 = fMatrixall2{j,1};
%     fMatrix2 = CMN(fMatrix2);
%     Scores2(j) = myDTW(fMatrix2,rMatrix);
% end
% 
% for m = 1:N
%     fMatrix3 = fMatrixall3{m,1};
%     fMatrix3 = CMN(fMatrix3);
%     Scores3(m) = myDTW(fMatrix3,rMatrix);
% end
% 
% for p = 1:N
%     fMatrix4 = fMatrixall4{p,1};
%     fMatrix4 = CMN(fMatrix4);
%     Scores4(p) = myDTW(fMatrix4,rMatrix);
% end
% 
% for q = 1:N
%     fMatrix5 = fMatrixall5{q,1};
%     fMatrix5 = CMN(fMatrix5);
%     Scores5(q) = myDTW(fMatrix5,rMatrix);
% end
% 
% AllScores = [Scores1,Scores2,Scores3,Scores4,Scores5];

