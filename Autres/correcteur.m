clear;
close all;


s = tf('s');

wu = 689;
Mphi = 40; %degres !

tau_e = 0.00175;
tau_m = 0.7;

G = 1/((1+tau_m*s)*(1+tau_e*s));

%*****************Synthese du correcteur :

[modGu argGu] = bode(G, wu);

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

%****************Calcul des reponses indicielles et frequentielles de G et P :

[modG argG] = bode(G);

figure,
bode(G), title('Bode de G');

%[yG tG] = step(G);
%[yP tP] = step(P);

% figure,
% subplot(211), step(G), title('Réponse indicielle de G');
% subplot(212), step(P), title('Réponse indicielle de P');

margin(K*G);

%***************Recherche iterative de wu :

% H = P/(1+G*K);
% %step(H);
% 
% L = -K/(1+K*G);
% [modL50 argL50] = bode(L, 50*2*pi);
% 
% %********************* Recherche de ze et we pour la fonction T* :
% 
% we = 17.5;
% ze = 0.37;
% Te = 1/((s/we)^2+2*ze*s/we+1);
% 
% Tr = K*G/(1+K*G);
% 
% %figure, bode(Te,logspace(0,1.5,100)), hold on, bode(Tr,logspace(0,1.5,100)),legend('Te','Tr');
% %figure, step(Te), hold on, step(Tr),legend('Te','Tr');
% 
% %****************Recherche de wt et zt :
% 
% wt = 12;
% zt = 0.5;
% T = 1/((s/wt)^2+2*zt*s/wt+1);
% 
% F = T/Te;
% 
% Main = K*F/(1+K*G);
% 
% figure, subplot(121), step(Main),grid;
% subplot(122), step(F),grid;
