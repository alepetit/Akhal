-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 27.2.2017 13:54:14 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_pc is
end tb_pc;

architecture tb of tb_pc is

    component pc
        port (H      : in std_logic;
              raz    : in std_logic;
              enable : in std_logic;
              jump   : in std_logic;
              jcc    : in std_logic_vector (5 downto 0);
              addr   : out std_logic_vector (5 downto 0));
    end component;

    signal H      : std_logic;
    signal raz    : std_logic;
    signal enable : std_logic;
    signal jump   : std_logic;
    signal jcc    : std_logic_vector (5 downto 0);
    signal addr   : std_logic_vector (5 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    

begin

    dut : pc
    port map (H      => H,
              raz    => raz,
              enable => enable,
              jump   => jump,
              jcc    => jcc,
              addr   => addr);
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
        enable <= '1';
        jump <= '0';
        jcc <= ("100000");

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        raz <= '1';
        wait for 100 ns;
        raz <= '0';
        wait for 100 ns;
        
       jcc <= "101010";
       wait for 100ns;
       jump <= '1';

        wait;
    end process;

end tb;
