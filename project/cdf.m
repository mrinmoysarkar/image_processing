function F=cdf(x,p,mu,sig)
F=zeros(1,x);
dx = 0;
for j=1:length(mu)
    dx = dx + p(j)*gaussdist(0,mu(j),sig(j));
end
F(1) = dx;
for i=2:x
    dx = 0;
    for j=1:length(mu)
        dx = dx + p(j)*gaussdist(i-1,mu(j),sig(j));
    end
    F(i) = F(i-1) + dx;
end
end