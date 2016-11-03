function diff = deltacoeff(x)


[nr,nc] = size(x);

K = 3;          %Number of frame span(backward and forward span equal)
b = K:-1:-K;    %Vector of filter coefficients

%pads cepstral  coefficients matrix by repeating first and last rows K times
px = [repmat(x(1,:),K,1);x;repmat(x(end,:),K,1)];

diff = filter(b, 1, px, [], 1);  % filter data vector along each column
diff = diff/sum(b.^2);           %Divide by sum of square of all span values
% Trim off upper and lower K rows to make input and output matrix equal
diff = diff(K + [1:nr],:);
