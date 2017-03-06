----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2017 11:48:50
-- Design Name: 
-- Module Name: aff_compteur - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity aff_compteur is
    Port ( H : in STD_LOGIC;
           raz : in STD_LOGIC;
           sortie : out STD_LOGIC_VECTOR (31 downto 0));
end aff_compteur;

architecture Behavioral of aff_compteur is

signal cpt : integer range 0 to 99999999;

begin

process(H, raz)
begin
if rising_edge(H) then
    if raz = '1' then
        cpt <= 0;
    else 
        if cpt = 99999999 then
            cpt <= 0;
        else 
            cpt <= cpt + 1;
        end if;
    end if;
end if;
end process;

sortie <= std_logic_vector(to_unsigned(cpt, 32));

end Behavioral;
