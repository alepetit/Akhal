----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2017 08:31:00
-- Design Name: 
-- Module Name: affichage - Behavioral
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

entity affichage is
    Port ( H : in STD_LOGIC;
           raz : in STD_LOGIC;
           CE : in STD_LOGIC;
           nb_in : in STD_LOGIC_VECTOR(26 downto 0);
           sept_seg : out STD_LOGIC_VECTOR(6 downto 0);
           an : out STD_LOGIC_VECTOR(7 downto 0)
           );
end affichage;

architecture Behavioral of affichage is

signal decomp : STD_LOGIC_VECTOR(31 downto 0);
signal S1, S2, S3, S4, S5, S6, S7, S8 : STD_LOGIC_VECTOR(6 downto 0);
signal commande : STD_LOGIC_VECTOR(2 downto 0);

begin

transc : entity work.transcodeur port map (nb_in => nb_in,
	                                       nb_out => decomp
	                                       );

decomposition : entity work.transcod2 port map (vect_hls => decomp,
                                                S1 => S1,
                                                S2 => S2,
                                                S3 => S3,
                                                S4 => S4,
                                                S5 => S5,
                                                S6 => S6,
                                                S7 => S7,
                                                S8 => S8
                                                );
mux : entity work.mux8 port map(commande => commande,
                                E0 => S1,
                                E1 => S2,
                                E2 => S3,
                                E3 => S4,
                                E4 => S5,
                                E5 => S6,
                                E6 => S7,
                                E7 => S8,
                                S => sept_seg
                                );
                                
mod8 : entity work.mod4 port map(ce => CE,
                                H => H,
                                raz => raz,
                                AN => an,
                                sortie => commande
                                );

end Behavioral;
