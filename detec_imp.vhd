----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2017 08:59:05
-- Design Name: 
-- Module Name: detec_imp - Behavioral
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

entity detec_imp is
    Port ( signal_enc : in STD_LOGIC;
           H : in STD_LOGIC;
           impulse : out STD_LOGIC);
end detec_imp;

architecture Behavioral of detec_imp is

signal imp1, imp2 : std_logic;        

begin

detec : process(H)
begin
    if rising_edge(H) then
        imp1 <= signal_enc;
    end if;
end process;

imp2 <= imp1 xor signal_enc;

impulse <= imp2 and signal_enc;

end Behavioral;
