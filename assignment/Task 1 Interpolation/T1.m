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
 
 for Y = 1:Original_Y
     for X = 1:Original_X
        
         NNX = (X * 3)-2;
         NNY = (Y * 3)-2;
         
%          for loop for first row of pixels
           for IMG = 1:3
           ZoomImageNN(NNY, NNX) = Igray(Y,X);
          
           if IMG < 3
           NNX = NNX + 1;
           end
           
           if IMG == 3
           NNY = NNY + 1; 
           end 
           
           end 
%          for loop for second row of pixels
           for IMG = 1:3
           ZoomImageNN(NNY, NNX) = Igray(Y,X);
          
           if IMG < 3
           NNX = NNX - 1;
           end
           
           if IMG == 3
           NNY = NNY + 1; 
           end
           
           end
%          for loop for third row of pixels
           for IMG = 1:3
           ZoomImageNN(NNY, NNX) = Igray(Y,X);
          
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
        Y = (Y_Scale * Index_Y);
        
        %this is needed to find the pixels and used for the pixel weights
        %for the current pixel
        X = (X_Scale * Index_X);
        
        % Checks to make sure X value is in range
        %if X is lower than 1 then do soemthing
        if (X < 1)
            
            %sets X as 1
            X = 1;
            
        end
        
        %if X is higher than Origional_Y - 1 (555) then do something
        if (X > Original_Y - 1)
            
            %sets X as Orinal_Y - 1 (555)
            X = Original_Y - 1;
            
        end
        
        %rounds X up to near to infinity (0)
        X1 = floor(X);
        
        %whatever X1 is the value of X1 is increased by 1 and that is the
        %value of X2
        X2 = X1 + 1;
        
        %checks to see if the Y value is in range
        %if Y is lower than 1 then do soemthing
        if (Y < 1)
            
            Y = 1;
            
        end
        
        %if Y is higher than Origional_Y - 1 then do something
        if (Y > Original_Y - 1)
            
            Y = Original_Y - 1;
            
        end
        
        %rounds Y up to near to infinity (0)
        Y1 = floor(Y);
        
        %whatever Y1 is the value of Y1 is increased by 1 and that is the
        %value of Y2
        Y2 = Y1 + 1;
        
        % finds the 4 nearest pixels for the current piexl we are trying to create
        Nearest_Pixel_A = Igray(Y1, X1);
        Nearest_Pixel_B = Igray(Y1, X2);
        Nearest_Pixel_C = Igray(Y2, X1);
        Nearest_Pixel_D = Igray(Y2, X2);
        
        % creates a weight specific to the current pixel we are trying to
        % create 
        Pixel_Weight_A = (Y2 - Y)*(X2 - X);
        Pixel_Weight_B = (Y2 - Y)*(X - X1);
        Pixel_Weight_C = (X2 - X)*(Y - Y1);
        Pixel_Weight_D = (Y - Y1)*(X - X1);
        
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