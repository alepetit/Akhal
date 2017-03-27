----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.03.2017 10:34:18
-- Design Name: 
-- Module Name: gen_pwm - Behavioral
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

entity gen_pwm is
    Port ( H : in STD_LOGIC;
           raz : in STD_LOGIC;
           commande : in STD_LOGIC_VECTOR (7 downto 0);
           pwm : out STD_LOGIC);
end gen_pwm;

architecture Behavioral of gen_pwm is

signal s : std_logic;

signal cpt : integer;
signal alpha : integer;

begin

alpha <= to_integer(unsigned(commande));

process (H, raz)
begin
    if rising_edge(H) then
        if raz = '1' then
            cpt <= 0;
        else
            if cpt = 255 then
                cpt <= 0;
            else cpt <= cpt + 1;
            end if;
        end if;
    end if;
end process;

process (H, cpt)
begin
    if rising_edge(H) then
        if raz = '1' then s <= '0';
        else
            if cpt <= alpha then
                s <= '1';
            else s <= '0';
            end if;
        end if;
    end if;
end process;

pwm <= s;

end Behavioral;
