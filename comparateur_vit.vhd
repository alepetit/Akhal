----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2017 09:02:03
-- Design Name: 
-- Module Name: comparateur_vit - Behavioral
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

entity comparateur_vit is
    Port ( raz : in STD_LOGIC;
           in1 : in STD_LOGIC_VECTOR (8 downto 0);
           in2 : in STD_LOGIC_VECTOR (8 downto 0);
           out_comp : out STD_LOGIC_VECTOR (8 downto 0));
end comparateur_vit;

architecture Behavioral of comparateur_vit is

signal s1,s2 : signed (8 downto 0);

begin

    out_comp <= std_logic_vector(s1-s2);

end Behavioral;
