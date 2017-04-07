----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2017 11:02:57
-- Design Name: 
-- Module Name: freeze - Behavioral
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

entity freeze is
    Port ( in1 : in STD_LOGIC_VECTOR (0 downto 0);
           out1 : out STD_LOGIC_VECTOR (0 downto 0);
           H : in STD_LOGIC;
           raz : in STD_LOGIC;
           btn : in STD_LOGIC);
end freeze;

architecture Behavioral of freeze is

signal btn_temp : std_logic;
signal out_t : std_logic_vector(0 downto 0);

begin

process(H, raz, btn)
begin
if rising_edge(H) then
    if raz = '1' then
       btn_temp <= '0';
    elsif btn = '1' then
        btn_temp <= not(btn_temp);
    end if;
end if;
end process;

process(btn_temp)
begin
if btn_temp = '0' then
    out_t <= in1;
else
    out_t <= out_t;
end if;
end process;

out1 <= out_t;

end Behavioral;
