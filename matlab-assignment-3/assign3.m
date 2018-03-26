%% Matlab Assignment #3
%  author : Mrinmoy Sarkar
%  email  : msarkar@aggies.ncat.edu
%  date   : 3/26/2018
%%
clear all; close all;

%% form f(x,y)
X=1:251;
Y=1:251;
[xx,yy]=meshgrid(Y,X);
f = zeros(251,251,'logical');
f(120:130,:)=1;

%% form g(x,y)
g = zeros(251,251,'logical');
g(120:130,120:130)=1;

%% plot and image show f(x,y) and g(x,y)
figure(1)
subplot(221)
mesh(xx,yy,f);
title('f(x,y)')
subplot(222)
imshow(f)
title('f(x,y)')
subplot(223)
mesh(xx,yy,g)
title('g(x,y)')
subplot(224)
imshow(g)
title('g(x,y)')

%% find F(u,v) and G(u,v)
F = fft2(f);
G = fft2(g); 

%% plot and image show |F(u,v)| and |G(u,v)|
figure(2)
subplot(221)
mesh(xx,yy,abs(F));
title('|F(u,v)|')
subplot(222)
imshow(abs(F))
title('|F(u,v)|')
subplot(223)
mesh(xx,yy,abs(G))
title('|G(u,v)|')
subplot(224)
imshow(abs(G))
title('|G(u,v)|')

%% plot and image show phase(F(u,v)) and phase(G(u,v))
figure(3)
subplot(221)
mesh(xx,yy,angle(F));
title('phase(F(u,v))')
subplot(222)
imshow(angle(F))
title('phase(F(u,v))')
subplot(223)
mesh(xx,yy,angle(G))
title('phase(G(u,v))')
subplot(224)
imshow(angle(G))
title('phase(G(u,v))')

%% plot and image show circular shift of |F(u,v)| and |G(u,v)|
figure(4)
subplot(221)
mesh(xx,yy,abs(fftshift(F)));
title('circular shifted |F(u,v)|')
subplot(222)
imshow(abs(fftshift(F)))
title('circular shifted |F(u,v)|')
subplot(223)
mesh(xx,yy,abs(fftshift(G)))
title('circular shifted |G(u,v)|')
subplot(224)
imshow(abs(fftshift(G)))
title('circular shifted |G(u,v)|')

%% plot and image show circular shift of phase(F(u,v)) and phase(G(u,v))
figure(5)
subplot(221)
mesh(xx,yy,angle(fftshift(F)));
title('circular shifted phase(F(u,v))')
subplot(222)
imshow(angle(fftshift(F)))
title('circular shifted phase(F(u,v))')
subplot(223)
mesh(xx,yy,angle(fftshift(G)))
title('circular shifted phase(G(u,v))')
subplot(224)
imshow(angle(fftshift(G)))
title('circular shifted phase(G(u,v))')

