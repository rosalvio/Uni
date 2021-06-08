% Cada dato es una fila, cada label tambien
% Para el examen test [] [] epsilon 0 excepto en el apartado que lo pide
function [wc0, wc, classes, res]=mexamen(Xtr, xltr, epsilons, y)
edv = [];
wc=[];
wc0=[];
pred=[];
classes=unique(xltr);
N=rows(Xtr);
pri=[];
post=[];
for e=1:columns(epsilons)
	for c=1:rows(classes)
		i=find(xltr==classes(c));
		NC=rows(i);
		pri=[pri;NC/N];
		
		xn=sum(Xtr(i,:));
		xnd=sum(sum(Xtr(i,:)));
		auxpost=xn/xnd;
    
		
		
		if(epsilons(e) !=0)
      % Suavizazdo de Laplace
			% wc=[wc;log((auxpost+epsilons(e))/(sum(auxpost+epsilons(e))))];
			% wc0=[wc0;log(pri(c))];
      %Suavizado descuento absoluto
      Pg = [];
      wc = [wc;(auxpost)/(sum(auxpost))];
      wc0 = [wc0; pri(c)];
      for i=1:columns(Xtr)
        Pg = [Pg sum(Xtr(:,i))/sum(sum(Xtr))];
      endfor
      Pg
      for i=1:rows(wc)
        Pc = wc(i, :);
        aux = ones(1, columns(Pc))*epsilons(e);
        w2c(i,:) = Pc - aux + sum(aux)*Pg;
        w2c
      endfor
      w2c
		else
      wc = [wc;(auxpost)/(sum(auxpost))];
      wc0 = [wc0; pri(c)];
    endif
	endfor

	%[_,pred]=max(Xdv*wc'+wc0',[],2)
	%errors=sum((pred-1) != xldv)
	%err=(errors/rows(xldv))*100
	%edv=[edv;err]
	%printf("%3d %6.3f\n", epsilons(e), err);
endfor

classes = [];

for i=1:length(i)
  classes(i) = pri(i,:);
  for j=1:length(wc)
    classes(i) = classes(i) * wc(i,j) ** y(j);
  endfor
endfor
  [_ res] = max(classes); 
endfunction
