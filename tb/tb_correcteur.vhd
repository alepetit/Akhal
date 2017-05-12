library ieee;
use ieee.std_logic_1164.all;

entity tb_asserv_vitesse is
end tb_asserv_vitesse;

architecture tb of tb_asserv_vitesse is

    component asserv_vitesse
        port (H          : in std_logic;
              CE         : in std_logic;
              raz        : in std_logic;
              consigne   : in std_logic_vector (7 downto 0);
              retour_enc : in std_logic_vector (7 downto 0);
              vitesse    : out std_logic_vector (7 downto 0));
    end component;

    signal H          : std_logic;
    signal CE         : std_logic;
    signal raz        : std_logic;
    signal consigne   : std_logic_vector (7 downto 0);
    signal retour_enc : std_logic_vector (7 downto 0);
    signal vitesse    : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : asserv_vitesse
    port map (H          => H,
              CE         => CE,
              raz        => raz,
              consigne   => consigne,
              retour_enc => retour_enc,
              vitesse    => vitesse);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2;

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    H <= TbClock;
    
    process
    begin
        CE <= '0';
        wait for 30ns;
        CE <= '1';
        wait for 30ns;
    end process;
       

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        consigne <= "11111111";
        retour_enc <= (others => '0');
        retour_enc <= (others => '0');
        raz <= '1';

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        
        wait for 70 ns;
        raz <= '0';
        wait;
    end process;

end tb;