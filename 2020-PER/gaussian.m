function [errY] = gaussian(X,xl,Y,yl,alphas)

classes=unique(xl);
N=rows(X);
M=rows(Y);
D=columns(X);

for c=classes'
  ic=find(c==classes);
  idx=find(xl==c);
  Xc=X(idx,:);
  Nc=rows(Xc);
  pc(ic)=Nc/N;
  muc=sum(Xc)/Nc;
  mu(:,ic)=muc';
  sigma{ic}=((Xc-muc)'*(Xc-muc))/Nc;
end

for i=1:length(alphas)


  for c=classes'
    ic=find(c==classes);
    ssigma{ic}=alphas(i)*sigma{ic}+(1-alphas(i))*eye(D);
  end


  for c=classes'
    ic=find(c==classes);
    gY(:,ic)=log(pc(ic))+gc(mu(:,ic),ssigma{ic},Y);
  end

  [~,idY]=max(gY');
  errY(i)=mean(classes(idY)!=yl)*100;
end

end

function [clas] = gc(mu,sigma,X)
  wc=-0.5*sum((X*pinv(sigma)).*X,2);
  wc=wc+X*(mu'*pinv(sigma))';
  wc0=-0.5*logdet(sigma);
  wc0=wc0-0.5*mu'*pinv(sigma)*mu;
  clas=wc+wc0;
end

function v = logdet(X)
  lambda = eig(X);
  if any(lambda<=0)
    v=log(realmin);
  else
    v=sum(log(lambda));
  end
end