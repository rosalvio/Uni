#!/usr/bin/octave -qf

if (nargin!=5)
printf("Usage: pca+knn-exp.m <trdata> <trlabels> <epsilons> <%%trper> <%%dvper>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
epsilons=str2num(arg_list{3});
trper=str2num(arg_list{4})/100;
dvper=str2num(arg_list{5})/100;

load(trdata);
load(trlabs);

N=rows(X);
rand("seed",23); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper*N); Ndv=round(dvper*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

[edv] = multinomial(Xtr, xltr, Xdv, xldv, epsilons);
