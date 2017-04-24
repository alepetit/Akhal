clear;
close all;


%s = tf('s');


wu = 18180;
Mphi = 50; %degres !

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
ni = 1;
N = 1;
nf = 1;

K = K0*((1+s/wi)/(s/wi))^ni*((1+s/w1)/(1+s/w2))^N*((1)/(1+s/wf))^nf;



[modG argG] = bode(G);

figure,
bode(G), title('Bode de G');

margin(K*G);

Kt = impulse(K);
figure, plot(Kt);


