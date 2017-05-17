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
           switch          : in std_logic;
           CE              : in std_logic;
           bug             : out std_logic;
           bugS            : out STD_LOGIC_VECTOR (9 downto 0);
           valeur_rot : out STD_LOGIC_VECTOR (1 downto 0));
end anti_rebond;

architecture Behavioral of anti_rebond is

signal valeur_rotation : STD_LOGIC_VECTOR(1 downto 0);

    signal dbug : STD_LOGIC := '0';
    signal last : STD_LOGIC_VECTOR(1 downto 0);
    signal lastE : STD_LOGIC_VECTOR(1 downto 0);

    signal EntreeENCS : STD_LOGIC := '0';
    signal LastENCS   : STD_LOGIC_vector(1 downto 0);
    signal BugENCS    : STD_LOGIC_VECTOR (8 downto 0);
    
    signal shiftENCS, shiftInterne  : STD_LOGIC_VECTOR(7 downto 0);
begin

    entree : PROCESS(H)
	BEGIN
		IF(H'event and H='1') THEN
		  IF raz='1' THEN
		      EntreeENCS <= '0';
		      lastE <= encs;
		      last <= "00";
              dbug <= '0';
              BugENCS <= (others => '0');


              shiftENCS <= (others => '0');
		  ELSIF (EntreeENCS = '0' and dbug = '0') THEN
		      EntreeENCS <= (lastE(0) xor encs(0)) AND (lastE(1) xor encs(1));
    		  lastE <= encs;
    		  dbug <= (last(0) xor valeur_rotation(0)) AND (last(1) xor valeur_rotation(1));
              last <= valeur_rotation;
              BugENCS <= last & valeur_rotation & lastE & encs & dbug;
              shiftENCS <= shiftENCS(5 downto 0) & valeur_rotation;
              shiftInterne <= shiftInterne(5 downto 0) & valeur_rotation;
		  ELSE
		      EntreeENCS <= EntreeENCS;
		      lastE <= lastE;
		      last <= last;
              dbug <= dbug;
              BugENCS <= BugENCS;
              shiftENCS <= shiftENCS;
              shiftInterne <= shiftInterne;
		  END IF;	
		END IF;	
	END PROCESS;

--    PROCESS(H)
--	BEGIN
--		IF(H'event and H='1') THEN
--		  IF raz='1' THEN
--		      last <= "00";
--		      dbug <= '0';
--    		  lastE <= encs;
--		  ELSIF dbug = '0' THEN
--		      dbug <= (last(0) xor valeur_rotation(0)) AND (last(1) xor valeur_rotation(1));
--              last <= valeur_rotation;
--		  ELSE
--    		  last <= last;
--		      dbug <= dbug;
--		  END IF;	
--		END IF;	
--	END PROCESS;
	
	
    bug <= dbug or EntreeENCS;
    bugS <= dbug & EntreeENCS & shiftENCS when switch = '1' else dbug & EntreeENCS & shiftInterne;

filtre : PROCESS(H)
	BEGIN
		IF(H'event and H='1') THEN
			IF (raz='1') THEN
				valeur_rotation <= "00"; -- mis à zero des deux sorties
			ELSE
			    --if CE = '1' then
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
                --end if;
			END IF;
		END IF;	
	END PROCESS filtre;

valeur_rot <= valeur_rotation;

end Behavioral;
