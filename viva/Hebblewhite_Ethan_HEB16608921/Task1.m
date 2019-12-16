% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

%turns off the size warnings 
warning('off', 'Images:initSize:adjustingMag');

% Step-1: Load input image
IMG = imread('Zebra.jpg');

% Step-2: Conversion of input image to grey-scale image
Igray = rgb2gray(IMG);

%Just some general variables

Original_X = 612;
Original_Y = 556;

New_X = 1836;
New_Y = 1668;

%Step-3: Nearest Neighbour Interpolation
 ZoomImageNN = zeros(New_Y,New_X,'uint8');
 
 for Binary_Y = 1:Original_Y
     for Binary_X = 1:Original_X
        
         NNX = (Binary_X * 5)-2;
         NNY = (Binary_Y * 5)-2;
         
%          for loop for first row of pixels
           for IMG = 1:3
           ZoomImageNN(NNY, NNX) = Igray(Binary_Y,Binary_X);
          
           if IMG < 3
           NNX = NNX + 1;
           end
           
           if IMG == 3
           NNY = NNY + 1; 
           end 
           
           end 
%          for loop for second row of pixels
           for IMG = 1:3
           ZoomImageNN(NNY, NNX) = Igray(Binary_Y,Binary_X);
          
           if IMG < 3
           NNX = NNX - 1;
           end
           
           if IMG == 3
           NNY = NNY + 1; 
           end
           
           end
%          for loop for third row of pixels
           for IMG = 1:3
           ZoomImageNN(NNY, NNX) = Igray(Binary_Y,Binary_X);
          
           if IMG < 3
           NNX = NNX + 1;
           end
           
           end
     end
 end

%Step-4: Bilinear Interpolation

ZoomImageBI = zeros(New_Y,New_X,'uint8');

Y_Scale = Original_Y / New_Y;
X_Scale = Original_X / New_X;

for Index_Y = 1 : New_Y 
    for Index_X = 1 : New_X
        
        %this is needed to find the pixels and used for the pixel weights
        %for the current pixel
        Binary_Y = (Y_Scale * Index_Y);
        
        %this is needed to find the pixels and used for the pixel weights
        %for the current pixel
        Binary_X = (X_Scale * Index_X);
        
        % Checks to make sure Binary_X value is in range
        %if Binary_X is lower than 1 then do soemthing
        if (Binary_X < 1)
            
            %sets Binary_X as 1
            Binary_X = 1;
            
        end
        
        %if Binary_X is higher than Origional_Y - 1 (555) then do something
        if (Binary_X > Original_Y - 1)
            
            %sets Binary_X as Orinal_Y - 1 (555)
            Binary_X = Original_Y - 1;
            
        end
        
        %rounds Binary_X up to near to infinity (0)
        Binary_X1 = floor(Binary_X);
        
        %whatever Binary_X1 is the value of Binary_X1 is increased by 1 and that is the
        %value of Binary_X2
        Binary_X2 = Binary_X1 + 1;
        
        %checks to see if the Binary_Y value is in range
        %if Binary_Y is lower than 1 then do soemthing
        if (Binary_Y < 1)
            
            Binary_Y = 1;
            
        end
        
        %if Binary_Y is higher than Origional_Y - 1 then do something
        if (Binary_Y > Original_Y - 1)
            
            Binary_Y = Original_Y - 1;
            
        end
        
        %rounds Binary_Y up to near to infinity (0)
        Binary_Y1 = floor(Binary_Y);
        
        %whatever Binary_Y1 is the value of Binary_Y1 is increased by 1 and that is the
        %value of Binary_Y2
        Binary_Y2 = Binary_Y1 + 1;
        
        % finds the 4 nearest pixels for the current piexl we are trying to create
        Nearest_Pixel_A = Igray(Binary_Y1, Binary_X1);
        Nearest_Pixel_B = Igray(Binary_Y1, Binary_X2);
        Nearest_Pixel_C = Igray(Binary_Y2, Binary_X1);
        Nearest_Pixel_D = Igray(Binary_Y2, Binary_X2);
        
        % creates a weight specific to the current pixel we are trying to
        % create 
        Pixel_Weight_A = (Binary_Y2 - Binary_Y)*(Binary_X2 - Binary_X);
        Pixel_Weight_B = (Binary_Y2 - Binary_Y)*(Binary_X - Binary_X1);
        Pixel_Weight_C = (Binary_X2 - Binary_X)*(Binary_Y - Binary_Y1);
        Pixel_Weight_D = (Binary_Y - Binary_Y1)*(Binary_X - Binary_X1);
        
        % Create Pixel data at the specific location
        ZoomImageBI(Index_Y, Index_X) = Pixel_Weight_A * Nearest_Pixel_A + Pixel_Weight_B * Nearest_Pixel_B + Pixel_Weight_C * Nearest_Pixel_C + Pixel_Weight_D * Nearest_Pixel_D;
        
    end
end

%write images
%bilinear
imwrite(ZoomImageBI,'BilinearInterpolationResult.jpg');

%NN
imwrite(ZoomImageNN,'NearestNeighbourResult.jpg');

%show images
%bilinear
figure;
imshow(ZoomImageBI)
title('Step-4: Zoom By Bilinear Interpolation');

%NN
figure;
imshow(ZoomImageNN)
title('Step-3: Zoom By Nearest Neighbour');

%grey image
figure;
imshow(Igray);
title('Step-2: Conversion of input image to greyscale');

IMG = imread('Zebra.jpg');

%Original image
figure;
imshow(IMG)
title('Original Image');