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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Generic ( 
           nb_bits_inc     : INTEGER := 32 );
    Port ( H             : in STD_LOGIC;
           raz           : in STD_LOGIC;
           encs          : in STD_LOGIC_VECTOR (1 downto 0);
           RsRx          : in STD_LOGIC;
           RsTx          : out STD_LOGIC;
           switch1 : in std_logic;
           switch2 : in std_logic;
           led1 : out std_logic;
           led2 : out std_logic;
           led : out STD_LOGIC_VECTOR (8 downto 0);
           pwm : out std_logic;
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

-- SIGNAUX --
signal CE1,CE2                        : std_logic;
signal sortie                         : std_logic_vector (2 downto 0);
signal E0, E1, E2, E3, E4, E5, E6, E7 : std_logic_vector (6 downto 0);
signal nb_increment                   : std_logic_vector (nb_bits_inc-1 downto 0);
signal vitesse, diff, nb_in           : std_logic_vector (31 downto 0);
signal s_hls                          : std_logic_vector(31 downto 0);
signal i_pwm                          : std_logic_vector(8 downto 0);
signal data_from_uart,i_uart          : std_logic_vector(7 downto 0) := "01010101";
signal data_to_uart                   : std_logic_vector(7 downto 0);
signal dat_en_rx,dat_en_tx            : std_logic;



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
                                 
                                 
vite    : entity work.vitesse_enc  port map (H => H,
                                             raz => raz,
                                             CE => CE1,
                                             nb_increment => nb_increment,
                                             diff => diff,
                                             vitesse => vitesse);
                                 


fsm   : ENTITY work.fsm3           port map (H => H,
                                             raz => raz,
                                             encs => encs,
                                             nb_increment => nb_increment);

process(switch1, switch2, nb_increment, vitesse, diff)
begin
    if switch1 = '0' then
        nb_in <= vitesse;
    elsif switch2 = '0' then
        nb_in <= nb_increment;
    else 
        nb_in <= diff;
    end if;
end process;

process(H)
begin
    if rising_edge(H) then
        if dat_en_rx = '1' then
            i_uart <= data_from_uart;
        else
            i_uart <= i_uart;
        end if;
    end if;
end process;

process(H)
    variable t1 : integer range 0 to 255;
    variable t2 : integer range 0 to 511;
begin
    if rising_edge(H) then
        t1 := to_integer(unsigned(i_uart));
        t2 := (t1-97)*16;
        i_pwm <= std_logic_vector(to_unsigned(t2,9));
    end if;
end process;

led <= i_pwm;



seg7    : ENTITY work.transcodeur port map ( nb_in => nb_in (26 downto 0),
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

out_pwm : ENTITY work.gen_pwm port map (H => H,
                                    raz => raz,
                                    commande => i_pwm,
                                    pwm => pwm);

uart_rx : ENTITY work.UART_recv port map (clk => H,
                                       reset => raz,
                                       rx => RsRx,
                                       dat => data_from_uart,
                                       dat_en => dat_en_rx);

uart_tx : ENTITY work.UART_send port map (clk => H,
                                          reset => raz,
                                          dat_en => CE1,
                                          dat => data_to_uart,
                                          TX => RsTx,
                                          busy => open);
                                          
--data_to_uart <= vitesse(7 downto 0);
data_to_uart <= STD_LOGIC_VECTOR(TO_UNSIGNED(TO_INTEGER(UNSIGNED(vitesse(7 downto 3))) + 97, 8));

process (H) 
begin
    if rising_edge(H) then
        led1 <= encs(0);
        led2 <= encs(1);
    end if;
 
end process;    


end Behavioral;
