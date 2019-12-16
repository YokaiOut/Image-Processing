function [a] = Show_Red(x)
% this will read an image for you 
% Please enter a file path like:
% this = 'E:\3rd year\Image Pro\extended tasks\extended task
% wk2\Images\SampleImages\chestxray.jpg'
% or this = 'Images\SampleImages\chestxray.jpg' 
% if not the program will not work
a = imread(x);

% this uses a built in function to conver the image into a greyscale image 
for i = 1:534
    for j = 1:800
%        a(i,j, 1) = 0; %Red
        a(i,j, 2) = 0; %Green
        a(i,j, 3) = 0; %Blue
    end
end

%this then shows the image after it has been convertedclea
imshow(a);
