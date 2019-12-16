% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;

% Step-1: Load input image
IMG = imread('Starfish.jpg');

% Step-2: Conversion of input image to grey-scale image
IMG_Gray = rgb2gray(IMG);

%variables
Original_X = size(IMG_Gray, 2);
Original_Y = size(IMG_Gray, 1);

%Step-3: get rid of salt and peper noise in the image with median average
%technique 

MedianImage = zeros(Original_Y,Original_X,'uint8');

MedianFilterNumberHolder = zeros(1, 25);

ZeroPadded_X = Original_X + 4;
ZeroPadded_Y = Original_Y + 4;

Zero_Padding_Image = zeros(ZeroPadded_Y,ZeroPadded_X,'uint8');

%loops through all pixels in original image
for Y_Loop = 1: Original_Y
    for X_Loop = 1: Original_X
        
        %fills zero padded image with original image
        Zero_Padding_Image(Y_Loop + 2, X_Loop + 2) = IMG_Gray(Y_Loop,X_Loop);
        
    end
end

%loops through zeropadded image
for Y_Loop = 1: ZeroPadded_Y
    for X_Loop = 1: ZeroPadded_X  
        %if Y is withing the range of 3 - 474 then check for salt and pepper noise
        if (Y_Loop >= 3 && Y_Loop <= Original_Y + 2)
            if (X_Loop >= 3 && X_Loop <= Original_X + 2)
                
                MeanNum = 0;
                
                Filter_Y = -2;
                Filter_X = -2;
                
                IndexMedian = 1;
                
                for Index_Y = 1 : 5
                    for Index_X = 1 : 5
                    
                    MedianFilterNumberHolder(IndexMedian) = Zero_Padding_Image(Y_Loop - Filter_Y, X_Loop - Filter_X);
                        
                        Filter_X = Filter_X + 1;
                        IndexMedian  = IndexMedian + 1;
                    end
                    
                    Filter_Y = Filter_Y + 1;
                    Filter_X = -2;
                end
                
                MedianFilterNumberHolder = sort(MedianFilterNumberHolder);
                
                MedianImage(Y_Loop - 2, X_Loop - 2) = MedianFilterNumberHolder(1, 13);
                
                
            end 
        end 
    end 
end


%Step-4 turn image into binary image

%all these images are needed to create an image later on that has the big
%and smaller objects removed from the original binary image
IMG_Binary = imbinarize(MedianImage); 
IMG_Binary_Remove_Big_Objects = imbinarize(MedianImage);
IMG_Binary_Remove_Little_Objects = imbinarize(MedianImage);

%Step-5 Remove big objects

%shapes we need to remove the big objects
DiskA = strel('disk', 10);
DiskB = strel('disk', 30);

ImClose_IMG = imclose(IMG_Binary, DiskA);

ImClose_And_ImErode_IMG = imerode(ImClose_IMG, DiskB);

%use image to remove anything that is in the image from the binary

for Y_Loop = 1: Original_Y
    for X_Loop = 1: Original_X
        
        if(IMG_Binary(Y_Loop, X_Loop) == ImClose_And_ImErode_IMG(Y_Loop, X_Loop))
            
           IMG_Binary_Remove_Big_Objects(Y_Loop, X_Loop) = 1;
            
        end     
    end 
end 

%Step-6 Remove smaller objects

%shapes we need to remove the small objects

DiskC = strel('disk', 6);
DiskD = strel('disk', 20);

ImClose_IMG = imclose(IMG_Binary_Remove_Big_Objects, DiskC);

ImClose_And_ImErode_IMG2 = imerode(ImClose_IMG, DiskD);

IMG_Binary_Remove_Little_Objects = IMG_Binary_Remove_Big_Objects;

%creates the image without the small objects
for Y_Loop = 1: Original_Y
    for X_Loop = 1: Original_X
        
        if(IMG_Binary(Y_Loop, X_Loop) == ImClose_And_ImErode_IMG2(Y_Loop, X_Loop))
            
           IMG_Binary_Remove_Little_Objects(Y_Loop, X_Loop) = 1;
            
        end     
    end 
end 

IMG_Binary_Small_And_Large_Objects_Removed = IMG_Binary;

%creating the image without the large and small objects
for Y_Loop = 1: Original_Y
    for X_Loop = 1: Original_X
        
        if(IMG_Binary(Y_Loop, X_Loop) == IMG_Binary_Remove_Little_Objects(Y_Loop, X_Loop))
            
           IMG_Binary_Small_And_Large_Objects_Removed(Y_Loop, X_Loop) = 1;
        
        elseif(IMG_Binary(Y_Loop, X_Loop) == ImClose_And_ImErode_IMG(Y_Loop, X_Loop))
           
           IMG_Binary_Small_And_Large_Objects_Removed(Y_Loop, X_Loop) = 1;
            
        end
            
    end 
end 


%shapes we need to remove the small objects
SquareA = strel('square', 10);

DiskC = strel('disk', 8);

% creates a filter to remove the smaller objects that are left in the image
ImClose_IMG = imclose(IMG_Binary_Small_And_Large_Objects_Removed, DiskC);

DiskC = strel('disk', 20);

IM_Erode = imerode(ImClose_IMG, DiskC);


Final_IMG = IMG_Binary_Small_And_Large_Objects_Removed;

%removes the smaller objects that are left in the image
for Y_Loop = 1: Original_Y
    for X_Loop = 1: Original_X
        
        if(IMG_Binary(Y_Loop, X_Loop) ~= IM_Erode(Y_Loop, X_Loop))
            
           Final_IMG(Y_Loop, X_Loop) = 1;
            
        end     
    end 
end 

%make the starfish look better
JustStarFish = Final_IMG;

DiskC = strel('disk', 2);

Final_IMG = imerode(Final_IMG, DiskC);

SquareA = strel('square', 3);

Final_IMG = imopen(Final_IMG, SquareA);

%converts the image from 1 meaing no starfish to it meaning a starfish
%and 0 meaning a strfish to nothing
for Y_Loop = 1: Original_Y
    for X_Loop = 1: Original_X
        
        if(Final_IMG(Y_Loop, X_Loop) == 1)
            
           Final_IMG(Y_Loop, X_Loop) = 0;
           
        elseif (Final_IMG(Y_Loop, X_Loop) == 0)
            
            Final_IMG(Y_Loop, X_Loop) = 1;
            
        end     
    end 
end 

%write images
%final image with just the starfish
imwrite(Final_IMG,'JustStarFishLeft.jpg');

%Show Images
%final image
figure;
imshow(Final_IMG)
title('Final Image,  where 0 is no starfish and 1 is a starfish');

%Before the binary numbers have switched
figure;
imshow(JustStarFish)
title('I played with the tools to find a solution to keep just the starfish');

%results
figure;
imshow(IMG_Binary_Small_And_Large_Objects_Removed)
title('Result of the filter');

%Filter image
figure;
imshow(IMG_Binary_Remove_Little_Objects)
title('Filter to remove the small objects from the image');

%big objects removed 
figure;
imshow(IMG_Binary_Remove_Big_Objects)
title('Removed big objects from the binary image');

% IMG Binary
figure;
imshow(IMG_Binary)
title('Grey image has been turned into a binary image');

%Median Image
figure;
imshow(MedianImage)
title('MedianImage removing salt and pepper');

%Gray Image
figure;
imshow(IMG_Gray)
title('Gray image');

%Original
figure;
imshow(IMG)
title('Original Image');