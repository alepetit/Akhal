clear;
close all;


s = tf('s');

Te = 0.01;
wu = 1;
Mphi = 40; %degres !

tau_e = 0.00055;
tau_m = 1.35;

G = 1/((1+tau_m*s)*(1+tau_e*s));

%*****************Synthese du correcteur :

[modGu argGu] = bode(G, wu);

bode(G);

phiM = Mphi - 180 - argGu + 11.3*2; %degres !
a = (1 + sind(phiM))/(1 - sind(phiM));
alpha = sqrt(a);
wi = wu/5;
w1 = wu/alpha;
w2 = alpha*wu;
wf = 5*wu;
K0 = 1/(alpha*modGu);
ni = 0;
N = 1;
nf = 1;

K = K0*((1+s/wi)/(s/wi))^ni*((1+s/w1)/(1+s/w2))^N*((1)/(1+s/wf))^nf;



[modG argG] = bode(G);

figure,
bode(G), title('Bode de G');

margin(K*G);

Kz = c2d(K, Te, 'zoh');



% Y(z)/X(z) = (0.0194 z^-1 - 0.03795 z^-2 +0.01855 z^-3)/(1 - 2.949 z^-1 + 2.898 z^-2 - 0.949 z^-3)

% Y(z)(1 - 2.949 z^-1 + 2.898 z^-2 - 0.949 z^-3) = X(z)(0.0194 z^-1 - 0.03795 z^-2 + 0.01855 z^-3)
% y(n) - 2.949 y(n-1) + 2.898 y(n-2) - 0.949 y(n-3) = 0.0194 x(n-1) - 0.03795 x(n-2) + 0.01855 x(n-3)
% y(n) = 0.0194 x(n-1) - 0.03795 x(n-2) + 0.01855 x(n-3) + 2.949 y(n-1) - 2.898 y(n-2) + 0.949 y(n-3)


%y(n) = 1.949y(n-1) - 0.949y(n-2) +0.01938 x(n-1) -0.01857x(n-2


