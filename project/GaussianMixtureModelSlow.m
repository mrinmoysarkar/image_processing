
%% Built in prototype videos in matlab
% Try these videos as argument to VideoReader
% 'visiontraffic.avi'
% 'car-perspective-3-hires.m4v
% 'atrium.mp4'
%% Clear and prepare workspace
clc
close all
clear all
%% Read video from file
v = VideoReader('visiontraffic.avi');
fr_bw = readFrame(v);
%% initialize foreground and background
[height, width,~] = size(fr_bw);
foreground = zeros(height, width);
background = zeros(height, width);
%% set video player
videoPlayer = vision.VideoPlayer('Name', 'Detected object');
videoPlayer.Position(3:4) = [700,400];  % window size: [width, height]

%% Initialize mixture of gaussian model parameters
numberofgaussian = 3;
backgroundcomponent = 3;
deviationthreshold = 2.5;
learningrate = 0.01;
foregroundthreshold = 0.25;
initialstandarddev = 6;
d = zeros(height,width,numberofgaussian);              % distance of each pixel from mean
p = learningrate/(1/numberofgaussian);                 % initialize p
rank = zeros(1,numberofgaussian);                      % rank of components weight and standard deviation
%% Initialize weight, Mean, standard deviation
intensitylevel = 255;
M = rand(height,width,numberofgaussian)*intensitylevel;
w = ones(height,width,numberofgaussian)./numberofgaussian;
sd = initialstandarddev.*ones(height,width,numberofgaussian);
%% Initialize boundary box parameters
se = strel('square', 4); % morphological filter for noise removal
se1 = strel('square',20);
blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
    'AreaOutputPort', false, 'CentroidOutputPort', false, ...
    'MinimumBlobArea', 150);
%% process each frame
while  hasFrame(v)
    fr_bw = readFrame(v);
    % compute distance of pixel from gaussian mean
    d = abs(double(fr_bw)-M);
    % for each pixel
%     [i,j,k] = find(abs(d) <= deviationthreshold*sd);
%     [l,m,n] = find(abs(d) > deviationthreshold*sd); 
%     break;
    for i=1:height
        for j=1:width
            match = 0;
            for k=1:numberofgaussian
                if (abs(d(i,j,k)) <= deviationthreshold*sd(i,j,k))       
                    match = 1;                          
                    % update weights, mean, sd, p
                    w(i,j,k) = (1-learningrate)*w(i,j,k) + learningrate;
                    p = learningrate/w(i,j,k);
                    M(i,j,k) = (1-p)*M(i,j,k) + p*double(fr_bw(i,j));
                    sd(i,j,k) =   sqrt((1-p)*(sd(i,j,k)^2) + p*((double(fr_bw(i,j)) - M(i,j,k)))^2);
                else                                    
                    w(i,j,k) = (1-learningrate)*w(i,j,k);      
                end
            end
            
            w(i,j,:) = w(i,j,:)./sum(w(i,j,:));
            background(i,j)=0;
            for k=1:numberofgaussian
                background(i,j) = background(i,j)+ M(i,j,k)*w(i,j,k);
            end
            
            % if no components match, create new component
            if (match == 0)
                [min_w, min_w_index] = min(w(i,j,:));
                M(i,j,min_w_index) = double(fr_bw(i,j));
                sd(i,j,min_w_index) = initialstandarddev;
            end
            rank = w(i,j,:)./sd(i,j,:);             
            rank_ind = [1:1:numberofgaussian];
            
            % sort rank values
            for k=2:numberofgaussian
                for m=1:(k-1)
                    if (rank(:,:,k) > rank(:,:,m))
                        % swap max values
                        rank_temp = rank(:,:,m);
                        rank(:,:,m) = rank(:,:,k);
                        rank(:,:,k) = rank_temp;
                        
                        % swap max index values
                        rank_ind_temp = rank_ind(m);
                        rank_ind(m) = rank_ind(k);
                        rank_ind(k) = rank_ind_temp;
                        
                    end
                end
            end
            
            % calculate foreground
            match = 0;
            k=1;
            foreground(i,j) = 0;
            while ((match == 0)&&(k<=backgroundcomponent))
                if (w(i,j,rank_ind(k)) >= foregroundthreshold)
                    if (abs(d(i,j,rank_ind(k))) <= deviationthreshold*sd(i,j,rank_ind(k)))
                        foreground(i,j) = 0;
                        match = 1;
                    else
                        foreground(i,j) = fr_bw(i,j);
                    end
                end
                k = k+1;
            end
        end
    end
    % Use morphological opening to remove noise in the foreground
    filteredForeground = imopen(foreground, se);
    filteredForeground = imdilate(logical(filteredForeground), se1);
    bbox = step(blobAnalysis, filteredForeground);
    
    % Draw bounding boxes around the detected objects
    result = insertShape(fr_bw, 'Rectangle', bbox, 'Color', 'green');
    
    step(videoPlayer, result)
    
end



