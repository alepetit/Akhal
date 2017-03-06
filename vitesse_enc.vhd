----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2017 11:49:20
-- Design Name: 
-- Module Name: vitesse_enc - Behavioral
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

entity vitesse_enc is
    Generic ( 
           nb_bits_inc     : INTEGER := 32 );
    Port    ( H            : in STD_LOGIC;
              raz          : in STD_LOGIC;
              CE           : in STD_LOGIC;
              nb_increment : in STD_LOGIC_VECTOR (nb_bits_inc-1 downto 0);
              diff         : out std_logic_vector(31 downto 0);
              sens         : in STD_LOGIC;
              vitesse      : out STD_LOGIC_VECTOR (31 downto 0));
end vitesse_enc;

architecture Behavioral of vitesse_enc is

signal vit, nb_prec, nb_incr, diff1 : integer; -- checker l'overflow
signal toto : unsigned(31 downto 0);

begin

nb_incr <= to_integer(unsigned(nb_increment));

process(CE, H)
begin
    if rising_edge(H) then
        if raz = '1' then
            nb_prec <= 0;
            vit <= 0;
        elsif CE = '1' then
            vit <= 24000*(nb_incr - nb_prec); -- 65536 = 2^16 + borner le calcul
            diff1 <= nb_incr - nb_prec;
            nb_prec <= to_integer(unsigned(nb_increment));
        else
            vit <= vit;
            nb_prec <= nb_prec;            
        end if;
    end if;
end process; 

toto <= to_unsigned(vit, 32);
vitesse <= std_logic_vector( RESIZE( toto(31 downto 16), 32) );
diff <= std_logic_vector(to_unsigned(diff1, 32));

end Behavioral;
