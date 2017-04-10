
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2017 08:52:05
-- Design Name: 
-- Module Name: multiplex - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.mes_constantes.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplex is
    Port ( vitesse  : in STD_LOGIC_VECTOR(nb_bit_vitesse-1 downto 0);
           nb_inc   : in STD_LOGIC_VECTOR(nb_bit_increment-1 downto 0);
           diff_inc : in STD_LOGIC_VECTOR(nb_bit_diff-1 downto 0);
           switch1  : in STD_LOGIC;
           switch2  : in STD_LOGIC;
           nb_dead  : in STD_LOGIC_VECTOR(9 downto 0);
           sortie   : out STD_LOGIC_VECTOR(nb_bit_increment-1 downto 0)
           );
end multiplex;

architecture Behavioral of multiplex is

begin

process(switch1, switch2, nb_inc, vitesse, diff_inc)
begin
    if (switch1 = '0' and switch2 = '0') then
        sortie <= std_logic_vector ( RESIZE (unsigned(vitesse), nb_bit_increment));
    elsif (switch1 = '1' and switch2 = '0') then
        sortie <= std_logic_vector ( RESIZE (unsigned(nb_inc), nb_bit_increment));
    elsif (switch1 = '0' and switch2 = '1') then
        sortie <= std_logic_vector ( RESIZE (unsigned(nb_dead), nb_bit_increment));        
    else 
        sortie <= std_logic_vector ( RESIZE (unsigned(diff_inc), nb_bit_increment));
    end if;
end process;


end Behavioral;