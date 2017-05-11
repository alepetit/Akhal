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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity asserv_vitesse is
    Port ( H          : in STD_LOGIC;
           raz        : in STD_LOGIC;
           consigne   : in STD_LOGIC_VECTOR (7 downto 0);
           retour_enc : in STD_LOGIC_VECTOR (7 downto 0);
           vitesse    : out STD_LOGIC_VECTOR (7 downto 0));
end asserv_vitesse;

architecture Behavioral of asserv_vitesse is

signal diff1, diff2, diff3      : unsigned (7 downto 0);
signal commande2, commande3     : unsigned (7 downto 0);
signal commande1                : unsigned (19 downto 0);


begin

    process(H)
    begin
        if rising_edge(H) then
            if raz = '1' then
                diff1 <= unsigned(consigne) - unsigned(retour_enc);
                diff2 <= (others => '0');
                diff3 <= (others => '0');
                commande1 <= RESIZE(unsigned(consigne),20);
                commande2 <= (others => '0');
                commande3 <= (others => '0');
             else
                 commande1 <= resize((3992*commande2 - 1944*commande3 + 40*diff2 - 38*diff3),20); --1.949*commande2 - 0.949*commande3 + 0.01938*diff2 - 0.01857*diff3;
                 commande3 <= commande2;
                 commande2 <= RESIZE( commande1(18 downto 11), 8);
                 diff3 <= diff2;
                 diff2 <= diff1;
             end if;
          end if;
                
                
    end process;
    
vitesse <= std_logic_vector( RESIZE( commande1(18 downto 11), 8) );

end Behavioral;
