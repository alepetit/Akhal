----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2017 08:58:31
-- Design Name: 
-- Module Name: asserv_vitesse - Behavioral
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

entity asserv_vitesse is
    Port ( H : in STD_LOGIC;
           raz : in STD_LOGIC;
           commande : in STD_LOGIC_VECTOR (5 downto 0);
           retour_enc : in STD_LOGIC_VECTOR (5 downto 0);
           vitesse : out STD_LOGIC_VECTOR (5 downto 0));
end asserv_vitesse;

architecture Behavioral of asserv_vitesse is

begin


end Behavioral;
