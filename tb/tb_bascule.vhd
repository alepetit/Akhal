
-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 27.2.2017 13:31:33 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_bascule is
end tb_bascule;

architecture tb of tb_bascule is

    component bascule
        port (data     : in std_logic_vector (7 downto 0);
              H        : in std_logic;
              raz      : in std_logic;
              enable   : in std_logic;
              data_out : out std_logic_vector (7 downto 0));
    end component;

    signal data     : std_logic_vector (7 downto 0);
    signal H        : std_logic;
    signal raz      : std_logic;
    signal enable   : std_logic;
    signal data_out : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here

begin

    dut : bascule
    port map (data     => data,
              H        => H,
              raz      => raz,
              enable   => enable,
              data_out => data_out);
    
    process
    begin
        H <= '0';
        wait for TbPeriod/2;
        H <= '1';
        wait for TbPeriod/2;
    end process;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        data <= "10000000";
        raz <= '0';
        enable <= '0';

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        raz <= '1';
        wait for 100 ns;
        raz <= '0';
        wait for 100 ns;
        data <= "10101001";
        enable <= '1';
        wait;
    end process;

end tb;