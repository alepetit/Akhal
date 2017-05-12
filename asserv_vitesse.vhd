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
           CE         : in STD_LOGIC;
           raz        : in STD_LOGIC;
           consigne   : in STD_LOGIC_VECTOR (7 downto 0);
           retour_enc : in STD_LOGIC_VECTOR (7 downto 0);
           vitesse    : out STD_LOGIC_VECTOR (7 downto 0));
end asserv_vitesse;

architecture Behavioral of asserv_vitesse is

signal diff1, tdiff1, diff2, diff3      : signed(8 downto 0);
signal commande1, commande2, commande3  : signed(8 downto 0);
signal tcommande1                       : signed(21 downto 0);
signal scommande2, scommande3           : signed(21 downto 0);
signal tmp_scommande2, tmp_scommande3   : signed(21 downto 0);
signal sdiff2, sdiff3                   : signed(21 downto 0);

constant c2 : signed(12 downto 0) := to_signed(3992,13);
constant c3 : signed(12 downto 0) := to_signed(1944,13);
constant d2 : signed(12 downto 0) := to_signed(40,13);
constant d3 : signed(12 downto 0) := to_signed(38,13);

begin

tmp_scommande2 <= signed( c2 * commande2 );
tmp_scommande3 <= signed( c3 * commande3 );
scommande2 <= tmp_scommande2;--( 31 downto 12 );
scommande3 <= tmp_scommande3;--( 31 downto 12 );

tdiff1 <= signed( RESIZE( unsigned(consigne), 9 ) ) - signed( RESIZE( unsigned(retour_enc), 9 ) );

sdiff2     <= signed( d2 * diff2 );
sdiff3     <= signed( d3 * diff3 );

tcommande1  <= scommande2 - scommande3 + sdiff2 - sdiff3;
commande1   <= tcommande1( 21 downto 13 );
                
    process(H)
    begin
        if rising_edge(H) then
            if raz = '1' then
                diff1     <= tdiff1;
                diff2     <= (others => '0');
                diff3     <= (others => '0');
                commande2 <= (others => '0');
                commande3 <= (others => '0');
            elsif CE = '1' then
                commande3 <= commande2;
                commande2 <= commande1;
                diff3     <= diff2;
                diff2     <= diff1;
                diff1     <= tdiff1;
            else
                commande3 <= commande3;
                commande2 <= commande2;
                diff3 <= diff3;
                diff2 <= diff2;
                diff1 <= diff1;
            end if;
        end if;
    end process;

vitesse <= std_logic_vector(commande1(7 downto 0)) when commande1(8) = '0' else "00000000";

end Behavioral;