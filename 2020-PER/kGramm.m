#!/usr/bin/octave -qf
# octave kGramm.m "exp(-(x1-y1)'*(x1-y1))" [[1;0] [1;1] [-1; 0] [0;0]]
if(nargin!=2)
    printf('Usage: kGramm.m <K> <X>\n');
    printf('K format (entre comillas): comilla simple=turn x=x1 y=y1\n');
    printf('X format: "[[x1; y1], ..., [xn; yn]]"\n');
    exit(1);
endif
arglist = argv();
K = arglist{1};
X = str2num(arglist{2});
Kmat = [];

for i=1:length(X)
    for j=1:length(X)
        
        % aux(:,i)
        % aux(:,j)
        Kmat(i, j) = kGrammFunc(num2str(X(:,i)), num2str(X(:,j)));
    endfor
endfor

Kmat

