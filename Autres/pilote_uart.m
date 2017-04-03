clear all;
clc;
s = serial('COM4');
s.Baudrate=921600;
s.StopBits=1;
s.Terminator='LF';
s.Parity='none';
s.FlowControl='none';
s.TimeOut = 60;
s.InputBufferSize = 512*2;
fopen(s);

temps = 100;
A = zeros(temps,1);
B = zeros(temps,1);
C = zeros(temps,1);
D = zeros(temps,1);
E = zeros(temps,1);




%fichier = fopen('out.txt','w');
hold off;
h = waitbar(0,'Please wait...');

for i = 24:16:255
    waitbar(i/255)
    A = uart_speed(s, 255, temps);
    plot(A); hold on;
end
close(h) 

% fwrite(s, 200);
% B = fread(s, temps);
% fwrite(s, 150);
% C = fread(s, temps);
% fwrite(s, 100);
% D = fread(s, temps);
% fwrite(s, 50);
% E = fread(s, temps);

% for i = 5:temps-1
%     if A(i)<100  %suppression des pics à zéros
%         A(i) = A(i-1);
%     end
% end
%plot(A);
%for i = 1:temps
%     fprintf(fichier,'%i\t %f\n',i , (A(i)));
% end
% 
fwrite(s, 0)
% 
fclose(s);
% fclose(fichier);
% 
% scale = 2;
% for i = 1:temps/scale
%     %B(i) = sum(A(scale*(i-1)+1 : scale*i));
% end

