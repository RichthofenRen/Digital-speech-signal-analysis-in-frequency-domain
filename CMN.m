function NormMatrix = CMN(Matrix)



[r,c]=size(Matrix);
NormMatrix=zeros(r,c);
for i=1:c
    MatMean=mean(Matrix(:,i));  %Derives mean for each column i in utterance
    NormMatrix(:,i)=Matrix(:,i)-MatMean; %Subtracts mean from each element in
                                         %column i
end
