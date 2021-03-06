clear all;
close all;

v = VideoReader('car-perspective-3-hires.m4v');
figure
video = readFrame(v);
M = size(video,1);
N = size(video,2);

windowlen=50;
th = 50;
oldImg = zeros(M,N,3,windowlen);
frameno = 0;
figure(1)
while  hasFrame(v)
    
    fprintf('frameno.: %d\n',frameno);
    video = readFrame(v);
    indx = mod(frameno,windowlen)+1;
    oldImg(:,:,:,indx) = double(video);
    subplot(221)
    imshow(video)
    background = uint8(sum(oldImg,4)/windowlen);
    frameno = frameno+1;
    
    subplot(331)
    imshow(video)
    subplot(332)
    imshow(background)
    maskimg = uint8(abs(double(video)-double(background)));
    subplot(333)
    imshow(maskimg)
    maskgray = rgb2gray(maskimg);
    maskbw = maskgray > th;
    subplot(334)
    imshow(maskbw)
    FilteredImage=medfilt2(maskbw,[5 5]);
    %SE = strel('rectangle',[30 30]);
    %erodedmask = imerode(maskbw,SE);
    SE = strel('rectangle',[5 5]);
    dilutatedmask = imdilate(FilteredImage,SE);
    subplot(335)
    imshow(dilutatedmask)
%     objedge = edge(dilutatedmask,'Canny');
%     subplot(336)
%     imshow(objedge)
%     [x1,y1] = find(objedge==1,1,'first');
%     [x2,y2] = find(objedge==1,1,'last');
%     if ~isempty(x1) && ~isempty(x2) && ~isempty(y1) && ~isempty(y2)
%         if ((x2-x1) > 5) && ((y2-y1) > 5)
%             rect = zeros(x2-x1+1,y2-y1+1,3);
%             rect(:,1:5,1)=255;
%             rect(:,end-5:end,1)=255;
%             rect(1:5,:,1)=255;
%             rect(end-5:end,:,1)=255;
%             rect = uint8(rect);
%             subplot(337)
%             imshow(rect)
%             newimg = video;
%             newimg(x1:x2,y1:y2,:) = bitor(newimg(x1:x2,y1:y2,:),rect);
%             subplot(338)
%             imshow(newimg)
%         end
%     else
%         subplot(338)
%         imshow(video)
%     end
%     
%     if mod(frameno, 10) == 0
%     subplot(339)
%     [x,y] = find(dilutatedmask==1);
%     newimg = video;
%     newimg(x,y,1)=255;
%     newimg(x,y,2)=0;
%     newimg(x,y,3)=0;
%     imshow(newimg);
%     end
       
       subplot(337)
       B = bwboundaries(dilutatedmask,'noholes');
       imshow(video)
       hold on
       for k = 1:length(B)
           boundary = B{k};
           plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)
       end

    pause(.001)
end