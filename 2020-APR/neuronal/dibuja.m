filename = "datos.out"
[nH, D, epochs, err] = textread(filename, "%f %f %f %f");
plot(nH(D==1), err(D==1),";D=1;",
nH(D==2), err(D==2), ";D=2;" ,
nH(D==5), err(D==5), ";D=5;", 
nH(D==10), err(D==10),";D=10;", 
nH(D==20), err(D==20),";D=20;",
nH(D==30), err(D==30),";D=30;");