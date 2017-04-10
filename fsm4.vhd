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
use work.mes_constantes.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm4 is
    Port ( H            : in STD_LOGIC;
           raz          : in STD_LOGIC;
           encs         : in STD_LOGIC_VECTOR (1 downto 0);
           nb_increment : out STD_LOGIC_VECTOR (nb_bit_increment-1 downto 0);
           nb_dead      : out STD_LOGIC_VECTOR(9 downto 0)
           );
end fsm4;

architecture Behavioral of fsm4 is

    type etat is (init, oo, oi, io, ii, oop, oom, oip, oim, iip, iim, iop, iom, dead);

    signal etat_present, etat_futur : etat;
    signal cpt_incr, cpt_dead       : integer range 0 to max_increment;

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
    
    futur : process (etat_present, encs(0), encs(1))
    begin
        case etat_present is 
            when init => if    (encs="11") then etat_futur <= ii;
                         elsif (encs="01") then etat_futur <= io;
                         elsif (encs="10") then etat_futur <= oi;
                         else                   etat_futur <= oo;
                         end if;
                         
            when oo   => if    (encs="01") then etat_futur <= oop;
                         elsif (encs="10") then etat_futur <= oom;
                         elsif (encs="11") then etat_futur <= dead;
                         else etat_futur <= oo;
                         end if;

            when oop  => etat_futur <= oi;
            
            when oom  => etat_futur <= io;
            
            when oi   => if    (encs="11") then etat_futur <= oip;
                         elsif (encs="00") then etat_futur <= oim;
                         elsif (encs="10") then etat_futur <= dead;
                         else etat_futur <= oi;
                         end if;
            
            when oip  => etat_futur <= ii;
            when oim  => etat_futur <= oo;
            
            when io   => if    (encs="00") then etat_futur <= iop;
                         elsif (encs="11") then etat_futur <= iom;
                         elsif (encs="01") then etat_futur <= dead;
                         else etat_futur <= io;
                         end if;
                         
            when iop  => etat_futur <= oo;
            when iom  => etat_futur <= ii;
            
            when ii   => if    (encs="10") then etat_futur <= iip;
                         elsif (encs="01") then etat_futur <= iim;
                         elsif (encs="00") then etat_futur <= dead;
                         else etat_futur <= ii;
                         end if;
                         
            when iip  => etat_futur <= io;
            when iim  => etat_futur <= oi;
            when dead => if    (encs="11") then etat_futur <= ii;
                                     elsif (encs="01") then etat_futur <= io;
                                     elsif (encs="10") then etat_futur <= oi;
                                     else                   etat_futur <= oo;
                                     end if;
        end case;
    end process;
    
    
        direction : process (H)
        begin
            if rising_edge(H) then
                case etat_present is 
                    when init   => cpt_incr <= init_increment;
                                   cpt_dead <= 0;
                    when dead   => cpt_dead <= cpt_dead + 1;--init_increment;
                    when oop    => cpt_incr <= cpt_incr + 1;
                    when oip    => cpt_incr <= cpt_incr + 1;
                    when iop    => cpt_incr <= cpt_incr + 1;
                    when iip    => cpt_incr <= cpt_incr + 1;
                    when oom    => cpt_incr <= cpt_incr - 1;
                    when oim    => cpt_incr <= cpt_incr - 1;
                    when iom    => cpt_incr <= cpt_incr - 1;
                    when iim    => cpt_incr <= cpt_incr - 1;
                    when others => cpt_incr <= cpt_incr;
                end case;
            end if;
        end process;



--    direction : process (H, raz, etat_present, etat_futur)
--        begin
--            if rising_edge(H) then
--                if raz = '1' then
--                    cpt_incr <= init_increment;
--                else
--                    if (CE = '1') then
--                        if (etat_present = oop or etat_present = oip or etat_present = iop or etat_present = iip) then 
--                            cpt_incr <= cpt_incr + 1;
--                        elsif (etat_present = oom or etat_present = oim or etat_present = iom or etat_present = iim) then 
--                            cpt_incr <= cpt_incr - 1;
--                        end if;
--                    end if;
--                 end if; 
--            end if;
--        end process;

    nb_increment <= std_logic_vector(to_unsigned(cpt_incr, nb_bit_increment));
    nb_dead      <= std_logic_vector(to_unsigned(cpt_dead, 10));

end Behavioral;
