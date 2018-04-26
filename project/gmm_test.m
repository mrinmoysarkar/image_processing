clear all;
close all;

X=1:251;
Y=1:251;
[xx,yy]=meshgrid(Y,X);
f = zeros(251,251,'uint8');
f(120:150,120:140)=180;
f(190:230,70:100)=127;
figure
imshow(f);
%figure
%imhist(f);

wn = uint8(randi(70,251));

f_n=uint8(f+wn);
f=uint8(f+wn);
figure
imshow(f);
%figure
%imhist(f);
k=10;

p = ones(1,k)*.5;
mu = ones(1,k)*150;
sig = 100*ones(1,k);

x_j = double(f(:));
n=length(x_j);
p_ij = zeros(k,n);


for ite=1:10
    for i=1:k
        for j=1:n
            dx = 0;
            for jj=1:k
                dx = dx + p(jj)*gaussdist(x_j(j),mu(jj),sig(jj));
            end
            p_ij(i,j) = p(i)*gaussdist(x_j(j),mu(i),sig(i))/dx;
        end
    end
    p = (sum(p_ij,2)')/n;
    xx_j = [];
    for i=1:k
        xx_j = [xx_j;x_j'];
    end
    sm = sum(xx_j.*p_ij,2)/n;
    mu = sm'./p;
    xx_j = ((xx_j - mu').^2);
    xx_j = xx_j .* p_ij;
    sm = sum(xx_j,2);
    dsig = sm./n;
    sig = dsig'./p;
end

F = uint8(cdf(256,p,mu,sig));

for i=1:251
    for j=1:251
        f(i,j) = 255*F(f(i,j)+1);
    end
end

figure 
imshow(f)
figure 
imshow(abs(f-f_n))
