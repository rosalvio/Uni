#!/usr/bin/octave -qf

if (nargin!=5)
printf("Usage: pca+knn-exp.m <trdata> <trlabels> <ks> <%%trper> <%%dvper>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
ks=str2num(arg_list{3});
trper=str2num(arg_list{4});
dvper=str2num(arg_list{5});

load(trdata);
load(trlabs);

N=rows(X);
rand("seed",23); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

%
% HERE YOUR CODE
%

printf("\n err-No-PCA");
printf("\n--------\n");
[errNo] = knn(Xtr, xltr, Xdv, xldv, 1);
printf("%6.3f", errNo);

printf("\n    Ks    err-PCA");
printf("\n--------   --------\n");
for i=1:length(ks)
	[m, W] = pca(Xtr);
	pcaTr = Xtr - m;
	pcaTest = Xdv - m;
	WPCA = W(:, 1:ks(i));
	XR = pcaTr * WPCA;
	YR = pcaTest * WPCA;
	[errPCA] = knn(XR, xltr, YR, xldv, 1);
	printf("%3d %6.3f\n", ks(i), errPCA);
end;
