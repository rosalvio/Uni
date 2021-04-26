#!/usr/bin/octave --no-gui


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


if (nargin!=6)
printf("Usage: pca+mlp-eva.m <pcaKs> <nHiddens> <%%trper> <%%dvper>\n")
exit(1);
end;

arg_list=argv();
pcaKs=str2num(arg_list{1});
nHiddens=str2num(arg_list{2});
trper=str2num(arg_list{3});
dvper=str2num(arg_list{4});


trdata="../data/mnist/train-images-idx3-ubyte.mat.gz";
trlabs="../data/mnist/train-labels-idx1-ubyte.mat.gz";
load(trdata);
load(trlabs);
load("../data/mnist/t10k-images-idx3-ubyte.mat.gz")
load("../data/mnist/t10k-labels-idx1-ubyte.mat.gz")


N=rows(X);
seed=23; rand("seed",seed); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

epochs = 300;
show = 10;

printf("\nnHiddens D  epochs dv-err");
printf("\n------- ----- ------ ------\n");

% Vectores de proyeccion en w estan por columnas
[m W]=pca(Xtr);
Xtr = Xtr-m;
Xdv = Xdv-m;
[my Wy]=pca(Y);
Y = Y-my;

for i=1:length(nHiddens)
    for k=1:length(pcaKs)
    % Proyeccion
    pcaXtr= Xtr * W(:,1:pcaKs(k));
    pcaXdv= Xdv * W(:,1:pcaKs(k));
    pcaY = Y * W(:,1:pcaKs(k));
        %   NxD  *  D x K
            [edv] = mlp(pcaXtr, xltr, pcaXdv, pcaxldv, pcaY, yl, nHiddens(i), epochs, show, seed);
            printf("%3d %3d %3d %6.3f\n",nHiddens(i), pcaKs(k), epochs, edv);
    endfor;

end;



