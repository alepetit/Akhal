library ieee;
use ieee.std_logic_1164.all;

entity tb_transcodeur is
end tb_transcodeur;

architecture tb of tb_transcodeur is

    component transcodeur
        port (nb_bin : in std_logic_vector (13 downto 0);
              S_mil  : out std_logic_vector (6 downto 0);
              S_uni  : out std_logic_vector (6 downto 0);
              S_diz  : out std_logic_vector (6 downto 0);
              S_cent : out std_logic_vector (6 downto 0));
    end component;

    signal nb_bin : std_logic_vector (13 downto 0);
    signal S_mil  : std_logic_vector (6 downto 0);
    signal S_uni  : std_logic_vector (6 downto 0);
    signal S_diz  : std_logic_vector (6 downto 0);
    signal S_cent : std_logic_vector (6 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT put right period here
    signal TbClock : std_logic := '0';

begin

    dut : transcodeur
    port map (nb_bin => nb_bin,
              S_mil  => S_mil,
              S_uni  => S_uni,
              S_diz  => S_diz,
              S_cent => S_cent);

--    TbClock <= not TbClock after TbPeriod/2;

--    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock
--    H <= TbClock;

    stimuli : process
    begin
        nb_bin <= "00000000000101";
        wait for 20ns;
        nb_bin <= "00000000001000";
        wait;
    end process;

end tb;
