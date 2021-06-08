#!/usr/bin/octave -qf
# Usage: kGrammFunc.m <func> <x> <y>

% function [res] = kGrammFunc(x, y)


% aux = strrep(func, 'x1', '(x1)');
% aux = strrep(func, 'x1', x);
% aux = strrep(aux, 'y1', '(y1)');
% aux = strrep(aux, 'y1', y);
% aux
% res = str2num(aux);
% res;
% end

function [res] = kGrammFunc(x, y)

% Introducir funcion
% func = (x'*y)/(norm(x)*norm(y))
func = (x'*y)/(norm(x)*norm(y)) % Funcion de ejemplo

end