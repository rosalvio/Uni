% function X = genGauss_sampler(N,mu,sigma)
% This function generates N samples from a D-dimensional general Gaussian
% with mean mu (1xD) and covariance matrix sigma (DxD)
function X = genGauss_sampler(N,mu,sigma)

D=columns(mu);

% Uniform distribution of random numbers in [0,1]
U1 = rand(N,D);
U2 = rand(N,D);

% Both ways of generating a standard Gaussian X ~ N(0,1) are possible
X = sqrt(-2*log(U1)).*cos(2*pi*U2);
%X = sqrt(-2*log(U1)).*sin(2*pi*U2);

% Calculate eigenvalues and eigenvectors for the covariance matrix
[eigvec, eigval] = eig(sigma);

% Generate general Gaussian samples X ~ N(mu,covar)
% eigvec and eigval are D x D
A = eigvec*sqrt(eigval);
% NxD * DxD + 1xD
X = X*A' + mu;
