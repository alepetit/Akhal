-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 13.3.2017 08:29:36 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_gestion_freq is
end tb_gestion_freq;

architecture tb of tb_gestion_freq is

    component gestion_freq
        port (H   : in std_logic;
              raz : in std_logic;
              CE1 : out std_logic;
              CE2 : out std_logic);
    end component;

    signal H   : std_logic;
    signal raz : std_logic;
    signal CE1 : std_logic;
    signal CE2 : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : gestion_freq
    port map (H   => H,
              raz => raz,
              CE1 => CE1,
              CE2 => CE2);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2;

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    H <= TbClock;

    stimuli : process
    begin

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        raz <= '1';
        wait for 100 ns;
        raz <= '0';
        wait for 100 ns;

        wait;
    end process;

end tb;