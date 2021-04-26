#!/usr/bin/octave --no-gui

T = 1;
C = 1;
D = 2;
addpath('../svm_apr');

trdata="../data/mnist/train-images-idx3-ubyte.mat.gz";
trlabs="../data/mnist/train-labels-idx1-ubyte.mat.gz";
trper = 90;
dvper = 10;


args = "-t 1 -c 1 -d 2 -q"


load(trdata);
load(trlabs);



N=rows(X);
seed=23; rand("seed",seed); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

res = svmtrain(xltr, Xtr, args);
[l, a, expected]=svmpredict(xldv,Xdv,res,'-q');
err = 100 - a(1);
p = a(1)/100;
intervalo = 1.96*sqrt((p*(1-p))/N);
printf("\n   C     t   d   err   intervalo");
printf("\n------- --- --- ------ ---------\n");

printf("%3d %3d %3d %6.3f\n",C, T, D, err, intervalo);
