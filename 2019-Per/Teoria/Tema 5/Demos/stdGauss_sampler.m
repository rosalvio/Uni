% function X = stdGauss_sampler(N,D)
% This function generates N samples from a D-dimensional estandar Gaussian
% with mean mu = zeros(D,1) and covariance matrix sigma=eye(D)
function X = stdGauss_sampler(N,D)

% Uniform distribution of random numbers in [0,1]
U1 = rand(N,D);
U2 = rand(N,D);

% Both ways of generating a standard Gaussian X ~ N(0,1) are possible
X = sqrt(-2*log(U1)).*cos(2*pi*U2);
%X = sqrt(-2*log(U1)).*sin(2*pi*U2);
