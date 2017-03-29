----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.09.2016 10:30:23
-- Design Name: 
-- Module Name: gestion_freq - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_freq is
    Port ( H             : in STD_LOGIC;
           raz           : in STD_LOGIC;
           CE_enc        : out STD_LOGIC;
           CE_aff        : out STD_LOGIC;
           CE_fsm        : out STD_LOGIC);
end gestion_freq;

architecture Behavioral of gestion_freq is


signal compt_enc : natural range 1 to timer_enc;
signal compt_aff : natural range 1 to timer_aff;
signal compt_fsm : natural range 1 to timer_fsm;

begin
    CE_encodeur : process(H)
    begin
        if (rising_edge(H)) then
            if (raz = '1') then
                compt_enc <= 1;
            else
                if (compt_enc = timer_enc) then
                    compt_enc <= 1;
                    CE_enc <= '1';
                else
                    compt_enc <= compt_enc + 1;
                    CE_enc <= '0';
                end if;
            end if;
        end if;     
    end process;
    
    CE_affichage : process(H)
    begin
        if (rising_edge(H)) then
            if (raz = '1') then
                compt_aff <= 1;
            else            
                if (compt_aff = timer_aff) then
                    compt_aff <= 1;
                    CE_aff <= '1';
                else
                    CE_aff <= '0';
                    compt_aff <= compt_aff + 1;
                end if;
            end if;
        end if;     
    end process;
    
    CE_machine_etat : process(H)
    begin
        if (rising_edge(H)) then
            if (raz = '1') then
                compt_fsm <= 1;
            else            
                if (compt_fsm = timer_fsm) then
                    compt_fsm <= 1;
                    CE_fsm <= '1';
                else
                    CE_fsm <= '0';
                    compt_fsm <= compt_fsm + 1;
                end if;
            end if;
        end if;     
    end process;
    
end Behavioral;
