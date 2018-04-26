function y = eta1d(x,mu,sig)
if sqrt(2*pi)*sig<1
    y=1;
    return
end
y = (1/(((2*pi)^(0.5))*sig))*exp(-0.5*(((x-mu)/sig)^2));
end