#!/usr/bin/octave --no-gui

T = 1;
C = 1;
D = 2;
addpath('../svm_apr');

trdata="../data/mnist/train-images-idx3-ubyte.mat.gz";
trlabs="../data/mnist/train-labels-idx1-ubyte.mat.gz";

args = "-t 1 -c 1 -d 2 -q"


load(trdata);
load(trlabs);
load("../data/mnist/t10k-images-idx3-ubyte.mat.gz")
load("../data/mnist/t10k-labels-idx1-ubyte.mat.gz")



[N, d]= size(Y);
res = svmtrain(xl, X, args);
[l, a, expected]=svmpredict(yl,Y,res,'-q');
err = 100 - a(1);
p = a(1)/100;
intervalo = 1.96*sqrt((p*(1-p))/N);
printf("\n   C     t   d   err   intervalo");
printf("\n------- --- --- ------ ---------\n");

printf("%3d %3d %3d %6.3f %6.3f\n",C, T, D, err, intervalo);
