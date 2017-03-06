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
    Port ( H             : in STD_LOGIC;
           raz           : in STD_LOGIC;
           encA          : in STD_LOGIC;
           encB          : in STD_LOGIC;
           an            : out STD_LOGIC_VECTOR (7 downto 0);
           sept_segments : out STD_LOGIC_VECTOR (6 downto 0)
           );
end top_level;



architecture Behavioral of top_level is

-- COMPONENT --
component gestion_freq
    Port ( H            : in STD_LOGIC;
           raz          : in STD_LOGIC;
           CE1          : out STD_LOGIC;
           CE2          : out STD_LOGIC);
end component;

component mod4
    Port ( ce : in STD_LOGIC;
           H : in STD_LOGIC;
           raz : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           sortie : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component mux8
    Port ( COMMANDE : in STD_LOGIC_VECTOR (2 downto 0);
           E0 : in STD_LOGIC_VECTOR (6 downto 0);
           E1 : in STD_LOGIC_VECTOR (6 downto 0);
           E2 : in STD_LOGIC_VECTOR (6 downto 0);
           E3 : in STD_LOGIC_VECTOR (6 downto 0);
           E4 : in STD_LOGIC_VECTOR (6 downto 0);
           E5 : in STD_LOGIC_VECTOR (6 downto 0);
           E6 : in STD_LOGIC_VECTOR (6 downto 0);
           E7 : in STD_LOGIC_VECTOR (6 downto 0);
           S : out STD_LOGIC_VECTOR (6 downto 0)
           );
end component;

--component transcodeur
--    port (
--	        nb_bin         : in  STD_LOGIC_VECTOR (13 downto 0);
--	        S_mil          : out STD_LOGIC_VECTOR (6 downto 0);
--            S_uni          : out STD_LOGIC_VECTOR (6 downto 0);
--            S_diz          : out STD_LOGIC_VECTOR (6 downto 0);
--            S_cent         : out STD_LOGIC_VECTOR (6 downto 0)
--          );
--end component;

component transcod2 is
    Port ( vect_hls : in STD_LOGIC_VECTOR (31 downto 0);
       S1 : out STD_LOGIC_VECTOR (6 downto 0);
       S2 : out STD_LOGIC_VECTOR (6 downto 0);
       S3 : out STD_LOGIC_VECTOR (6 downto 0);
       S4 : out STD_LOGIC_VECTOR (6 downto 0);
       S5 : out STD_LOGIC_VECTOR (6 downto 0);
       S6 : out STD_LOGIC_VECTOR (6 downto 0);
       S7 : out STD_LOGIC_VECTOR (6 downto 0);
       S8 : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component vitesse_enc
    Generic ( 
           nb_bits_inc     : INTEGER := 32 );
    Port    ( H            : in STD_LOGIC;
              raz          : in STD_LOGIC;
              CE           : in STD_LOGIC;
              nb_increment : in STD_LOGIC_VECTOR (nb_bits_inc-1 downto 0);
              vitesse      : out STD_LOGIC_VECTOR (31 downto 0));
end component;

--component test_encodeur
--    Generic ( 
--           nb_bits_inc     : INTEGER := 14 );
--    Port ( H        : in STD_LOGIC;
--           raz      : in STD_LOGIC;
--           encA     : in STD_LOGIC;
--           encB     : in STD_LOGIC;
--           led      : out std_logic_vector (1 downto 0);
--           nb_increment : out STD_LOGIC_VECTOR (nb_bits_inc-1 downto 0));
--end component;

component detec_imp
    Port ( signal_enc : in STD_LOGIC;
           H : in STD_LOGIC;
           impulse : out STD_LOGIC);
end component;

-- SIGNAUX --
signal CE1,CE2 : std_logic;
signal sortie : std_logic_vector (2 downto 0);
signal E0, E1, E2, E3, E4, E5, E6, E7 : std_logic_vector (6 downto 0);
signal nb_increment : std_logic_vector (nb_bits_inc-1 downto 0);
signal vitesse : std_logic_vector (31 downto 0);
signal pulseA,pulseB : std_logic;
signal s_hls : std_logic_vector(31 downto 0);
signal sens : std_logic;


begin

horloge : gestion_freq port map (H => H,
                                 raz => raz,
                                 CE1 => CE1,
                                 CE2 => CE2);

mod_4   : mod4         port map (ce => CE2,
                                 H => H,
                                 raz => raz,
                                 AN => an,
                                 sortie => sortie);
                                 
mux_4   : mux8         port map (COMMANDE => sortie,
                                 E0 => E0,
                                 E1 => E1,
                                 E2 => E2,
                                 E3 => E3,
                                 E4 => E4,
                                 E5 => E5,
                                 E6 => E6,
                                 E7 => E7,
                                 S => sept_segments);
                                 
--transc  : transcodeur  port map (nb_bin => nb_increment,
--                                 S_mil => E3,
--                                 S_uni => E0,
--                                 S_diz => E1,
--                                 S_cent => E2);
                                 
vite    : entity work.vitesse_enc  port map (H => H,
                                             raz => raz,
                                             CE => CE1,
                                             nb_increment => nb_increment,
                                             sens => sens,
                                             vitesse => vitesse);
                                 
--encod   : ENTITY work.test_encodeur port map (H => H,
--                                  raz => raz,
--                                  encA => encA,
--                                  encB => encB,
--                                  led => led,
--                                  nb_increment => nb_increment);

encod   : ENTITY work.fsm2         port map (H => H,
                                             raz => raz,
                                             encA => encA,
                                             encB => encB,
                                             sens => sens,
                                             nb_increment => nb_increment);

--un : entity work.aff_compteur port map (H => CE1,
--                                        raz => raz,
--                                        sortie => nb_increment);

seg7    : ENTITY work.transcodeur port map (H => H,
                                             raz => raz,
                                             nb_in => vitesse,
                                             nb_out => s_hls);
                                             
tcd : transcod2 port map (vect_hls => s_hls, 
                          S1       => E0,
                          S2       => E1,
                          S3       => E2,
                          S4       => E3,
                          S5       => E4,
                          S6       => E5,
                          S7       => E6,
                          S8       => E7);

end Behavioral;
