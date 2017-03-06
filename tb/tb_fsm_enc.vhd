-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 13.2.2017 10:06:40 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm_enc is
end tb_fsm_enc;

architecture tb of tb_fsm_enc is

    component fsm_enc
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

begin

    dut : fsm_enc
    port map (H            => H,
              raz          => raz,
              encA         => encA,
              encB         => encB,
              nb_increment => nb_increment);

    -- Clock generation
    clock : process
    begin
        H <= '1';
        wait for 5ns;
        H <= '0';
        wait for 5ns;
    end process;

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it

    stimuli : process
    begin


        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        raz <= '1';
        wait for 15 ns;
        raz <= '0';
        wait for 100 ns;

        -- Stop the clock and hence terminate the simulation
        wait;
    end process;
    
    A : process
    begin
        encA <= '1';
        wait for 30ns;
        encA <= '0';
        wait for 30ns;
    end process;

    B : process
    begin
        wait for 15ns;
        encB <= '1';
        wait for 30ns;
        encB <= '0';
        wait for 15ns;
    end process;
    
    
end tb;
