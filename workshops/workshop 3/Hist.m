function a = Hist(X)

a = imread(X);

%imshow(a);

imagesc(a);
colorbar;
colormap gray;

mi = min(min(a));
ma = max(max(a));

Text = ["the max value is ", ma];

disp(Text);

Text = ["the min value is ", mi];

disp(Text);

L = ma - mi + 1;

for i = 1:L
 pixel_value(i) = i - 1;
 frequency = find( a == pixel_value(i) );
 Nk(i) = length( frequency );
end

bar(pixel_value,Nk,0.1);

