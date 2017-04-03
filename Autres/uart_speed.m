function [ A ] = uart_speed( s, c, temps )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    fwrite(s, c);
    A = fread(s, temps, 'uint8');


end

