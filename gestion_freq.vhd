----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.09.2016 10:30:23
-- Design Name: 
-- Module Name: gestion_freq - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_freq is
    Port ( H             : in STD_LOGIC;
           raz           : in STD_LOGIC;
           CE1           : out STD_LOGIC;
           CE2           : out STD_LOGIC);
end gestion_freq;

architecture Behavioral of gestion_freq is

signal compt1 : natural range 1 to 2000000;
signal compt2 : natural range 1 to 33334;

begin
    CE : process(H)
    begin
        if (rising_edge(H)) then
            if (raz = '1') then
                compt1 <= 1;
            else
                if (compt1 = 2000000) then
                    compt1 <= 1;
                    CE1 <= '1';
                else
                    compt1 <= compt1 + 1;
                    CE1 <= '0';
                end if;
            end if;
        end if;     
    end process;
    
    CE_bis : process(H)
    begin
        if (rising_edge(H)) then
            if (raz = '1') then
                compt2 <= 1;
            else            
                if (compt2 = 33334) then
                    compt2 <= 1;
                    CE2 <= '1';
                else
                    CE2 <= '0';
                    compt2 <= compt2 + 1;
                end if;
            end if;
        end if;     
    end process;
    
end Behavioral;
