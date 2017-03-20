clear all;
clc;
s = serial('COM4');
s.Baudrate=921600;
s.StopBits=1;
s.Terminator='LF';
s.Parity='none';
s.FlowControl='none';

fopen(s)
fwrite(s, 'z')
A = fread(s, 10)
fclose(s);