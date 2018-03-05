%% Matlab Assignment #2
%  author : Mrinmoy Sarkar
%  email  : msarkar@aggies.ncat.edu
%  date   : 3/2/2018
%%
clear all; close all;

file_name = 'mrinmoy.jpg';
%% load the image
img_color = imread(file_name);
%% Task-1: change to gray scale image
img_gray = rgb2gray(img_color);
img_gray = imresize(img_gray,.4);
%% Task-2: Obtain the enhanced image by Histogram Equalization
img_enhance_he = histeq(img_gray);
%% Task-3.a: Design histogram specification
n = 256;
hgram = (imhist(img_gray))';
total_pxl = numel(img_gray);
hgram(1,10:70) = hgram(1,10:70) + hgram(1,71:70+length(10:70));
hgram(1,71:70+length(10:70)) = 0;
hgram(1,191:190+length(130:190)) = hgram(1,191:190+length(130:190)) + hgram(1,130:190);
hgram(1,130:190)=0;
%% Task-3.b: Apply the histogram specification
img_enhance_hs = histeq(img_gray,hgram);
%% plot all the image
figure
subplot(131)
imshow(img_gray)
title('Original image')
subplot(132)
imshow(img_enhance_he)
title('Histogram equalized image')
subplot(133)
imshow(img_enhance_hs)
title('Histogram specified image')
%% plot the histogram
figure
subplot(311)
imhist(img_gray)
title('Histogram of Original image')
subplot(312)
imhist(img_enhance_he)
title('Histogram of Histogram equalized image')
subplot(313)
imhist(img_enhance_hs)
title('Histogram of Histogram specified image')
%% Task-4: Smooth imge using Gaussian kernel
sigma = 1;
img_smth1 = imgaussfilt(img_gray,sigma);
sigma = 10;
img_smth2 = imgaussfilt(img_gray,sigma);
%% plot image
figure
subplot(131)
imshow(img_gray)
title('Original image')
subplot(132)
imshow(img_smth1)
title('Smoothed image, sigma = 1')
subplot(133)
imshow(img_smth2)
title('Smoothed image, sigma = 10')
%% Task-5: Sharpen image using Laplacian
c = -1;
h = [0 1 0;1 -4 1;0 1 0]; % laplace kernel
img_laplace = imfilter(img_gray,h);
img_srpn = img_gray + c*img_laplace;
%% plot image
figure
subplot(131)
imshow(img_gray)
title('Original image')
subplot(132)
imshow(img_laplace)
title('Laplacian image')
subplot(133)
imshow(img_srpn)
title('Sharpened image')