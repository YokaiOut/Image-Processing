function [a] = SnapshotFaceFind

a = webcamlist; %finds a webcam avilable to use

Cam = webcam(a{1}); %assigns the webcam to Cam

preview(Cam); %shows you what the webcam can see

NotYet = false; %variable for later

FaceDetector = vision.CascadeObjectDetector; %sets up the facedetector for later

while ~NotYet %creates a loop which will go on till NotYet is true
    
    pause(2);%nothing happens for 2 seconds 
    
    I = snapshot(Cam); %takes a snapshot from the webcam
    
    disp('took a snapshot. checking for a face....') %tells the user it has taken a picture
    bboxes = step(FaceDetector, I); %if a face is found it will get 4 numbers that are coordinates
    
    if ~isempty(bboxes) %if the BBoxes has no data no face is found
        
       NotYet = true; %sets NotYet to true
       disp('face found') %tells user the program has found a face
       break;
       
    end
    
    disp('no face found. trying again'); %tells the user no face has been found and that the program will take another snapshot
    
end

%{
Size = size(bboxes);

Text = ['this is the size of bboxes ', num2str(Size)];

disp (Text);
%}

[Y,X] = size(bboxes); %sets Y as the Rows value of the matrix and the X as the Columns

closePreview(Cam); %closes the webcam video

clear('Cam'); %frees the Cam so it can be used for something else

release(FaceDetector); %frees the Face detection 

IFaces = insertObjectAnnotation(I,'rectangle', bboxes, 'Face Found'); %draws the rectanfles where the faces are

TitleText = ['Detected Faces = ', num2str(Y)]; %this is the text that is going to be shown in the title

figure, imshow(IFaces), title(TitleText); %shows the snapshot and gives it a title
