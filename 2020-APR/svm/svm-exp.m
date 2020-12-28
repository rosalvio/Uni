#!/usr/bin/octave --no-gui

if (nargin!=3 or nargin!=2)
printf("Usage: mixgaussian-exp.m <C> <t> <d>\n")
printf("Usage: mixgaussian-exp.m <C> <t>\n")
exit(1);
end;
addpath('../svm_apr');
arg_list=argv();
trdata="../data/mnist/train-images-idx3-ubyte.mat.gz";
trlabs="../data/mnist/train-labels-idx1-ubyte.mat.gz";
C=arg_list{1};
t=arg_list{2};
if (nargin == 3)
d=arg_list{3};
args = cstrcat("-t ", t, " -c ", C, " -d", d);
end;

if (nargin == 2)
args = cstrcat("-t ", t, " -c ", C);
end;

trper=90;
dvper=10;

load(trdata);
load(trlabs);
res = svmtrain(xl, X, args)

svmpredict()


N=rows(X);
seed=23; rand("seed",seed); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

printf("\n   C     t   d   err");
printf("\n------- --- --- ------\n");

% Vectores de proyeccion en w estan por columnas
[m W]=pca(Xtr);
Xtr = Xtr-m;
Xdv = Xdv-m;

for i=1:length(alphas)
    for k=1:length(pcaKs)
    % Proyeccion
    pcaXtr= Xtr * W(:,1:pcaKs(k));
    pcaXdv= Xdv * W(:,1:pcaKs(k));
        %   NxD  *  D x K
        for j=1:length(Ks)
            edv = mixgaussian(pcaXtr,xltr,pcaXdv,xldv, Ks(j),alphas(i));
            printf("%.1e %3d %3d %6.3f\n",alphas(i),pcaKs(k) ,Ks(j),edv);
        end;
    end;
end;