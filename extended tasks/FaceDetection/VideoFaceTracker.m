function [a] = VideoFaceTracker

a = webcamlist; %finds a webcam avilable to use

Cam = webcam(a{1}); %assigns the webcam to Cam

FaceDetector = vision.CascadeObjectDetector; % creates the face detector for the application

videoFrame = snapshot(Cam); %takes a snap shot
frameSize = size(videoFrame); %gets the res of the snap taken 

videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)]+30]); %sets the postion and tells us the res of the image

runLoop = true;

while runLoop
    
    videoFrame = snapshot(Cam); %takes a snap
    
    bboxes = step(FaceDetector, videoFrame); % checks the snap for a face
    
    if ~isempty(bboxes)
        
            videoFrame = insertObjectAnnotation(videoFrame, 'rectangle', bboxes, 'Face Found'); % if there is a face put a box around it
        
    else 
            videoFrame = insertObjectAnnotation(videoFrame, 'rectangle', bboxes, 'Face Found'); % keeps track of face
        
    end
    
   
    step(videoPlayer, videoFrame); %send image to videoplayer to create a video

    runLoop = isOpen(videoPlayer); %checks f the videoplayer is open
    
end

clear('Cam'); %frees the Cam so it can be used for something else
release(videoPlayer); %frees the video player 
release(FaceDetector); %frees the Face detection 