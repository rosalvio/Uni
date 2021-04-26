#!/usr/bin/octave -qf
trdata="../data/mnist/train-images-idx3-ubyte.mat.gz";
trlabs="../data/mnist/train-labels-idx1-ubyte.mat.gz";
ydata="../data/mnist/t10k-images-idx3-ubyte.mat.gz";
ylabels="../data/mnist/t10k-labels-idx1-ubyte.mat.gz";

load(trdata);
load(trlabs);
load(ydata);
load(ylabels);


addpath('../svm_apr');

ts = ["0", "2", "3"];
cs = ["1", "10", "100"]; %1
ds = ["1", "2", "3", "4", "5"]; %Solo si es kernel polinomial

% Se hace t = 1 y luego el resto de kernels
% T = "1";
% printf("\n   C     t   d   err");
% printf("\n------- --- --- ------\n");
% for C=cs
%     for D=ds
%         args = cstrcat("-q -t ", T, " -c ", C, " -d ", D);
%         res = svmtrain(xl, X, args);
%         [l, a, expected]=svmpredict(yl,Y,res,'-q');
%         err = 100 - a(1);
%         printf("%s %s %s %6.3f\n",C,T ,D,err);
%         endfor;
%     endfor;
printf("\n   C     t   err");
printf("\n------- --- ------\n");
    % for C=cs
    %     for T=ts
            % args = cstrcat("-q -t ", T, " -c ", C);
            args = '-q -t 0 -c 1';
            C = 1;
            T = 0;
            res = svmtrain(xl, X, args);
            [l, a, expected]=svmpredict(yl,Y,res,'-q');
            err = 100 - a(1);
            printf("%s %s %6.3f\n",C,T,err);
        %     endfor;
        % endfor;
printf("\nENDED\n");