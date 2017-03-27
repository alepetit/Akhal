----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2017 09:43:05
-- Design Name: 
-- Module Name: anti_rebond - Behavioral
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

entity anti_rebond is
    Port ( encs            : in STD_LOGIC_VECTOR (1 downto 0);
           H               : in STD_LOGIC;
           raz             : in STD_lOGIC;
           valeur_rot : out STD_LOGIC_VECTOR (1 downto 0));
end anti_rebond;

architecture Behavioral of anti_rebond is

signal valeur_rotation : STD_LOGIC_VECTOR(1 downto 0);

begin

filtre : PROCESS(H)
	BEGIN
		IF(H'event and H='1') THEN
			IF (raz='1') THEN
				valeur_rotation <= "00"; -- mis à zero des deux sorties
			ELSE
				CASE encs IS 
					
				-- reset du LSB (ligne A et B à 0)
				WHEN "00" => valeur_rotation(0)<='0'; 	                   -- RESET
					         valeur_rotation(1) <= valeur_rotation(1);   --MEMORISATION
					
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

valeur_rot <= valeur_rotation;

end Behavioral;
