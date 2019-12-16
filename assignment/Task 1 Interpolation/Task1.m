% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

% Step-1: Load input image
IMG = imread('Zebra.jpg');
 figure;
 imshow(IMG);
 title('Step-1: Load input image');

% Step-2: Conversion of input image to grey-scale image
Igray = rgb2gray(IMG);

%Just some general variables

Original_X = 612;
Original_Y = 556;

New_X = 1836;
New_Y = 1668;

%Step-3: Nearest Neighbour Interpolation
 ZoomImageNN = zeros(1668,1836,'uint8');
 
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
 ZoomImageBI = zeros(1668,1836,'uint8');
 
 %Scaling
 Scale_Y = Original_Y / New_Y;
 Scale_X = Original_X / New_X;
 
 %This just creates a 2D gid of X&Y co-ordinates. this helps generate pixel
 %locations easier. (meshgrid creates grids)
 [X_Factor, Y_Factor] = meshgrid(1 : New_X, 1 : New_Y);
 
%Factors
 Y_Factor = Y_Factor * Scale_Y;
 X_Factor = X_Factor * Scale_X;
 
 %Rounds the numbers near to infinity(0)
 Y = floor(Y_Factor);
 X = floor(X_Factor);
 
 %Makes sure all numbers are within the boudary of 1 or less
 Y(Y < 1) = 1;
 X(X < 1) = 1;
 Y(Y > Original_Y - 1) = Original_Y - 1;
 X(X > Original_X - 1) = Original_X - 1;
 
 %The differenece
 Delta_Y = Y_Factor - Y;
 Delta_X = X_Factor - X;
 
 %All four courneers of the bilinear interpolation
 %Sub2ind just turns the X&Y numbers into a single number for us to use
 Indices_1 = sub2ind([Original_Y, Original_X], Y, X);
 Indices_2 = sub2ind([Original_Y, Original_X], Y+1,X);
 Indices_3 = sub2ind([Original_Y, Original_X], Y, X+1);
 Indices_4 = sub2ind([Original_Y, Original_X], Y+1, X+1); 
 
 %for loop to go through all the pixels in the Igray image
 for Index = 1 : size(Igray, 3)
    
     %copy of Igray, but as a double, this allows us to use work out the
     %new pixel data below as it only can work with intergers and scalar
     %doubles and Igray is a uint8 variable
     Working = double(Igray(:,:,Index)); 
     
     % Works out new pixel data from the data provided from the four
     % pixels and strores that data in tmp to be placed in the new image
     % below
     Temp = Working(Indices_1).*(1 - Delta_Y).*(1 - Delta_X) + ...
         Working(Indices_2).*(Delta_Y).*(1 - Delta_X) + ...
         Working(Indices_3).*(1 - Delta_Y).*(Delta_X) + ...
         Working(Indices_4).*(Delta_Y).*(Delta_X);
     
     %put new pixel data into the image from the temp image and holder
     %variables. we do it like (:,:,Index) due to the Meshgrid created as 
     %we only need a single number.
     ZoomImageBI(:,:,Index) = Temp;
     
 end
 
 %show images
 
 %bilinear 
 figure;
 imshow(ZoomImageBI)
 title('Step-4: Zoom By Biliear Interpolation');
 
 %NN
 figure;
 imshow(ZoomImageNN)
 title('Step-3: Zoom By Nearest Neighbour');
 
 %grey image
 figure;
 imshow(Igray);
 title('Step-2: Conversion of input image to greyscale');
 
 %Original image
 figure;
 imshow(IMG);
 title('Step-1: Load input image');
