function [I] = LoadImageFindFace(X)

I = imread(X); %this loads the image

FaceDetector = vision.CascadeObjectDetector; %sets up the facedetector for later

bboxes = step(FaceDetector, I); %if a face is found it will get 4 numbers that are coordinates
 
if ~isempty(bboxes) %if the BBoxes has no data no face is found
      
    [Y,X] = size(bboxes); %sets Y as the Rows value of the matrix and the X as the Columns

    if Y > 1
        
        disp('faces found') %tells user the program has found a face   
       
    else
            
        disp('face found') %tells user the program has found a face
        
    end
    
    IFaces = insertObjectAnnotation(I,'rectangle', bboxes, 'Face Found'); %draws the rectanfles where the faces are

    TitleText = ['Detected Faces = ', num2str(Y)]; %this is the text that is shown in the title

    figure, imshow(IFaces), title(TitleText); %shows the snapshot and gives it a title
       
end

release(FaceDetector); %frees the Face detection
