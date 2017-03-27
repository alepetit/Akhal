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
    Port ( H               : in STD_LOGIC;
           raz             : in STD_LOGIC;
           RsRx            : in STD_LOGIC;
           encs            : in STD_LOGIC_VECTOR (1 downto 0);
           switch1         : in std_logic;
           switch2         : in std_logic;
           led1            : out std_logic;
           led2            : out std_logic;
           RsTx            : out STD_LOGIC;
           pwm             : out std_logic;
           led             : out STD_LOGIC_VECTOR (8 downto 0);
           an              : out STD_LOGIC_VECTOR (7 downto 0);
           sept_segments   : out STD_LOGIC_VECTOR (6 downto 0)
           );
end top_level;

architecture Behavioral of top_level is

-- SIGNAUX --
signal CE_enc, CE_aff : std_logic;
signal nb_increment : std_logic_vector (nb_bits_inc-1 downto 0);
signal vitesse, diff, nb_in : std_logic_vector (31 downto 0);
signal fencs : STD_LOGIC_VECTOR(1 downto 0);

signal i_pwm                           : std_logic_vector(8 downto 0);
signal data_from_uart, i_uart          : std_logic_vector(7 downto 0) := "01010101";
signal data_to_uart                    : std_logic_vector(7 downto 0);
signal dat_en_rx, dat_en_tx            : std_logic;

begin

horloge : entity work.gestion_freq   port map (H  => H,
                                              raz => raz,
                                              CE1 => CE_enc,
                                              CE2 => CE_aff
                                              );
                                 
rebonds : entity work.anti_rebond  port map(encs       => encs,          
                                            H          => H,           
                                            raz        => raz,           
                                            valeur_rot => fencs
                                            );
                                        
encod   : entity work.fsm2         port map (H           => H,
                                            raz          => raz,
                                            encs         => fencs,
                                            nb_increment => nb_increment
                                            );    
                                                                                                                  
vite    : entity work.vitesse_enc  port map (H            => H,
                                             raz          => raz,
                                             CE           => CE_enc,
                                             nb_increment => nb_increment,
                                             diff         => diff,
                                             vitesse      => vitesse);

mux : entity work.multiplex port map(vitesse  => vitesse,
                                     nb_inc   => nb_increment,
                                     diff_inc => diff,
                                     switch1  => switch1,
                                     switch2  => switch2,
                                     sortie   => nb_in
                                     );
                                     
aff : entity work.affichage   port map(H        => H,
                                       raz      => raz,
                                       CE       => CE_aff,
                                       nb_in    => nb_in(26 downto 0),
                                       sept_seg => sept_segments,
                                       an       => an
                                       );                           

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

out_pwm : ENTITY work.gen_pwm port map (H        => H,
                                        raz      => raz,
                                        commande => i_pwm,
                                        pwm      => pwm
                                        );

uart_rx : ENTITY work.UART_recv port map (clk => H,
                                          reset => raz,
                                          rx => RsRx,
                                          dat => data_from_uart,
                                          dat_en => dat_en_rx);

uart_tx : ENTITY work.UART_send port map (clk => H,
                                          reset => raz,
                                          dat_en => CE_enc,
                                          dat => data_to_uart,
                                          TX => RsTx,
                                          busy => open);
                                          
--data_to_uart <= vitesse(7 downto 0);
data_to_uart <= STD_LOGIC_VECTOR(TO_UNSIGNED(TO_INTEGER(UNSIGNED(vitesse(7 downto 3))) + 97, 8));
                                       

process(H)
begin
    if rising_edge(H) then
        led1 <= encs(0);
        led2 <= encs(1);
    end if;
end process;

end Behavioral;
