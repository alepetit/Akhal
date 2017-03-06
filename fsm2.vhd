----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2017 15:19:33
-- Design Name: 
-- Module Name: fsm_enc - Behavioral
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

entity fsm2 is
    Port ( H : in STD_LOGIC;
           raz : in STD_LOGIC;
           encA : in STD_LOGIC;
           encB : in STD_LOGIC;
           nb_increment : out STD_LOGIC_VECTOR (31 downto 0);
           sens : out STD_LOGIC
           );
end fsm2;

architecture Behavioral of fsm2 is

    type etat is (init, oo, oi, io, ii);

    signal etat_present, etat_futur : etat;
    signal cpt_incr : integer range 0 to 99999999;
    signal etat_courant : integer range 0 to 3;

    signal valid : std_logic_vector (3 downto 0);
    

    
begin

    synchrone : process (H)
    begin
        if rising_edge(H) then
            if raz = '1' then etat_present <= init;
            else
                etat_present <= etat_futur;
            end if;
        end if;
    end process;
    
    futur : process (etat_present, valid, etat_courant, encA, encB)
    begin
        case etat_present is 
            when init => if (encA='1' and encB='1') then etat_futur <= ii;
                         elsif (encA='1' and encB='0') then etat_futur <= io;
                         elsif (encA='0' and encB='1') then etat_futur <= oi;
                         else etat_futur <= oo;
                         end if;
            when oo   => if (encA='1' and encB='0') then etat_futur <= io;
                         elsif (encA='0' and encB='1') then etat_futur <= oi;
                         else etat_futur <= oo;
                         end if;
            when oi   => if (encA='1' and encB='1') then etat_futur <= ii;
                         elsif (encA = '0' and encB = '0') then etat_futur <= oo;
                         else etat_futur <= oi;
                         end if;
            when io   => if (encA='1' and encB='1') then etat_futur <= ii;
                         elsif (encA = '0' and encB = '0') then etat_futur <= oo;
                         else etat_futur <= io;
                         end if;
            when ii   => if (encA='1' and encB='0') then etat_futur <= io;
                         elsif (encA = '0' and encB = '1') then etat_futur <= oi;
                         else etat_futur <= ii;
                         end if;
        end case;
    end process;
    
--    sortie : process (H)
--    begin
--        if rising_edge(H) then
--            nb_increment <= std_logic_vector(to_unsigned(cpt_incr, 32));
--        end if;
--    end process;
    
    
    courant : process (etat_present, H)
    begin
    if rising_edge(H) then
        case etat_present is
            when init => valid <= "0000";
                         etat_courant <= 0;
            when oo   => etat_courant <= 0;
                         if valid = "1111" then
                            valid <= "0000";
                         else
                            valid(0) <= '1';
                         end if;
            when oi   => etat_courant <= 1;
                         if valid = "1111" then
                            valid <= "0000";
                         else
                            valid(1) <= '1';
                         end if;
            when io   => etat_courant <= 2;
                         if valid = "1111" then
                             valid <= "0000";
                         else
                             valid(2) <= '1';
                         end if;
            when ii   => etat_courant <= 3;
                         if valid = "1111" then
                             valid <= "0000";
                         else
                            valid(3) <= '1';
                         end if;
        end case;
    end if;
    end process;
    
    direction : process (H, raz, etat_present, etat_futur)
        begin
            if rising_edge(H) then
                if raz = '1' then
                    sens <= '1';
                elsif (etat_present = oo and etat_futur = io) then 
                    sens <= '1';
                elsif (etat_present = oi and etat_futur = ii) then 
                    sens <= '0';
                end if;
            end if;
        end process;
    
    courant2 : process(H, raz, valid)
    begin
        if rising_edge(H) then
            if raz = '1' then
                cpt_incr <= 0;
            elsif valid = "1111" then
                cpt_incr <= cpt_incr + 1;
            end if;
        end if;
    end process;

    

--    process (H, etat_present, etat_futur)
--    begin
--        if rising_edge(H) then
--            if (etat_present = oo and etat_futur = io) then sens <= '1';
--            elsif (etat_present = oi and etat_futur = ii) then sens <= '0';
--            end if;
--        end if;
--    end process;

    nb_increment <= std_logic_vector(to_unsigned(cpt_incr, 32));



end Behavioral;
