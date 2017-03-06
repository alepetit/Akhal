----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2017 08:56:45
-- Design Name: 
-- Module Name: enc_sur_led - Behavioral
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

entity enc_sur_led is
    Port ( H : in STD_LOGIC;
           raz : in STD_LOGIC;
           encA : in STD_LOGIC;
           encB : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (1 downto 0));
end enc_sur_led;

architecture Behavioral of enc_sur_led is

begin

aff_led : process (H, raz)
begin
    if raz = '1' then
        led <= "00";
    else
        if (rising_edge(H)) then
            if (encA = '1') then 
                led(0) <= '1';
            else 
                led(0) <= '0';
            end if;
            if (encB = '1') then
                led(1) <= '1';
            else
                led(1) <= '0';
            end if;
        end if;
    end if;
end process;

end Behavioral;
