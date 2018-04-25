function y = eta(x,mu,sig)
n = length(x);    
sig = eye(n).*(sig.^2);
y = (1/(((2*pi)^(n/2))*(det(sig)^.5)))*exp(-0.5*(x-mu)'*pinv(sig)*(x-mu));
end