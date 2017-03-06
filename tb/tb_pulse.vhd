library ieee;
use ieee.std_logic_1164.all;

entity tb_detec_imp is
end tb_detec_imp;

architecture tb of tb_detec_imp is

    component detec_imp
        port (signal_enc : in std_logic;
              H          : in std_logic;
              impulse    : out std_logic);
    end component;

    signal signal_enc : std_logic;
    signal H          : std_logic;
    signal impulse    : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT put right period here
    signal TbClock : std_logic := '1';

begin

    dut : detec_imp
    port map (signal_enc => signal_enc,
              H          => H,
              impulse    => impulse);

    TbClock <= not TbClock after TbPeriod/2;

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock
    H <= TbClock;

    stimuli : process
    begin
        signal_enc <= '0';
        wait for 20ns;
        signal_enc <= '1';
        wait for 100ns;
        signal_enc <= '0';
        wait for 20ns;
        signal_enc <= '1';
        wait for 20ns;
        signal_enc <= '0';
        wait;
    end process;

end tb;