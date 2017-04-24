clear all;
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

temps = 100;
A = zeros(temps/2,1);
B = zeros(temps/2,1);
C = zeros(temps,1);

fichier = fopen('out.txt','w');

%h = waitbar(0,'Please wait...');

A = uart_speed(s, 255, temps/2);
B = uart_speed(s, 255, temps/2);
C = vertcat(A,B);

%for i = 24:16:255
%    waitbar(i/255)
%    A = uart_speed(s, i, temps);
%    plot(A); hold on;
%end
%close(h) 

plot(C);
for i = 1:temps
    fprintf(fichier,'%i\t %f\n',i , (C(i)));
end
 
fwrite(s, 0)
 
fclose(s);
fclose(fichier);
