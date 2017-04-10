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
use work.mes_constantes.all;
      

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vitesse_enc is
    Port    ( H            : in STD_LOGIC;
              raz          : in STD_LOGIC;
              CE           : in STD_LOGIC;
              nb_increment : in STD_LOGIC_VECTOR  (nb_bit_increment-1 downto 0);

              diff         : out STD_LOGIC_VECTOR (nb_bit_diff-1 downto 0);
              vitesse      : out STD_LOGIC_VECTOR (nb_bit_vitesse-1 downto 0));
end vitesse_enc;

architecture Behavioral of vitesse_enc is

signal vit              : integer;
signal nb_prec, nb_incr : integer range 0 to max_increment;
signal diff1            : integer range 0 to max_diff;
signal vit_temp         : unsigned(31 downto 0);

begin

nb_incr <= to_integer(unsigned(nb_increment));

process(H)
begin
    if rising_edge(H) then
        if raz = '1' then
            nb_prec <= 0;
            vit     <= 0;
            diff1   <= 0;

        elsif CE = '1' then
            if nb_incr >= nb_prec then
                vit   <= facteur_vitesse*(nb_incr - nb_prec); -- 65536 = 2^16 + borner le calcul
                diff1 <= nb_incr - nb_prec;
            else
                vit <= facteur_vitesse*(nb_prec - nb_incr); -- 65536 = 2^16 + borner le calcul
                diff1 <= nb_prec - nb_incr;
            end if;
            nb_prec <= nb_incr;
        else
            diff1   <= diff1;
            vit     <= vit;
            nb_prec <= nb_prec;            
        end if;
    end if;
end process; 

vit_temp    <= to_unsigned(vit, 32);
vitesse     <= std_logic_vector( RESIZE( vit_temp(31 downto 16), nb_bit_vitesse) );
diff        <= std_logic_vector(to_unsigned(diff1, nb_bit_diff));

end Behavioral;
