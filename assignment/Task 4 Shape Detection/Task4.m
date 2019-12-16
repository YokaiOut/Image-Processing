% MATLAB script for Assessment Item-1
% Task-4
clear; close all; clc;

%reads images and sets them to a variable
IMG_1 = imread('JustStarFishLeft.jpg');
IMG_2 = imread('Binary_Image_Of_Original.jpg');

%turns the images into binary images as they seem to have changed from
%binary once saved.
Binary_Image_1 = imbinarize(IMG_1);
Binary_Image_2 = imbinarize(IMG_2);

%Converts image from 1 being nothing to 1 being something and 0 meaining
%nothing. this is only done with the "Binary_Image_Of_Original" as when it
%is written it was in the opposite to how we want it.
for Y_Loop = 1: 362
    for X_Loop = 1: 438
        
        if(Binary_Image_2(Y_Loop, X_Loop) == 1)
            
           Binary_Image_2(Y_Loop, X_Loop) = 0;
           
        elseif (Binary_Image_2(Y_Loop, X_Loop) == 0)
            
            Binary_Image_2(Y_Loop, X_Loop) = 1;
            
        end     
    end 
end 


%StarFish boundary and signature creation
[B,L,N,A] = bwboundaries(Binary_Image_1);

%boundary for the star shape 
Boundary_Star_Fish = B{1};

%signature creation for the starfish
%This works out the data for the starfish shape signature,  this turns the
%origional data from cartesian 2 polar data. but before this all this all
%the numbers in column 1 of Boundary_Star_Fish will have the mean of the
%column taken away from evey number in the coloumn.
[Theta_StarFish, Radius_StarFish] = cart2pol(Boundary_Star_Fish(:,2)-mean(Boundary_Star_Fish(:,2)),Boundary_Star_Fish(:,1)-mean(Boundary_Star_Fish(:,1)));

%other Objects that i have selected from image 2 in the image boundary and signature creation
[B,L,N,A] = bwboundaries(Binary_Image_2);

%boundaries for 4 objects from the image from various locations
Boundary_Object_A = B{14};
Boundary_Object_B = B{38};
Boundary_Object_C = B{49};
Boundary_Object_D = B{70};

%signature creation for the objects
[Theta_Object_A, Radius_Object_A] = cart2pol(Boundary_Object_A(:,2) - mean(Boundary_Object_A(:,2)),Boundary_Object_A(:,1) -  mean(Boundary_Object_A(:,1)));
[Theta_Object_B, Radius_Object_B] = cart2pol(Boundary_Object_B(:,2) - mean(Boundary_Object_B(:,2)),Boundary_Object_B(:,1) - mean(Boundary_Object_B(:,1)));
[Theta_Object_C, Radius_Object_C] = cart2pol(Boundary_Object_C(:,2) - mean(Boundary_Object_C(:,2)),Boundary_Object_C(:,1) - mean(Boundary_Object_C(:,1)));
[Theta_Object_D, Radius_Object_D] = cart2pol(Boundary_Object_D(:,2) - mean(Boundary_Object_D(:,2)),Boundary_Object_D(:,1) - mean(Boundary_Object_D(:,1)));

%show image
%Object D
figure;
%creates the signature for us to see, but assigns it to a variable so we
%can create an image with it later
Object_D_Plot = plot(Theta_Object_D,Radius_Object_D,'m*');
%limits the aspect ratio
axis([-4 4 0 50]);
%sets an X label
xlabel('Radians');
%sets an Y label
ylabel('r');
%gives the figure a title to tell use what its showing us
title('Object D Signature');

%Object C
figure;
Object_C_Plot =plot(Theta_Object_C,Radius_Object_C,'r*');
axis([-4 4 0 50]);
xlabel('Radians');
ylabel('r');
title('Object C Signature');

%Object B
figure;
Object_B_Plot = plot(Theta_Object_B,Radius_Object_B,'b*');
axis([-4 4 0 50]);
xlabel('Radians');
ylabel('r');
title('Object B Signature');

%Object A
figure;
Object_A_Plot = plot(Theta_Object_A,Radius_Object_A,'c*');
axis([-4 4 0 50]);
xlabel('Radians');
ylabel('r');
title('Object A Signature');

%StarFish shape signature 
figure;
Star_Fish_Plot = plot(Theta_StarFish,Radius_StarFish,'g*');
axis([-4 4 0 50]);
xlabel('Radians');
ylabel('r');
title('Star Fish Shape Signature');

%all objects and starfish signature
figure;
ALL_Objects_Plot = plot(Theta_StarFish, Radius_StarFish,'g*', Theta_Object_A, Radius_Object_A,'c*',Theta_Object_B, Radius_Object_B,'b*',Theta_Object_C, Radius_Object_C,'r*', Theta_Object_D, Radius_Object_D,'m*');
axis([-4 4 0 50]);
xlabel('Radians');
ylabel('r');
title('This graph shows all the objects signatures and the starfish signature');

%Object A,B,C,D image
figure;
imshow(Binary_Image_2);
hold on;
%plot Object_A
plot(Boundary_Object_A(:,2), Boundary_Object_A(:,1),'c','LineWidth', 2);

%plot Object_B
plot(Boundary_Object_B(:,2), Boundary_Object_B(:,1),'b','LineWidth', 2);

%plot Object_C
plot(Boundary_Object_C(:,2), Boundary_Object_C(:,1),'r','LineWidth', 2);

%plot Object_D
plot(Boundary_Object_D(:,2), Boundary_Object_D(:,1),'m','LineWidth', 2);

title('Object image, the coloured objects are the ones being used');

%StarFish image and the Starfish picked in green
figure;
imshow(Binary_Image_1);
hold on;
plot(Boundary_Star_Fish(:,2), Boundary_Star_Fish(:,1),'g','LineWidth', 2);
title('StarFish image with the starfish used with a green outline');

%Write plots to images
% %All Objects and Starfish 
%  saveas(ALL_Objects_Plot,'ALL_Objects_Signature.png');

%Starfish
saveas(Star_Fish_Plot,'Star_Fish_Signature.png');

%Object_A
saveas(Object_A_Plot,'Object_A_Signature.png');

%Object_B
saveas(Object_B_Plot,'Object_B_Signature.png');

%Object_C
saveas(Object_C_Plot,'Object_C_Signature.png');

%Object_D
saveas(Object_D_Plot,'Object_D_Signature.png');
