X=stdGauss_sampler(1000,2);
plot(X(:,1),X(:,2),"+k");
axis([-4 4 -4 4]);

mu=[0 0]
sigma=[1 0 ; 0 2]
[eigvec eigval]=eig(sigma)
X=stdGauss_sampler(1000,2);
X=X*sqrt(eigval);
plot(X(:,1),X(:,2),"+k"); axis(2*[-4 4 -4 4]);

sigma=[1 1 ; 1 2]
[eigvec eigval]=eig(sigma)
XE=X*sqrt(eigval);
plot(X(:,1),X(:,2),"+k"); axis(2*[-4 4 -4 4]);

XER=X*sqrt(eigval)*eigvec';
plot(X(:,1),X(:,2),"+k"); axis(2*[-4 4 -4 4]);

plot(X(:,1),X(:,2),"+k"); axis(2*[-4 4 -4 4]); pause(2); plot(XE(:,1),XE(:,2),"+k"); axis(2*[-4 4 -4 4]); pause(2); plot(XER(:,1),XER(:,2),"+k"); axis(2*[-4 4 -4 4]);

X=genGauss_sampler(1000,mu,sigma);
plot(X(:,1),X(:,2),"+k"); axis(2*[-4 4 -4 4]);
