% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;

% Step-1: Load input image
IMG = imread('Noisy.png');

IMG = rgb2gray(IMG);

Y = size(IMG,1);
X = size(IMG,2);

% step-2: Mean - sum of all numbers divided by the amount this gives you
% the average
MeanImage = zeros(Y,X,'uint8');

ZeroPadded_X = X + 4;
ZeroPadded_Y = Y + 4;

Zero_Padding_Image = zeros(ZeroPadded_Y,ZeroPadded_X,'uint8');

%loops through all pixels in original image
for Y_Loop = 1: Y
    for X_Loop = 1: X
        
        %fills zero padded image with original image
        Zero_Padding_Image(Y_Loop + 2, X_Loop + 2) = IMG(Y_Loop,X_Loop);
        
    end
end

MeanNum = 0;
MeanFilterNumberHolder = zeros(5);

%loops through zeropadded image
for Y_Loop = 1: ZeroPadded_Y
    for X_Loop = 1: ZeroPadded_X  
        %if Y is withing the range of 3 - 474 then check for salt and pepper noise
        if (Y_Loop >= 3 && Y_Loop <= Y + 2)
            if (X_Loop >= 3 && X_Loop <= X + 2)
                
                MeanNum = 0;
                
                Filter_Y = -2;
                Filter_X = -2;
                
                for Index_Y = 1 : 5
                    for Index_X = 1 : 5
                        
                        MeanFilterNumberHolder(Index_Y, Index_X) = Zero_Padding_Image(Y_Loop - Filter_Y, X_Loop - Filter_X);
                        
                        Filter_X = Filter_X + 1;
                        
                    end
                    
                    Filter_Y = Filter_Y + 1;
                    Filter_X = -2;
                    
                end
                
                for Mean_Y = 1 : 5
                    for Mean_X = 1 : 5
                        
                        MeanNum = MeanNum + MeanFilterNumberHolder(Mean_Y, Mean_X);
                        
                    end
                end
                
                MeanNum = MeanNum / 25;
                
                Zero_Padding_Image(Y_Loop, X_Loop) = MeanNum;
                
            end 
        end
    end
end

%get the image and leave the zeropadding
for Y_Loop = 1 : ZeroPadded_Y
    for X_Loop = 1 : ZeroPadded_X
        
        %if Y is withing the range of 3 - 474 then check for salt and pepper noise
        if (Y_Loop >= 3 && Y_Loop <= Y + 2)
            if (X_Loop >= 3 && X_Loop <= X + 2)
                
                MeanImage(Y_Loop - 2, X_Loop - 2) = Zero_Padding_Image(Y_Loop, X_Loop);
                
            end
        end
    end
end 

%step-3: Median - the numbers are put in order then the middle number is
%the average
MedianImage = zeros(Y,X,'uint8');

MedianFilterNumberHolder = zeros(1, 100);
%loops through zeropadded image
for Y_Loop = 1: ZeroPadded_Y
    for X_Loop = 1: ZeroPadded_X  
        %if Y is withing the range of 3 - 474 then check for salt and pepper noise
        if (Y_Loop >= 3 && Y_Loop <= 476)
            if (X_Loop >= 3 && X_Loop <= 758)
                
                MeanNum = 0;
                
                Filter_Y = -2;
                Filter_X = -2;
                
                IndexMedian = 1;
                
                for Index_Y = 1 : 10
                    for Index_X = 1 : 10
                    
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

%write images
%Median
imwrite(MedianImage,'MedianImage.jpg');

%Mean
imwrite(MeanImage,'MeanImage.jpg');

%show images
%median image
figure;
imshow(MedianImage)
title('Step-3: MedianImage');

%mean image
figure;
imshow(MeanImage)
title('Step-2: MeanImage');

%original
figure;
imshow(IMG)
title('Original Image');
