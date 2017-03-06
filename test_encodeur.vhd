----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2017 11:12:28
-- Design Name: 
-- Module Name: test_encodeur - Behavioral
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

entity test_encodeur is
    Generic ( 
           nb_bits_inc     : INTEGER := 32 );
    Port ( H        : in STD_LOGIC;
           raz      : in STD_LOGIC;
           encA     : in STD_LOGIC;
           encB     : in STD_LOGIC;
           nb_increment : out STD_LOGIC_VECTOR (nb_bits_inc-1 downto 0);
           led      : out STD_LOGIC_VECTOR (1 downto 0));
end test_encodeur;

architecture Behavioral of test_encodeur is

    signal increment_enc : integer;
    signal tempA,pulseA,tempB,pulseB   : std_logic;
    signal led1           : std_logic;

    attribute mark_debug : string;
    attribute keep : string;
    attribute mark_debug of encA     : signal is "true";
    attribute mark_debug of encB  : signal is "true";
    attribute mark_debug of increment_enc  : signal is "true";

begin

    aff_led : process (H)
begin
    if (rising_edge(H)) then
        if (encA = '1') then 
            led(0) <= '1';
        else 
            led(0) <= '0';
        end if;
        if (encB = '1') then
            led(1) <= '1';
        else
            led(1) <= '0';
        end if;
    end if;
end process;

    process (H)
begin
    if (rising_edge(H)) then
        tempA  <= encA;
        pulseA <= (encA xor tempA) and encA;
    end if;
end process;

    process (H)
    begin
        if (rising_edge(H)) then
            tempB  <= encB;
            pulseB <= (encB xor tempB) and encB;
        end if;
    end process;
    
    
--    tempB <= encB when (rising_edge(H));
--    pulseB <= not encB and tempB;
    
    calcul_vitesse : process(H)
    begin
        if rising_edge(H) then
            if raz = '1' then
                increment_enc <= 0;
            elsif pulseA = '1' then
                increment_enc <= increment_enc + 1;
            else 
                 increment_enc <= increment_enc;
           end if;
        end if;
    end process;
    
    nb_increment <= std_logic_vector(to_unsigned(increment_enc,32));

end Behavioral;
