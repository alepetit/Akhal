----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2017 11:37:19
-- Design Name: 
-- Module Name: fsm3 - Behavioral
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

entity fsm3 is
    Port ( H : in STD_LOGIC;
           raz : in STD_LOGIC;
           encs : in STD_LOGIC_VECTOR (1 downto 0);
           nb_increment : out STD_LOGIC_VECTOR (31 downto 0));
end fsm3;

architecture Behavioral of fsm3 is

SIGNAL valeur_rotation : STD_LOGIC_VECTOR (1 DOWNTO 0);
type state is (e_raz, initial, detect_sens, horaire, anti_horaire, increment, decrement, attente_horaire, attente_anti_horaire);
signal etat   : state;
signal cpt : integer range 0 to 2147483647;
signal fencs : STD_LOGIC_VECTOR (1 downto 0);
begin

	fencs <= valeur_rotation;
	filtre : PROCESS(H)
	BEGIN
		IF(H'event and H='1') THEN
			IF (raz='1') THEN
				valeur_rotation<="00"; -- mis à zero des deux sorties
			ELSE
				CASE encs IS 
					
				-- reset du LSB (ligne A et B à 0)
				WHEN "00" => valeur_rotation(0)<='0'; 	                   -- RESET
					           valeur_rotation(1)<=valeur_rotation(1);   --MEMORISATION
					
				-- set du LSB (ligne A et B à 1)
				WHEN "11" => valeur_rotation(0)<='1';	 	     -- SET
					           valeur_rotation(1)<=valeur_rotation(1); -- MEMORISATION							   
				-- reset du MSB (ligne A à 1 et ligne B à 0)
				WHEN "01" => valeur_rotation(0)<=valeur_rotation(0);   -- MEMORISATION
					           valeur_rotation(1)<='0';		     -- RESET
					
				-- set du MSB (ligne A à 0 et ligne B à 1)
				WHEN "10" => valeur_rotation(0)<=valeur_rotation(0);    -- MEMORISATION
					           valeur_rotation(1)<='1';		     -- SET
					
				-- mémorisation 
				WHEN OTHERS => valeur_rotation<=valeur_rotation;    -- MEMORISATION
				END CASE;
			END IF;
		END IF;	
	END PROCESS filtre;

calcul_etat : process(H)
begin
    if rising_edge(H) then
        if raz='1' then
                etat <= e_raz;
        else
            case etat is 
                   when e_raz => etat <= initial;
                   when initial =>
                         if fencs = "00" then
                                 etat <= detect_sens;
                         else
                                 etat <= initial;
                         end if;

                   when detect_sens =>
                         case fencs is
                             when "00"   => etat <= detect_sens;
                             when "01"   => etat <= horaire;
                             when "10"   => etat <= anti_horaire;
                             when "11"   => etat <= detect_sens;
                             when others => etat <= initial;
                         end case;

                   when horaire => 
                         case fencs is
                            when "00"   => etat <= detect_sens;
                            when "01"   => etat <= horaire;
                            when "10"   => etat <= detect_sens;
                            when "11"   => etat <= increment;
                            when others => etat <= initial;
                         end case;

                   when anti_horaire =>
                         case fencs is
                            when "00"   => etat <= detect_sens;
                            when "01"   => etat <= detect_sens;
                            when "10"   => etat <= anti_horaire;
                            when "11"   => etat <= decrement;
                            when others => etat <= initial;
                         end case;

                   when increment => etat <= attente_horaire;

                   when decrement => etat <= attente_anti_horaire;

                   when attente_horaire =>
                         case fencs is
                            when "00" => etat   <= detect_sens;
                            when "01" => etat   <= anti_horaire;
                            when "10" => etat   <= attente_horaire;
                            when "11" => etat   <= attente_horaire;
                            when others => etat <= initial;
                         end case;

                   when attente_anti_horaire =>
                         case fencs is
                           when "00" => etat   <= detect_sens;
                           when "01" => etat   <= attente_anti_horaire;
                           when "10" => etat   <= horaire;
                           when "11" => etat   <= attente_anti_horaire;
                           when others => etat <= initial;
                         end case;
            end case;
        end if;
    end if;
end process calcul_etat;



    calcul_cpt : process(H)
    begin
        if (H'event and H ='1') then
                case etat is
                        when e_raz =>   cpt <= 10000;--1073741824;
                        when increment => cpt <= cpt + 1;
                        when decrement => cpt <= cpt - 1;
                        when others    => cpt <= cpt;
                end case;

        end if;
    end process calcul_cpt;
   
    nb_increment <= std_logic_vector(to_signed(cpt,32));


end Behavioral;
