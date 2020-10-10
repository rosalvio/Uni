% Caso 1
muA=[3;0];sigmaA=[1 0; 0 1];muB=[0; 3]; sigmaB=[1 0; 0 1];
XA=genGauss_sampler(1000,muA',sigmaA);
XB=genGauss_sampler(1000,muB',sigmaB);
F=[[-4:8]' [-4:8]'];
plot(XA(:,1),XA(:,2),"+k",XB(:,1),XB(:,2),"xb",F(:,1),F(:,2),"-r");

% Caso 2
muA=[2;7];sigmaA=[1 1; 1 2];muB=[4; 9]; sigmaB=[1 1; 1 2];
XA=genGauss_sampler(1000,muA',sigmaA);
XB=genGauss_sampler(1000,muB',sigmaB);
F=[3*ones(1,length([3:13]))' [3:13]'];
plot(XA(:,1),XA(:,2),"+k",XB(:,1),XB(:,2),"xb",F(:,1),F(:,2),"-r"); axis([-3 9 3 13]);

% Caso 3
muA=[0;0];sigmaA=[1 2; 2 5];muB=[0; 4]; sigmaB=[1 2; 2 5];
XA=genGauss_sampler(1000,muA',sigmaA);
XB=genGauss_sampler(1000,muB',sigmaB);
F=[[-4:4]' 2*[-4:4]'+2];
plot(XA(:,1),XA(:,2),"+k",XB(:,1),XB(:,2),"xb",F(:,1),F(:,2),"-r"); axis([-8 8 -6 10]);

% Caso 4
muA=[0;0];sigmaA=[1/8 0; 0 1/4];muB=[0; 2]; sigmaB=[1/4 0; 0 1/2];
XA=genGauss_sampler(1000,muA',sigmaA);
XB=genGauss_sampler(1000,muB',sigmaB);
cx=0; cy=-2;
rx = sqrt(4+.5*log(2)); ry = sqrt(8+log(2));
theta = linspace (0, 2*pi, 1000);
Fx = cx + rx * cos (theta);
Fy = cy + ry * sin (theta);
plot(XA(:,1),XA(:,2),"+k",XB(:,1),XB(:,2),"xb",Fx,Fy,"-r");axis([-3 3 -5 5]);

% Caso 5
muA=[0;0];sigmaA=[1/2 0; 0 1/8];muB=[0; 2]; sigmaB=[1/4 0; 0 1/2];
XA=genGauss_sampler(1000,muA',sigmaA);
XB=genGauss_sampler(1000,muB',sigmaB);
cx=0; cy=-2.0/3.0;
rx=sqrt(16.0/3.0+.5*log(2)); ry=sqrt(16.0/9.0+log(2)/6.0);
theta = linspace (-2*pi, 2*pi, 1000);
Fx = cx + rx * sinh (theta);
Fy1 = cy + ry * cosh (theta);
Fy2 = cy - ry * cosh (theta);
plot(XA(:,1),XA(:,2),"+k",XB(:,1),XB(:,2),"xb",Fx,Fy1,"-r",Fx,Fy2,"-r");axis([-3 3 -4 4]);

% Caso 6
muA=[0;0];sigmaA=[1/8 0; 0 1/2];muB=[0; 2]; sigmaB=[1/4 0; 0 1/2];
XA=genGauss_sampler(1000,muA',sigmaA);
XB=genGauss_sampler(1000,muB',sigmaB);
F=[[-3:0.1:3]' -0.5*[-3:0.1:3]'.^2+1/8*log(2)+1];
plot(XA(:,1),XA(:,2),"+k",XB(:,1),XB(:,2),"xb",F(:,1),F(:,2),"-r");axis([-3 3 -2 4])

% Caso 7
muA=[0;0];sigmaA=[1/4 0; 0 1/4];muB=[0; 2]; sigmaB=[1/4 0; 0 1/2];
XA=genGauss_sampler(1000,muA',sigmaA);
XB=genGauss_sampler(1000,muB',sigmaB);
F1=[[-3:3]' 0.89*ones(length([-3:3]))'];
F2=[[-3:3]' -4.89*ones(length([-3:3]))'];
plot(XA(:,1),XA(:,2),"+k",XB(:,1),XB(:,2),"xb",F1(:,1),F1(:,2),"-r",F2(:,1),F2(:,2),"-r");axis([-3 3 -2 4])
