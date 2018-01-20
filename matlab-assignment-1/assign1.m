%% Matlab Assignment #1
%  author : Mrinmoy Sarkar
%  email  : msarkar@aggies.ncat.edu
%  date   : 1/19/2018
%%
clear all; close all;

file_name = 'mrinmoy.jpg';
%% Task-1: load the image
img_color = imread(file_name);
%% Task-2: display the image
figure
imshow(img_color);
title('original image')
%% Task-3a: display the intensity of Red color
img_red = img_color(:,:,1);
figure
imshow(img_red)
title('Red color intensity')
%% Task-3b: display the intensity of Green color
img_green = img_color(:,:,2);
figure
imshow(img_green)
title('Green color intensity')
%% Task-3c: display the intensity of Blue color
img_blue = img_color(:,:,3);
figure
imshow(img_blue)
title('Blue color intensity')
%% Task-4: change to gray scale image and display it
img_gray = rgb2gray(img_color);
figure
imshow(img_gray)
title('Gray scale image')
%% Task-5: Resize the BW image to 64x64 image and display it
img_resized = imresize(img_gray,[64 64]);
figure
imshow(img_resized)
title('resized image(64x64)')
%% Task-6: Write the resized image to a file
imwrite(img_resized,'resized_gray_image.jpg')
%% Task-7: 3D plot the resized 64x64 image
figure
surf(img_resized)
xlabel('x')
ylabel('y')
zlabel('I')
title('3D plot of the resized image')
%% Task-8: Filter the 64x64 image by a median filter and 3D plot it
img_filtered = medfilt2(img_resized);
figure
surf(img_filtered)
xlabel('x')
ylabel('y')
zlabel('I')
title('3D plot of the filtered image')