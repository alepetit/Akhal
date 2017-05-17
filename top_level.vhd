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
use work.mes_constantes.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( H               : in STD_LOGIC;
           raz             : in STD_LOGIC;
           RsRx            : in STD_LOGIC;
           encs            : in STD_LOGIC_VECTOR (1 downto 0);
           switch1         : in std_logic;
           switch2         : in std_logic;
           switch3         : in std_logic;
           led1            : out std_logic;
           led2            : out std_logic;
           RsTx            : out STD_LOGIC;
           pwm             : out std_logic;
           led             : out STD_LOGIC_VECTOR (9 downto 0);
           an              : out STD_LOGIC_VECTOR (7 downto 0);
           sept_segments   : out STD_LOGIC_VECTOR (6 downto 0)
           );
end top_level;

architecture Behavioral of top_level is

-- SIGNAUX --
signal CE_enc, CE_aff, CE_fsm, CE_filtre : std_logic;
signal nb_increment           : std_logic_vector (nb_bit_increment-1 downto 0);
signal vitesse                : std_logic_vector (nb_bit_vitesse-1 downto 0);
signal diff                   : std_logic_vector (nb_bit_diff-1 downto 0);
signal nb_in                  : std_logic_vector (nb_bit_increment-1 downto 0);
signal fencs                  : STD_LOGIC_VECTOR (1 downto 0);

signal data_from_uart         : std_logic_vector(7 downto 0);
signal i_uart                 : std_logic_vector(7 downto 0);
signal data_to_uart           : std_logic_vector(7 downto 0);
signal data_to_uart_D         : std_logic_vector(7 downto 0);
signal dat_en_rx, dat_en_tx   : std_logic;

signal data_en_to_uart        : std_logic;
signal data_en_to_uart_D      : std_logic;
signal bug                    : std_logic;
signal vit_en                 : std_logic;

signal nb_dead                : STD_LOGIC_VECTOR(9 downto 0);
signal bugS                   : std_logic_vector(9 downto 0);

signal commande_vit           : std_logic_vector(7 downto 0);
signal vitesse8               : std_logic_vector(7 downto 0);
signal correcteur8            : std_logic_vector(7 downto 0);
signal correcteur10           : std_logic_vector(9 downto 0);



begin

-- PORT MAP --

horloge : entity work.gestion_freq   port map (H  => H,
                                              raz => raz,
                                              CE_enc => CE_enc,
                                              CE_aff => CE_aff,
                                              CE_fsm => CE_fsm,
                                              CE_filtre => CE_filtre
                                              );
                                 
rebonds : entity work.anti_rebond  port map(encs       => encs,          
                                            H          => H,  
                                            CE         => CE_filtre,         
                                            raz        => raz, 
                                            switch     => switch3,  
                                            bug        => bug,    
                                            bugS       => bugS,
                                            valeur_rot => fencs
                                            );
                                        
encod   : entity work.fsm4         port map (H           => H,
                                            raz          => raz,
                                            encs         => fencs,
                                            nb_dead      => nb_dead,
                                            nb_increment => nb_increment
                                            );    
                                                                                                                  
vite    : entity work.vitesse_enc  port map (H            => H,
                                             raz          => raz,
                                             CE           => CE_enc,
                                             nb_increment => nb_increment,
                                             diff         => diff,
                                             vit_en       => vit_en,
                                             vitesse      => vitesse);

mux : entity work.multiplex port map(vitesse  => vitesse,
                                     nb_inc   => nb_increment,
                                     diff_inc => diff,
                                     switch1  => switch1,
                                     switch2  => switch2,
                                     nb_dead => correcteur10,
                                     sortie   => nb_in
                                     );
                                     
aff : entity work.affichage   port map(H        => H,
                                       raz      => raz,
                                       CE       => CE_aff,
                                       nb_in    => nb_in,
                                       sept_seg => sept_segments,
                                       an       => an
                                       );

out_pwm : ENTITY work.gen_pwm port map (H        => H,
                                        raz      => raz,
                                        CE       => CE_fsm,
                                        commande => correcteur8,
                                        pwm      => pwm
                                        );

uart_rx : ENTITY work.UART_recv port map (clk => H,
                                          reset => raz,
                                          rx => RsRx,
                                          dat => data_from_uart,
                                          dat_en => dat_en_rx);

uart_tx : ENTITY work.UART_fifoed_send port map (clk_100MHz => H,
                                          reset => raz,
                                          dat_en => data_en_to_uart,
                                          dat => data_to_uart,
                                          TX => RsTx,
                                          fifo_empty => open,
                                          fifo_afull => open,
                                          fifo_full => open);
                                          
                                          
correcteur : entity work.asserv_vitesse port map (H => H,
                                                  CE => vit_en,
                                                  raz => raz,
                                                  consigne => i_uart,
                                                  retour_enc => vitesse8,
                                                  vitesse => commande_vit);

-- PROCESS --


data_to_uart      <= commande_vit;
vitesse8          <= vitesse(7 downto 0);

data_en_to_uart   <= CE_enc;
correcteur10      <= "00" & commande_vit;
correcteur8      <= commande_vit;

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


led <= bugS;


process(H)
begin
    if rising_edge(H) then
        led1 <= encs(0);
        led2 <= encs(1);
    end if;
end process;

end Behavioral;
