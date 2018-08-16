%% Built in prototype videos in matlab
% Try these videos as argument to VideoReader
% 'visiontraffic.avi'
% 'car-perspective-3-hires.m4v
% 'atrium.mp4'
%% clear and prepare workspace
clc
clear all
close all
%% Train the detector
foregroundDetector = vision.ForegroundDetector('NumGaussians', 3,'NumTrainingFrames', 50);
videoReader = vision.VideoFileReader('atrium.mp4');%'visiontraffic.avi',atrium.mp4,'car-perspective-3-hires.m4v'
for i = 1:150
    frame = step(videoReader); % read the next video frame
    foreground = step(foregroundDetector, frame);
end
figure; imshow(frame); title('Video Frame');
figure; imshow(foreground); title('Foreground');
se = strel('square', 3);
filteredForeground = imopen(foreground, se);
se = strel('square',20);
filteredForeground = imdilate(filteredForeground, se);
figure; 
imshow(filteredForeground); 
title('Clean Foreground');
%% Initialize detection components
blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
'AreaOutputPort', false, 'CentroidOutputPort', false, ...
     'MinimumBlobArea', 150);
bbox = step(blobAnalysis, filteredForeground);
result = insertShape(frame, 'Rectangle', bbox, 'Color', 'green');
numObjects = size(bbox, 1);
result = insertText(result, [10 10], numObjects, 'BoxOpacity', 1,'FontSize', 14);
figure; 
imshow(result); 
title('Detected objects');
%% Initialize video player
videoPlayer = vision.VideoPlayer('Name', 'Detected object');
videoPlayer.Position(3:4) = [700,400];  % window size: [width, height]
se = strel('square', 4); % morphological filter for noise removal
se1 = strel('square',20);
%cam = webcam;
%for idx = 1:100
%% Process frames
while ~isDone(videoReader)

    frame = step(videoReader); % read the next video frame
    %frame = snapshot(cam);

    % Detect the foreground in the current video frame
    foreground = step(foregroundDetector, frame);

    % Use morphological opening to remove noise in the foreground
    filteredForeground = imopen(foreground, se);
    
    filteredForeground = imdilate(filteredForeground, se1);

    % Detect the connected components with the specified minimum area, 
    bbox = step(blobAnalysis, filteredForeground);

    % Draw bounding boxes around the detected objects
    result = insertShape(frame, 'Rectangle', bbox, 'Color', 'green');

    % Display the number of objects found in the video frame
    numObjects = size(bbox, 1);
    result = insertText(result, [10 10], numObjects, 'BoxOpacity', 1,'FontSize', 14);

    step(videoPlayer, result);  % display the results
end

release(videoReader); % close the video file
%clear('cam')