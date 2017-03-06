-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 27.2.2017 09:19:42 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm2 is
end tb_fsm2;

architecture tb of tb_fsm2 is

    component fsm2
        port (H            : in std_logic;
              raz          : in std_logic;
              encA         : in std_logic;
              encB         : in std_logic;
              nb_increment : out std_logic_vector (31 downto 0));
    end component;

    signal H            : std_logic;
    signal raz          : std_logic;
    signal encA         : std_logic;
    signal encB         : std_logic;
    signal nb_increment : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';

begin

    dut : fsm2
    port map (H            => H,
              raz          => raz,
              encA         => encA,
              encB         => encB,
              nb_increment => nb_increment);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2;

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    H <= TbClock;
    
    enc : process
    begin
        encA <= '1';
        wait for 200 ns;
        encB <= '1';
        wait for 200 ns;
        encA <= '0';
        wait for 200ns;
        encB <= '0';
        wait for 200ns;
    end process;
    
    stimuli : process
    begin
        -- EDIT Adapt initialization as neede
        raz <= '0';

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        raz <= '1';
        wait for 100 ns;
        raz <= '0';
        wait;
    end process;

end tb;