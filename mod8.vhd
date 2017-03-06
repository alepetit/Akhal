----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2016 10:04:17
-- Design Name: 
-- Module Name: mod8 - Behavioral
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

entity mod4 is
    Port ( ce : in STD_LOGIC;
           H : in STD_LOGIC;
           raz : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           sortie : out STD_LOGIC_VECTOR (2 downto 0));
end mod4;

architecture Behavioral of mod4 is

signal cpt8 : integer range 0 to 7;

begin

un : process(ce, H)
begin
    if rising_edge(H) then
        if ce = '1' then
            if raz = '1' then
                cpt8 <= 0;
            else
                if cpt8 = 7 then
                    cpt8 <= 0;
                else 
                    cpt8 <= cpt8 + 1;
                end if;
            end if;
    end if;
end if;
end process;

deux : process(cpt8)
begin
	case cpt8 is
		when 0 =>      AN <= "11111110";
		when 1 =>      AN <= "11111101";
		when 2 =>      AN <= "11111011";
		when 3 =>      AN <= "11110111";
		when 4 =>      AN <= "11101111";
		when 5 =>      AN <= "11011111";
		when 6 =>      AN <= "10111111";
		when others => AN <= "01111111";
	end case;
end process;		

sortie <= STD_LOGIC_VECTOR(to_unsigned(cpt8,3));

end Behavioral;
