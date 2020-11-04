#!/usr/bin/octave --no-gui

if (nargin!=7)
printf("Usage: mixgaussian-exp.m <trdata> <trlabels> <pcaKs> <Ks> <alphas> <%%trper> <%%dvper>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
pcaKs=str2num(arg_list{3});
Ks=str2num(arg_list{4});
trper=str2num(arg_list{5});
alphas=str2num(arg_list{6});
dvper=str2num(arg_list{7});

load(trdata);
load(trlabs);

N=rows(X);
seed=23; rand("seed",seed); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

printf("\n  alpha pca Ks dv-err");
printf("\n------- --- --- ------\n");

% Vectores de proyeccion en w estan por columnas
[m W]=pca(Xtr);
Xtr = Xtr-m;
Xdv = Xdv-m;

for i=1:length(alphas)
    for k=1:length(pcaKs)
    % Proyeccion
    pcaXtr= Xtr * W(:,1:PcaKs(k));
    pcaXdv= Xdv * W(:,1:PcaKs(k));
        %   NxD  *  D x K
        for j=1:length(Ks)
            edv(i,j) = mixgaussian(pcaXtr,xltr,pcaXdv,xldv, Ks(j),alphas(i));
            printf("%.1e %3d %3d %6.3f\n",alphas(i),PcaKs(k) ,Ks(j),edv);
        end;
    end;
end;



