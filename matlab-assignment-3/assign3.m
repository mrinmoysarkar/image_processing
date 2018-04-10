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
f(120:130,120:130)=1;
%% form g(x,y)
g = zeros(251,251,'logical');
for i=1:251
    for j=1:251
        dx = i-125;
        dy = j-125;
        if ((dx^2+dy^2)^0.5) <= 5
        g(i,j) = 1;
        end
    end
end
%% plot and image show f(x,y) and g(x,y)
figure(1)
subplot(231)
plot(f)
title('f(x,y) 2D')
subplot(232)
mesh(xx,yy,f);
title('f(x,y) 3D')
subplot(233)
imshow(f)
title('f(x,y)')
subplot(234)
plot(g)
title('g(x,y) 2D')
subplot(235)
mesh(xx,yy,g)
title('g(x,y) 3D')
subplot(236)
imshow(g)
title('g(x,y)')
% cicular shift in spatial domain
f = circshift(f,[125,125]);
g = circshift(g,[125,125]);
%% plot and image show f(x,y) and g(x,y) after circular shift
figure(2)
subplot(231)
plot(f)
title('f(x,y) after circular shift in spatial domain 2D')
subplot(232)
mesh(xx,yy,f);
title('f(x,y) after circular shift in spatial domain 3D')
subplot(233)
imshow(f)
title('f(x,y) after circular shift in spatial domain')
subplot(234)
plot(g)
title('g(x,y) after circular shift in spatial domain 2D')
subplot(235)
mesh(xx,yy,g)
title('g(x,y) after circular shift in spatial domain 3D')
subplot(236)
imshow(g)
title('g(x,y) after circular shift in spatial domain')
%% find F(u,v) and G(u,v)
F = fft2(f);
G = fft2(g); 

%% plot and image show |F(u,v)| and |G(u,v)|
figure(3)
subplot(231)
plot(abs(F))
title('|F(u,v)| 2D')
subplot(232)
mesh(xx,yy,abs(F));
title('|F(u,v)| 3D')
subplot(233)
imshow(abs(F))
title('|F(u,v)|')
subplot(234)
plot(abs(G))
title('|G(u,v)| 2D')
subplot(235)
mesh(xx,yy,abs(G))
title('|G(u,v)| 3D')
subplot(236)
imshow(abs(G))
title('|G(u,v)|')

%% plot and image show phase(F(u,v)) and phase(G(u,v))
figure(4)
subplot(231)
plot(angle(F));
title('phase(F(u,v)) 2D')
subplot(232)
mesh(xx,yy,angle(F));
title('phase(F(u,v)) 3D')
subplot(233)
imshow(angle(F))
title('phase(F(u,v))')
subplot(234)
plot(angle(G))
title('phase(G(u,v)) 2D')
subplot(235)
mesh(xx,yy,angle(G))
title('phase(G(u,v)) 3D')
subplot(236)
imshow(angle(G))
title('phase(G(u,v))')

%% plot and image show circular shift of |F(u,v)| and |G(u,v)|
figure(5)
subplot(231)
plot(abs(fftshift(F)));
title('circular shifted |F(u,v)| 2D')
subplot(232)
mesh(xx,yy,abs(fftshift(F)));
title('circular shifted |F(u,v)| 3D')
subplot(233)
imshow(abs(fftshift(F)))
title('circular shifted |F(u,v)|')
subplot(234)
plot(abs(fftshift(G)))
title('circular shifted |G(u,v)| 2D')
subplot(235)
mesh(xx,yy,abs(fftshift(G)))
title('circular shifted |G(u,v)| 3D')
subplot(236)
imshow(abs(fftshift(G)))
title('circular shifted |G(u,v)|')

%% plot and image show circular shift of phase(F(u,v)) and phase(G(u,v))
figure(6)
subplot(231)
plot(angle(fftshift(F)));
title('circular shifted phase(F(u,v)) 2D')
subplot(232)
mesh(xx,yy,angle(fftshift(F)));
title('circular shifted phase(F(u,v)) 3D')
subplot(233)
imshow(angle(fftshift(F)))
title('circular shifted phase(F(u,v))')
subplot(234)
plot(angle(fftshift(G)))
title('circular shifted phase(G(u,v)) 2D')
subplot(235)
mesh(xx,yy,angle(fftshift(G)))
title('circular shifted phase(G(u,v)) 3D')
subplot(236)
imshow(angle(fftshift(G)))
title('circular shifted phase(G(u,v))')

