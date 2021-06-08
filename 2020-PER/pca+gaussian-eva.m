#!/usr/bin/octave -qf

if (nargin!=4)
printf("Usage: pca+gaussian-exp.m <trdata> <trlabels> <tedata> <telabels>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
tedata=arg_list{3};
telabs=arg_list{4};

load(trdata);
load(trlabs);
load(tedata);
load(telabs);

k = 50;
alpha = 9e-1;

printf("\n    Ks    alpha	err");
printf("\n--------   --------	-------\n");
[m, W] = pca(X);
pcaTr = X - m;
pcaTest = Y - m;
WPCA = W(:, 1:k);
XR = pcaTr * WPCA;
YR = pcaTest * WPCA;
[errPCA] = gaussian(XR, xl, YR, yl, alpha);
printf("%3d %3d %6.3f\n", k, alpha, errPCA);
