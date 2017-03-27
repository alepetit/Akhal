clear all;
clc;
s = serial('COM4');
s.Baudrate=921600;
s.StopBits=1;
s.Terminator='LF';
s.Parity='none';
s.FlowControl='none';
s.TimeOut = 60;
fopen(s);

temps = 500;
fwrite(s, 180)


A = zeros(temps,1);

fichier = fopen('out.txt','w');

A = fread(s, temps);

%A = A .* 2;

plot(A);
for i = 1:temps
%    A(i) = fread(s, 1);
    fprintf(fichier,'%i\t %f\n',i , (A(i)));
end

fwrite(s, 0)

fclose(s);
fclose(fichier);

scale = 2;
for i = 1:temps/scale
    B(i) = sum(A(scale*(i-1)+1 : scale*i));
end

