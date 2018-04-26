function p=gaussdist(x,mu,sig)
p = (1/(2*pi*sig)^.5)*exp(-(double(x)-mu)^2/(2*sig));
end