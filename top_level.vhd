----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.02.2017 16:17:22
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Generic ( 
           nb_bits_inc     : INTEGER := 32 );
    Port ( H               : in STD_LOGIC;
           raz             : in STD_LOGIC;
           encs            : in STD_LOGIC_VECTOR (1 downto 0);
           switch1         : in std_logic;
           switch2         : in std_logic;
           led1            : out std_logic;
           led2            : out std_logic;
           pwm             : out std_logic;
           an              : out STD_LOGIC_VECTOR (7 downto 0);
           sept_segments   : out STD_LOGIC_VECTOR (6 downto 0)
           );
end top_level;



architecture Behavioral of top_level is

-- SIGNAUX --
signal CE_enc, CE_aff                 : std_logic;
signal sortie                         : std_logic_vector (2 downto 0);
signal nb_increment                   : std_logic_vector (nb_bits_inc-1 downto 0);
signal vitesse, diff, nb_in           : std_logic_vector (31 downto 0);
signal fencs                          : std_logic_vector(1 downto 0);

begin

horloge : entity work.gestion_freq port map (H   => H,
                                             raz => raz,
                                             CE1 => CE_enc,
                                             CE2 => CE_aff
                                             );                                 
                                 
vite    : entity work.vitesse_enc  port map (H            => H,
                                             raz          => raz,
                                             CE           => CE_enc,
                                             nb_increment => nb_increment,
                                             diff         => diff,
                                             vitesse      => vitesse
                                             );
                                             
rebonds : entity work.anti_rebond  port map(encs       => encs,         
                                            H          => H,        
                                            raz        => raz,          
                                            valeur_rot => fencs
                                            );
                                
fsm   : ENTITY work.fsm2           port map (H            => H,
                                             raz          => raz,
                                             encs         => fencs,
                                             nb_increment => nb_increment
                                             );
                                             
aff : entity work.affichage        port map(H        => H,
                                            raz      => raz,
                                            CE       => CE_aff,
                                            nb_in    => nb_in(26 downto 0),
                                            sept_seg => sept_segments,
                                            an       => an
                                            ); 

mux_aff : entity work.multiplex    port map(vitesse  => vitesse,
                                            nb_inc   => nb_increment, 
                                            diff_inc => diff,
                                            switch1  => switch1,
                                            switch2  => switch2,
                                            sortie   => nb_in
                                            );

out_pwm : ENTITY work.gen_pwm       port map (H => H,
                                              raz => raz,
                                              commande => "101101111",
                                              pwm => pwm
                                              );

process (H) 
begin
    if rising_edge(H) then
        led1 <= encs(0);
        led2 <= encs(1);
    end if;
end process;    


end Behavioral;
