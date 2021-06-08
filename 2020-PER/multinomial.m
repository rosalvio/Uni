function [edv]=multinomial(Xtr, xltr, Xdv, xldv, epsilons)
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
		
		% Suavizazdo de Laplace
		if(epsilons(e) !=0)
			wc=[wc;log((auxpost+epsilons(e))/(sum(auxpost+epsilons(e))))];
			wc0=[wc0;log(pri(c))];
		endif
	endfor

	[_,pred]=max(Xdv*wc'+wc0',[],2);
	errors=sum((pred-1) != xldv);
	err=(errors/rows(xldv))*100;
	edv=[edv;err];
	printf("%3d %6.3f\n", epsilons(e), err);
endfor
endfunction
