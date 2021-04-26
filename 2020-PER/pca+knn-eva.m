#!/usr/bin/octave -qf

if (nargin!=5)
printf("Usage: pca+knn-eva.m <trdata> <trlabels> <tedata> <telabels> <k>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
tedata=arg_list{3};
telabs=arg_list{4};
k=str2num(arg_list{5});

load(trdata);
load(trlabs);
load(tedata);
load(telabs);

%
% HERE YOUR CODE
%
printf("\n err-No-PCA");                    
printf("\n--------\n");                         
[errNo] = knn(X, xl, Y, yl, 1);
printf("%6.3f", errNo);


printf("\n err-PCA");                    
printf("\n--------\n");                         
ks = 100;
[m, W] = pca(X);
pcaTr = X - m;
pcaTest = Y - m;
WPCA = W(:, 1:ks);                      
XR = pcaTr * WPCA;
YR = pcaTest * WPCA;
[errPCA] = knn(XR, xl, YR, yl, k);
printf("%6.3f\n", errPCA);
