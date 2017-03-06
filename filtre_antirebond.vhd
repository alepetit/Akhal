----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    00:53:34 09/28/2009
-- Design Name:
-- Module Name:    leds - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity rotation_led is
  port (rotation : in  std_logic_vector(1 downto 0);
              poussoir : in  std_logic;
              H        : in  std_logic;
              reset    : in  std_logic;
              led      : out std_logic_vector(31 downto 0));
end entity rotation_led;

architecture deux_process of rotation_led is

type etats is (initial, detect_sens, horaire, anti_horaire, increment, decrement, attente_horaire, attente_anti_horaire);
signal etat      : etats;
signal pas       : std_logic_vector(31 downto 0);

begin

calcul_etat : process(H)
begin
        if (H'event and H='1') then
                if reset='1' then
                        etat<=initial;
                else
                        case etat is
                                when initial =>
                                                if rotation = "00" then
                                                        etat<=detect_sens;
                                                else
                                                        etat<=initial;
                                                end if;

                                when detect_sens =>
                                                case rotation is
                                                        when "00"   => etat <= detect_sens;
                                                        when "01"   => etat <= horaire;
                                                        when "10"   => etat <= anti_horaire;
                                                        when "11"   => etat <= detect_sens;
                                                        when others => etat <= initial;
                                                end case;

                                when horaire =>                    case rotation is
                                                        when "00" => etat<=detect_sens;
                                                        when "01" => etat<=horaire;
                                                        when "10" => etat<=detect_sens;
                                                        when "11" => etat<=increment;
                                                        when others => etat<= initial;
                                                     end case;

                                when anti_horaire => case rotation is
                                                        when "00" => etat<=detect_sens;
                                                        when "01" => etat<=detect_sens;
                                                        when "10" => etat<=anti_horaire;
                                                        when "11" => etat<=decrement;
                                                        when others => etat<= initial;
                                                     end case;

                                when increment => etat<=attente_horaire;

                                when decrement => etat<=attente_anti_horaire;

                                when attente_horaire =>                            case rotation is
                                                                when "00" => etat<=detect_sens;
                                                                when "01" => etat<=anti_horaire;
                                                                when "10" => etat<=attente_horaire;
                                                                when "11" => etat<=attente_horaire;
                                                                when others => etat<= initial;
                                                             end case;

                                when attente_anti_horaire => case rotation is
                                                                when "00" => etat<=detect_sens;
                                                                when "01" => etat<=attente_anti_horaire;
                                                                when "10" => etat<=horaire;
                                                                when "11" => etat<=attente_anti_horaire;
                                                                when others => etat<= initial;
                                                             end case;
                        end case;
                end if;
        end if;
end process calcul_etat;



calcul_pas : process(H)
begin
if (H'event and H ='1') then
                case etat is
                        when initial =>   pas <= (others => '0'); -- valeur d'initialisation par défaut
                        when increment => pas <= pas + 1;
                        when decrement => pas <= pas - 1;
                        when others    => pas <= pas;
                end case;


--              if poussoir ='0' then -- boutton poussoir non apuyé
--                      case pas is
--                              when "000" => led <= "10000000"; -- led 0 allumée
--                              when "001" => led <= "01000000"; -- led 1 allumée
--                              when "010" => led <= "00100000"; -- led 2 allumée
--                              when "011" => led <= "00010000"; -- led 3 allumée
--                              when "100" => led <= "00001000"; -- led 4 allumée
--                              when "101" => led <= "00000100"; -- led 5 allumée
--                              when "110" => led <= "00000010"; -- led 6 allumée
--                              when "111" => led <= "00000001"; -- led 7 allumée
--                              when others => led <= "10101010"; -- erreur
--                      end case;
--              else
--                      case pas is
--                              when "000" => led <= "01111111"; -- led 0 éteinte
--                              when "001" => led <= "10111111"; -- led 1 éteinte
--                              when "010" => led <= "11011111"; -- led 2 éteinte
--                              when "011" => led <= "11101111"; -- led 3 éteinte
--                              when "100" => led <= "11110111"; -- led 4 éteinte
--                              when "101" => led <= "11111011"; -- led 5 éteinte
--                              when "110" => led <= "11111101"; -- led 6 éteinte
--                              when "111" => led <= "11111110"; -- led 7 éteinte
--                              when others => led <= "01010101"; -- erreur
--                      end case;
--              end if;
end if;
end process calcul_pas;

        led <= pas;

end deux_process;