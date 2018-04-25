%% author : mrinmoy sarkar
%  date : 4/22/2018

clear all;
close all;


%% initialize parameters
M = 128;
N = 128;
K = 3;
totalPixel = M*N;
maxPixelval = 255;
inintSig = 5;

mu = randi(maxPixelval,totalPixel,K);
sig = inintSig*ones(totalPixel,K);
w = rand(totalPixel,K);
w = w./sum(w,2);

model.r.mu = mu;
model.g.mu = mu;
model.b.mu = mu;

model.r.sig = sig;
model.g.sig = sig;
model.b.sig = sig;
model.w = w;

img = imread('mrinmoy.jpg');%randi(maxPixelval,totalPixel,1);
x = imresize(rgb2gray(img),[M N]);
x=x(:);
thSig = 2.5;
alpha = 0.7;

img = imresize(img,[M N]);
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);

X = [r(:) g(:) b(:)];

for ite = 1:1
    X = double(X);
    for i=1:totalPixel
        flag = 1;
        p=0;
        k=0;
        x = X(i,:)';
        for j=1:K
            mu = [model.r.mu(i,j) model.g.mu(i,j) model.b.mu(i,j)]';
            sig = [model.r.sig(i,j) model.g.sig(i,j) model.b.sig(i,j)]';
            if flag && (abs(x(1) - model.r.mu(i,j)) <= thSig*model.r.sig(i,j))...
                    && (abs(x(2) - model.g.mu(i,j)) <= thSig*model.g.sig(i,j))...
                    && (abs(x(3) - model.b.mu(i,j)) <= thSig*model.b.sig(i,j))
                
                roh = alpha*eta(x,mu,sig);
                
                model.r.mu(i,j) = (1-roh).*model.r.mu(i,j) + roh.*x(1);
                model.g.mu(i,j) = (1-roh).*model.g.mu(i,j) + roh.*x(2);
                model.b.mu(i,j) = (1-roh).*model.b.mu(i,j) + roh.*x(3);
                
                model.r.sig(i,j) = ((1-roh).*(model.r.sig(i,j).^2) + ...
                    roh.*((x(1)-model.r.mu(i,j))'*(x(1)-model.r.mu(i,j)))).^.5;
                model.g.sig(i,j) = ((1-roh).*(model.g.sig(i,j).^2) + ...
                    roh.*((x(2)-model.g.mu(i,j))'*(x(2)-model.g.mu(i,j)))).^.5;
                model.b.sig(i,j) = ((1-roh).*(model.b.sig(i,j).^2) + ...
                    roh.*((x(3)-model.b.mu(i,j))'*(x(3)-model.b.mu(i,j)))).^.5;
                
                model.w(i,j) = (1-alpha).*model.w(i,j) + alpha;
                flag = 0;
                continue;
            end
            model.w(i,j) = (1-alpha).*model.w(i,j);
            ptem = eta(x,mu,sig);
            if p>ptem
                p=ptem;
                k=j;
            end
        end
        if flag == 1
            model.r.mu(i,j) = x(1);
            model.g.mu(i,j) = x(2);
            model.b.mu(i,j) = x(3);
            model.r.sig(i,j) = inintSig;
            model.g.sig(i,j) = inintSig;
            model.b.sig(i,j) = inintSig;
            
            model.w(i,j) = 0.01;
        end
    end
    model.w = model.w./sum(model.w,2);
end

%% reconstruct the image
for i=1:size(X,1)
    [m,mi] = max(model.w(i,:));
    r(i) = model.r.mu(i,mi);
    g(i) = model.g.mu(i,mi);
    b(i) = model.b.mu(i,mi);
end
r=reshape(r,[M N]);
g=reshape(g,[M N]);
b=reshape(b,[M N]);
newimg(:,:,1) = r;
newimg(:,:,2) = g;
newimg(:,:,3) = b;
newimg=uint8(newimg);
figure(1)
subplot(121)
imshow(img)
subplot(122)
imshow(newimg)