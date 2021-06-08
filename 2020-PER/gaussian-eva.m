#!/usr/bin/octave -qf

if (nargin!=4)
printf("Usage: gaussian-eva.m <trdata> <trlabels> <tedata> <telabels>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
tedata=arg_list{3};
telabs=arg_list{4};
alpha=1e-4;

% Loading data
load(trdata);
load(trlabs);
load(tedata);
load(telabs);

[ete] = gaussian(X,xl,Y,yl,alpha);

printf("\n  alpha te-err");
printf("\n------- ------\n");
printf("%.1e %6.3f\n",alpha,ete);
