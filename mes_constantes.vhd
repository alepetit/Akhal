-------------------------------------------------------
-- Design Name : User Pakage
-- File Name   : mes_constantes.vhd
-- Function    : Defines function for LFSR
-- Coder       : Alexander H Pham (VHDL)
-------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use IEEE.NUMERIC_STD.ALL;    
    
package mes_constantes is


    
    constant max_diff        : integer := 65535;
    constant max_increment   : integer := 1086912;
    constant init_increment  : integer := 543456;
    constant freq_fpga       : integer := 100000000;
    
    constant hertz_enc : integer := 100;
    constant timer_enc : integer := freq_fpga/hertz_enc;

    constant hertz_aff : integer := 3000;
    constant timer_aff : integer := freq_fpga/hertz_aff;

    constant hertz_filtre : integer := 7000;
    constant timer_filtre : integer := freq_fpga/hertz_filtre;
    
    constant hertz_fsm : integer := 100000;
    constant timer_fsm : integer := freq_fpga/hertz_fsm;
    
    constant nb_bit_vitesse   : integer := 9;
    constant nb_bit_increment : integer := 21;
    constant nb_bit_diff      : integer := 16;
    
    constant nb_tic_par_tour : integer := 979;
    constant deuxp16          : integer := 65536;
    constant facteur_vitesse  : integer := (60*deuxp16*hertz_enc)/nb_tic_par_tour;
    
end;



package body mes_constantes is
end package body;
