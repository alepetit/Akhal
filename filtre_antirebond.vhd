----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:20:28 09/16/2014 
-- Design Name: 
-- Module Name:    filtre_antirebond - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY anti_rebonds IS
PORT (
	H               : IN STD_LOGIC;
	R               : IN STD_LOGIC;
	bouton_poussoir : IN STD_LOGIC;
	ligne_bouton    : IN STD_LOGIC_VECTOR (1 downto 0);
	sortie_led      : OUT STD_LOGIC_VECTOR (7 downto 0)
);
END;

ARCHITECTURE decodeur OF anti_rebonds IS
	type etats is (debut, etat0, etat1, etat2, etat3, inc, dec);
	SIGNAL etatc       : etats;
	SIGNAL etatf       : etats;
	SIGNAL rotation    : STD_LOGIC_VECTOR (1 downto 0);
	SIGNAL led_tampon  : UNSIGNED (7 downto 0);  -- avant traitement par bouton poussoir 
	SIGNAL led         : UNSIGNED (7 downto 0);
BEGIN

	synchrone : PROCESS(H)
	BEGIN
		IF(H'event and H = '1') THEN
			IF (R = '1') THEN
				etatc <= debut;
			ELSE
				etatc <= etatf;
			END IF;
		END IF;
	END PROCESS;


calcul_anti_rebond : PROCESS(ligne_bouton, H, R)
	BEGIN
		IF (R = '1') THEN
			rotation <= "00";
		ELSE
			IF ligne_bouton = "00" THEN
				rotation(1) <= rotation(1);
				rotation(0) <= '0';
			ELSIF ligne_bouton = "01" THEN
				rotation(1) <= '0';
				rotation(0) <= rotation(0);
			ELSIF ligne_bouton = "10" THEN
				rotation(1) <= '1';
				rotation(0) <= rotation(0);
			ELSIF ligne_bouton = "11" THEN
				rotation(1) <= rotation(1);
				rotation(0) <= '1';
			ELSE
				rotation(1) <= rotation(1);
				rotation(0) <= rotation(0);
			END IF;
		END IF;
	END PROCESS;
	
	


	machine_etat : PROCESS(H, rotation, etatc, R)
	BEGIN
			CASE etatc IS
				WHEN debut =>
					IF rotation = "01" THEN
						etatf <= etat1;
					ELSIF rotation = "10" THEN
						etatf <= etat2;
					ELSE 
						etatf <= debut;
						led_tampon <= "00001000";
					END IF;
				WHEN etat0 =>
					IF rotation = "01" THEN
						etatf <= etat1;
					ELSIF rotation = "10" THEN
						etatf <= etat2;
					ELSE 
						etatf <= etat0;
					END IF;
				WHEN etat1 =>
					IF rotation = "11" THEN
						etatf <= dec;
					ELSIF rotation = "01" THEN
						etatf <= etat1;
					ELSE 
						etatf <= etat0;
					END IF;
				WHEN etat2 =>
					IF rotation = "11" THEN
						etatf <= inc;
					ELSIF rotation = "10" THEN
						etatf <= etat2;
					ELSE 
						etatf <= etat0;
					END IF;
				WHEN etat3 =>
					IF rotation = "00" THEN
						etatf <= etat0;
					ELSE 
						etatf <= etat3;
					END IF;
				WHEN inc =>
					etatf <= etat3;
					led_tampon <= led_tampon ror 1;      -- Rotate Right of 1 bit
				WHEN dec =>
					etatf <= etat3;
					led_tampon <= led_tampon rol 1;      -- Rotate Left of 1 bit
				WHEN OTHERS =>
					etatf <= etatc;
			END CASE;
	END PROCESS;
	
	
	negation_led : PROCESS(H, R, led_tampon, bouton_poussoir)
	BEGIN
		IF(H'event and H = '1') THEN
			IF (R = '1') THEN
				led <= "00000000";
			ELSE
				IF bouton_poussoir = '1' THEN 
					led <= NOT(led_tampon);
				ELSE
					led <= led_tampon;
				END IF;
			END IF;
		END IF;
	END PROCESS;

sortie_led <= STD_LOGIC_VECTOR(led);	

END decodeur;