clear;
clc;
s = serial('COM8');
fclose(s);
s.Baudrate=921600;
s.StopBits=1;
s.Terminator='LF';
s.Parity='none';
s.FlowControl='none';
s.TimeOut = 60;
s.InputBufferSize = 512*2;
fopen(s);


consigne = 255;
vit_reel = 0;
i = 1;

diff = zeros (4,1);
commande = zeros (4,1);

% y(n) = 0.0194 x(n-1) - 0.03795 x(n-2) + 0.01855 x(n-3) + 2.949 y(n-1) - 2.898 y(n-2) + 0.949 y(n-3)
while i<5
    diff(1) = consigne - vit_reel
    %commande(1) = 0.0194 * diff(2) - 0.03795 * diff(3) + 0.01855 * diff(4) + 2.949 * commande(2) - 2.898 * commande(3) + 0.949 * commande(4);
    %commande(1) = 1.949 *commande(2) - 0.949*commande(3) +0.01938*diff(2) -0.01857*diff(3);
    temp = (3992*commande(2) - 1944*commande(3) + 40*diff(2) - 38*diff(3));
    commande(1) = temp/2048
    %if commande(1) > 255
     %   commande(1) = 255;
    %elseif commande(1) < 0
    %    commande(1) = 0;
    %end
    %commande(1)
    vit_reel = uart_speed(s, commande(1), 1);

    commande = circshift(commande,1);
    diff = circshift(diff,1);
    i = i+1;
end


fwrite(s, 0);


fclose(s);



