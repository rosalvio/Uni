#!/usr/bin/octave
addpath("../nnet_apr");
function [errY] = mlp(Xtr,xltr,Xdv,xldv,Y,yl,nHidden,epochs,show,seed)

Xtr = Xtr'; xltr = xltr'; Xdv = Xdv'; xldv = xldv'; Y = Y'; yl = yl';


[Xtrnorm,Xtrmean,Xtrstd] = prestd(Xtr);

XdvNN.P = trastd(Xdv,Xtrmean,Xtrstd);
XdvNN.T = onehot(xldv);

[nOutput, D] = size(XdvNN.T);

initNN = newff(minmax(Xtrnorm),[nHidden nOutput], {"tansig", "logsig"}, "trainlm", "", "mse");

initNN.trainParam.show = show;
initNN.trainParam.epochs = epochs;

rand("seed",seed);
NN = train(initNN, Xtrnorm, onehot(xltr), [],[], XdvNN);

Ynorm = trastd(Y, Xtrmean, Xtrstd);
Yout = sim(NN,Ynorm);

[~,iY]=max(Yout);

classes=unique(xltr);
errY=mean(classes(iY)!=yl)*100;


end;


if (nargin!=5)
printf("Usage: mixgaussian-exp.m <trdata> <trlabels> <nHiddens> <%%trper> <%%dvper>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
nHiddens=str2num(arg_list{3});
trper=str2num(arg_list{4});
dvper=str2num(arg_list{5});

load(trdata);
load(trlabs);

N=rows(X);
seed=23; rand("seed",seed); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);





printf("\n  nH     dv-err");
printf("\n-------  ------\n");
epochs = 300;
show = 10;
for i=1:length(nHiddens)
        [edv] = mlp(Xtr, xltr, Xdv, xldv, Xdv, xldv, nHiddens(i), epochs, show, seed);
        printf("%3d %6.3f\n",nHiddens(i),edv);
end;



