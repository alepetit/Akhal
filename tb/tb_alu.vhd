-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 27.2.2017 14:54:06 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_alu is
end tb_alu;

architecture tb of tb_alu is

    component alu
        port (data1    : in std_logic_vector (7 downto 0);
              data2    : in std_logic_vector (7 downto 0);
              sel_val  : in std_logic;
              data_out : out std_logic_vector (7 downto 0);
              carry    : out std_logic);
    end component;

    signal data1    : std_logic_vector (7 downto 0);
    signal data2    : std_logic_vector (7 downto 0);
    signal sel_val  : std_logic;
    signal data_out : std_logic_vector (7 downto 0);
    signal carry    : std_logic;

begin

    dut : alu
    port map (data1    => data1,
              data2    => data2,
              sel_val  => sel_val,
              data_out => data_out,
              carry    => carry);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        data1 <= ("10000001");
        data2 <= ("11000000");
        sel_val <= '0';
        wait for 100ns;
        sel_val <= '1';
        wait;
    end process;

end tb;