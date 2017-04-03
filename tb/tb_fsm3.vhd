-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 7.3.2017 11:56:22 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm4 is
end tb_fsm4;

architecture tb of tb_fsm4 is

    component fsm4
        port (H            : in std_logic;
              raz          : in std_logic;
              encs         : in std_logic_vector (1 downto 0);
              nb_increment : out std_logic_vector (31 downto 0));
    end component;

    signal H            : std_logic;
    signal raz          : std_logic;
    signal encs         : std_logic_vector (1 downto 0);
    signal nb_increment : std_logic_vector (31 downto 0);



begin

    dut : fsm4
    port map (H            => H,
              raz          => raz,
              encs         => encs,
              nb_increment => nb_increment);

    process
    begin
        H <= '0';
        wait for 5ns;
        H <= '1';
        wait for 5ns;
    end process;
    
    process
    begin
        encs <= "00";
        wait for 30ns;
        encs <= "01";
        wait for 30ns;
        encs <= "11";
        wait for 30ns;
        encs <= "10";
        wait for 30ns;
    end process;

    stimuli : process
    begin
        raz <= '1';
        wait for 20ns;
        raz <= '0';

        wait;
    end process;

end tb;
