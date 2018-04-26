clear all;
a = .5;
u = 20;
sig = 100;
x = 200;
for i=1:10
    p=(1/(sig*(2*pi)^.5))*exp(-((x-u)/sig)^2);
    p=p*a;
    u=(1-p)*u+p*x;
    sig = ((1-p)*sig^2+p*(x-u)^2);
    if sig < 0.16
        break;
    end
    sig = sqrt(sig);
end
x
u
sig

v = VideoReader('car1.m4v');

figure
while hasFrame(v)
    video = readFrame(v);
    imshow(video)
end