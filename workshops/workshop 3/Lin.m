function a = Lin(X)

a = imread(X);

b = rgb2gray(a);
J = 255*im2double(b);

mi = min(min(J));
ma = max(max(J));

J2 = imadjust(a,[mi/255; ma/255],[0; 1]);

 imhist(a,100);

%  imshow(J2);