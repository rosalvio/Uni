#!/usr/bin/octave -qf

if (nargin!=5)
printf("Usage: pca+gaussian-exp.m <trdata> <trlabels> <ks> <%%trper> <%%dvper>\n")
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

alphas = [1e-9 1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 9e-1];

printf("\n    Ks    err-PCA");
printf("\n--------   --------\n");
for i=1:length(ks)
	[m, W] = pca(Xtr);
	pcaTr = Xtr - m;
	pcaTest = Xdv - m;
	WPCA = W(:, 1:ks(i));
	XR = pcaTr * WPCA;
	YR = pcaTest * WPCA;
	for alpha=alphas
		[errPCA] = gaussian(XR, xltr, YR, xldv, alpha);
		printf("%3d %3d %6.3f\n", ks(i), alpha, errPCA);
	endfor;
end;
