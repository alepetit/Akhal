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

    constant nb_tic_par_tour : integer := 979;
    constant facteur_vitesse : integer := 0;
    
    constant max_diff        : integer := 6040;
    constant max_increment   : integer := 1086912;
    constant init_increment  : integer := 543456;
    constant freq_fpga       : integer := 100000000;
    
    constant hertz_enc : integer := 100;
    constant timer_enc : integer := freq_fpga/hertz_enc;
    constant hertz_aff : integer := 3000;
    constant timer_aff : integer := freq_fpga/hertz_aff;
    constant hertz_fsm : integer := 13000;
    constant timer_fsm : integer := freq_fpga/hertz_aff;
    
    constant nb_bit_vitesse   : integer := 9;
    constant nb_bit_increment : integer := 21;
    constant nb_bit_diff      : integer := 13;
    
end;



package body mes_constantes is
end package body;
