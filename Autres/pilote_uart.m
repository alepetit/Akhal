clear all;
clc;
s = serial('COM4');
s.Baudrate=921600;
s.StopBits=1;
s.Terminator='LF';
s.Parity='none';
s.FlowControl='none';

fopen(s)

fwrite(s, 'a')

%fwrite(s, 'z')


A = zeros(50,1);

fichier = fopen('out.txt','w');

for i = 1:50
    A(i) = fread(s, 1);
    fprintf(fichier,'%i\n',A(i));
end

fclose(s);
fclose(fichier);


