%% author : mrinmoy sarkar
%  date : 4/22/2018

clear all;
close all;


%% initialize parameters
M = 240;
N = 320;
K = 3;
totalPixel = M*N;
maxPixelval = 255;
inintSig = 50;

mu = randi(maxPixelval,totalPixel,K);
sig = inintSig*ones(totalPixel,K);
w = rand(totalPixel,K);
w = w./sum(w,2);

model.mu = mu;
model.sig = sig;
model.w = w;

img = imread('mrinmoy.jpg');%randi(maxPixelval,totalPixel,1);
img = rgb2gray(img);
x = imresize(img,[M N]);
X=x(:);
thSig = 2.5;
alpha = 0.7;

img = imresize(img,[M N]);

%for ite = 1:400
v = VideoReader('car1.m4v');
figure
frameno = 1;
while hasFrame(v)
    fprintf('frameno.: %d\n',frameno);frameno = frameno+1;
    video = readFrame(v);
    subplot(221)
    imshow(video)
    img = rgb2gray(video);
    subplot(222)
    imshow(img)
    if frameno<250
        x = imresize(img,[M N]);
        X=x(:);
        X = double(X);
        for i=1:totalPixel
            flag = 1;
            p=0;
            k=0;
            x = X(i);
            for j=1:K
                mu = model.mu(i,j);
                sig = model.sig(i,j);
                if flag && (abs(x - mu) <= thSig*sig)
                    roh = alpha*eta1d(x,mu,sig);
                    model.mu(i,j) = (1-roh).*mu + roh.*x;
                    model.sig(i,j) = ((1-roh)*sig^2 + roh*(x-mu)^2)^.5;
                    model.w(i,j) = (1-alpha).*model.w(i,j) + alpha;
                    flag = 0;
                    continue;
                end
                model.w(i,j) = (1-alpha).*model.w(i,j);
                ptem = eta1d(x,mu,sig);
                if p>ptem
                    p=ptem;
                    k=j;
                end
            end
            if flag == 1
                model.mu(i,j) = x;
                model.sig(i,j) = inintSig;
                model.w(i,j) = 0.01;
            end
        end
        model.w = model.w./sum(model.w,2);
        
        for i=1:size(X,1)
            [m,mi] = max(model.w(i,:));
            g(i) = model.mu(i,mi);
        end
        g=reshape(g,[M N]);
        bgimg=uint8(g);
        bgimg=medfilt2(bgimg);
    end
    subplot(223)
    imshow(bgimg)
    subplot(224)
    imshow(abs(img-bgimg))
    %pause(0.01)
end

%% reconstruct the image
% for i=1:size(X,1)
%     [m,mi] = max(model.w(i,:));
%     g(i) = model.mu(i,mi);
% end
% g=reshape(g,[M N]);
% newimg=uint8(g);
% figure(1)
% subplot(121)
% imshow(img)
% subplot(122)
% imshow(newimg)