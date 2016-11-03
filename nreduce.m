function nreducedS = nreduce(x, FS)

speech = myVAD(x);                    %Trims off noise and artifacts
le = length(speech);                  %Total samples in speech signal
s_time = 0.1;                         %An initial silence period in seconds
w_time = 0.025;                       %frame size in seconds
olap_time = 0.005;                    %overlap in seconds
w = fix(w_time*FS);                   %No of Samples/window 
olap = fix(olap_time*FS);             %No of samples/overlap
s = fix((s_time-w_time)/olap_time)+1; %Number of silence segments 
tsg = fix((le-w)/olap)+1;             %Number of segments in speech signal
win = hann(w).^0.5;                   %multiply by root of hanning window
xofT = zeros(tsg,w);                  %Matrix to hold multiple segments

%Segmentation of speech section
for i = 1:tsg
    nextIndex = (i-1)*olap+1;
    xofT(i,:) = speech(nextIndex:nextIndex+w-1).*win;
end


%Matrix of silence segments
s_seg = zeros(s,w);
for k = 1:s
    nextIndex = (k-1)*olap+1;
    s_seg(k,:) = x(nextIndex:nextIndex+w-1).*hamming(w);
end

%Spectra of speech and noise is obtained below, as well as signal phase
xofK = fft(xofT,w,2);
halfn = 1+floor(w/2);
xofK = xofK(:,1:halfn);
Phase = angle(xofK);
nofK = fft(s_seg,w,2);
nofK = nofK(:,1:halfn);
nmean = mean(nofK);                 %Compute mean of noise spectra


%Averages the value of speech spectra over 3 succesive frames
xofK1 = xofK;
for l = 2:tsg-1
    xofK1(l,:) = (xofK(l-1,:)+xofK(l,:)+xofK(l+1,:))/3;
end

[nr,nc] = size(xofK1);
nmean = repmat(nmean,nr,1);
xofK1 = xofK1-nmean;               %Subtracts noise spectra from speech
xofK2 = max(xofK1,zeros(nr,nc));   %Half-wave rectify to remove -ve values

xoKwP = xofK2.*exp(j*Phase);       %Multiply speech estimate with phase
xoKwPc = conj(xoKwP);

%Fold the spectra conjugate round the main spectra to form complete FFT
if isinteger(nc/2)
    xoKwP = [xoKwP,fliplr(xoKwPc(:,2:end-1))];
else
    xoKwP = [xoKwP,fliplr(xoKwPc(:,2:end))];
end

nreducedS = zeros((nr-1)*olap+w,1);%This will hold final result

%Get real IFFT and do overlap-add, after hanning windowing
for m = 1:nr
    nextIndex = (m-1)*olap+1;
    invfft = real(ifft(xoKwP(m,:),w))'.*win;
    nreducedS(nextIndex:nextIndex+w-1) = nreducedS(nextIndex:nextIndex+w-1)+invfft;
end

    

    
    
    
    

