function A = HistEqual(X)

A = imread(X);

I = 255*im2double(A);

mi = min(min(I));
ma = max(max(I));

L = ma - mi + 1;

B = cumsum(I);

% for i = 1:L
%  pixel_value(i) = i - 1;
%  frequency = find( I == pixel_value(i) );
%  Nk(i) = length( frequency );
% end

% J = uint8(zeros(size(I)));

% for row = 1 :size(I,1)
%  for col = 1:size(I,2)
%  J(row,col) = Sk(I(row,col)+1);
%  end
% end

% bar(pixel_value,Nk,0.1);