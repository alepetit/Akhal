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

temps = 200;
%A = zeros(temps/2,1);
%B = zeros(temps/2,1);
%C = zeros(temps,1);

%fichier = fopen('out.txt','w');

A = uart_speed(s, 255, temps);
%B = uart_speed(s, 255, temps/2);
%C = vertcat(A,B);

%h = waitbar(0,'Please wait...');
%for i = 0:16:255
%    waitbar(i/255)
%    A = uart_speed(s, i, temps);
%    plot(A); hold on;
%end
%close(h) 


plot(A);
%for i = 1:temps
%    fprintf(fichier,'%i\t %f\n',i , (C(i)));
%end
 
fwrite(s, 0)
 
fclose(s);
%fclose(fichier);
