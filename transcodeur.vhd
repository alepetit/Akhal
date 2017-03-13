library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity transcodeur is
    port (  nb_in         : in  STD_LOGIC_VECTOR (31 downto 0);
	        nb_out        : out STD_LOGIC_VECTOR (31 downto 0)
          );
end transcodeur;

architecture Behavioral of transcodeur is

signal nbre8           : integer range 0 to 99999999;
signal nbre7           : integer range 0 to 9999999;
signal nbre6           : integer range 0 to 999999;
signal nbre5           : integer range 0 to 99999;
signal nbre4           : integer range 0 to 9999;
signal nbre3           : integer range 0 to 999;
signal nbre2           : integer range 0 to 99;
signal nbre1           : integer range 0 to 9;

signal S1,S2,S3,S4,S5,S6,S7,S8 : std_logic_vector (3 downto 0);


begin	

nbre8 <= to_integer(unsigned(nb_in));

nb8 : process(nbre8)
begin
    if nbre8 < 10000000 then
        nbre7 <= nbre8;
        S8 <= "0000";
    elsif nbre8 < 20000000 then 
        nbre7 <= nbre8 - 10000000;
        S8 <= "0001";
    elsif nbre8 < 30000000 then
        nbre7 <= nbre8 - 20000000;
        S8 <= "0010";
    elsif nbre8 < 40000000 then
        nbre7 <= nbre8 - 30000000;
        S8 <= "0011";
    elsif nbre8 < 50000000 then
        nbre7 <= nbre8 - 40000000;
        S8 <= "0100";
    elsif nbre8 < 60000000 then
        nbre7 <= nbre8 - 50000000;
        S8 <= "0101";
    elsif nbre8 < 70000000 then 
        nbre7 <= nbre8 - 60000000;
        S8 <= "0110";
    elsif nbre8 < 80000000 then 
        nbre7 <= nbre8 - 70000000;
        S8 <= "0111";
    elsif nbre8 < 90000000 then 
        nbre7 <= nbre8 - 80000000;
        S8 <= "1000";
    else
        nbre7 <= nbre8 - 90000000;
        S8 <= "1001";
    end if;
end process;

nb7 : process(nbre7)
begin
    if nbre7 < 1000000 then
        nbre6 <= nbre7;
        S7 <= "0000";
    elsif nbre7 < 2000000 then 
        nbre6 <= nbre7 - 1000000;
        S7 <= "0001";
    elsif nbre7 < 3000000 then
        nbre6 <= nbre7 - 2000000;
        S7 <= "0010";
    elsif nbre7 < 4000000 then
        nbre6 <= nbre7 - 3000000;
        S7 <= "0011";
    elsif nbre7 < 5000000 then
        nbre6 <= nbre7 - 4000000;
        S7 <= "0100";
    elsif nbre7 < 6000000 then
        nbre6 <= nbre7 - 5000000;
        S7 <= "0101";
    elsif nbre7 < 7000000 then 
        nbre6 <= nbre7 - 6000000;
        S7 <= "0110";
    elsif nbre7 < 8000000 then 
        nbre6 <= nbre7 - 7000000;
        S7 <= "0111";
    elsif nbre7 < 9000000 then 
        nbre6 <= nbre7 - 8000000;
        S7 <= "1000";
    else
        nbre6 <= nbre7 - 90000000;
        S7 <= "1001";
    end if;
end process;

nb6 : process(nbre6)
begin
    if nbre6 < 100000 then
        nbre5 <= nbre6;
        S6 <= "0000";
    elsif nbre6 < 200000 then 
        nbre5 <= nbre6 - 100000;
        S6 <= "0001";
    elsif nbre6 < 300000 then
        nbre5 <= nbre6 - 200000;
        S6 <= "0010";
    elsif nbre6 < 400000 then
        nbre5 <= nbre6 - 300000;
        S6 <= "0011";
    elsif nbre6 < 500000 then
        nbre5 <= nbre6 - 400000;
        S6 <= "0100";
    elsif nbre6 < 600000 then
        nbre5 <= nbre6 - 500000;
        S6 <= "0101";
    elsif nbre6 < 700000 then 
        nbre5 <= nbre6 - 600000;
        S6 <= "0110";
    elsif nbre6 < 800000 then 
        nbre5 <= nbre6 - 700000;
        S6 <= "0111";
    elsif nbre6 < 900000 then 
        nbre5 <= nbre6 - 800000;
        S6 <= "1000";
    else
        nbre5 <= nbre6 - 900000;
        S6 <= "1001";
    end if;
end process;

nb5 : process(nbre5)
begin
    if nbre5 < 10000 then
        nbre4 <= nbre5;
        S5 <= "0000";
    elsif nbre5 < 20000 then 
        nbre4 <= nbre5 - 10000;
        S5 <= "0001";
    elsif nbre5 < 30000 then
        nbre4 <= nbre5 - 20000;
        S5 <= "0010";
    elsif nbre5 < 40000 then
        nbre4 <= nbre5 - 30000;
        S5 <= "0011";
    elsif nbre5 < 50000 then
        nbre4 <= nbre5 - 40000;
        S5 <= "0100";
    elsif nbre5 < 60000 then
        nbre4 <= nbre5 - 50000;
        S5 <= "0101";
    elsif nbre5 < 70000 then 
        nbre4 <= nbre5 - 60000;
        S5 <= "0110";
    elsif nbre5 < 80000 then 
        nbre4 <= nbre5 - 70000;
        S5 <= "0111";
    elsif nbre5 < 90000 then 
        nbre4 <= nbre5 - 80000;
        S5 <= "1000";
    else
        nbre4 <= nbre5 - 90000;
        S5 <= "1001";
    end if;
end process;

nb4 : process(nbre4)
begin
    if nbre4 < 1000 then
        nbre3 <= nbre4;
        S4 <= "0000";
    elsif nbre4 < 2000 then 
        nbre3 <= nbre4 - 1000;
        S4 <= "0001";
    elsif nbre4 < 3000 then
        nbre3 <= nbre4 - 2000;
        S4 <= "0010";
    elsif nbre4 < 4000 then
        nbre3 <= nbre4 - 3000;
        S4 <= "0011";
    elsif nbre4 < 5000 then
        nbre3 <= nbre4 - 4000;
        S4 <= "0100";
    elsif nbre4 < 6000 then
        nbre3 <= nbre4 - 5000;
        S4 <= "0101";
    elsif nbre4 < 7000 then 
        nbre3 <= nbre4 - 6000;
        S4 <= "0110";
    elsif nbre4 < 8000 then 
        nbre3 <= nbre4 - 7000;
        S4 <= "0111";
    elsif nbre4 < 9000 then 
        nbre3 <= nbre4 - 8000;
        S4 <= "1000";
    else
        nbre3 <= nbre4 - 9000;
        S4 <= "1001";
    end if;
end process;

nb3 : process(nbre3)
begin
    if nbre3 < 100 then
        nbre2 <= nbre3;
        S3 <= "0000";
    elsif nbre3 < 200 then 
        nbre2 <= nbre3 - 100;
        S3 <= "0001";
    elsif nbre3 < 300 then
        nbre2 <= nbre3 - 200;
        S3 <= "0010";
    elsif nbre3 < 400 then
        nbre2 <= nbre3 - 300;
        S3 <= "0011";
    elsif nbre3 < 500 then
        nbre2 <= nbre3 - 400;
        S3 <= "0100";
    elsif nbre3 < 600 then
        nbre2 <= nbre3 - 500;
        S3 <= "0101";
    elsif nbre3 < 700 then 
        nbre2 <= nbre3 - 600;
        S3 <= "0110";
    elsif nbre3 < 800 then 
        nbre2 <= nbre3 - 700;
        S3 <= "0111";
    elsif nbre3 < 900 then 
        nbre2 <= nbre3 - 800;
        S3 <= "1000";
    else
        nbre2 <= nbre3 - 900;
        S3 <= "1001";
    end if;
end process;

nb2 : process(nbre2)
begin
    if nbre2 < 10 then
        nbre1 <= nbre2;
        S2 <= "0000";
    elsif nbre2 < 20 then 
        nbre1 <= nbre2 - 10;
        S2 <= "0001";
    elsif nbre2 < 30 then
        nbre1 <= nbre2 - 20;
        S2 <= "0010";
    elsif nbre2 < 40 then
        nbre1 <= nbre2 - 30;
        S2 <= "0011";
    elsif nbre2 < 50 then
        nbre1 <= nbre2 - 40;
        S2 <= "0100";
    elsif nbre2 < 60 then
        nbre1 <= nbre2 - 50;
        S2 <= "0101";
    elsif nbre2 < 70 then 
        nbre1 <= nbre2 - 60;
        S2 <= "0110";
    elsif nbre2 < 80 then 
        nbre1 <= nbre2 - 70;
        S2 <= "0111";
    elsif nbre2 < 90 then 
        nbre1 <= nbre2 - 80;
        S2 <= "1000";
    else
        nbre1 <= nbre2 - 90;
        S2 <= "1001";
    end if;
end process;

nb1 : process (nbre1)
begin
      case nbre1 is
        when 0      => S1 <= "0000"; --0
        when 1      => S1 <= "0001"; --1
        when 2      => S1 <= "0010"; --2
        when 3      => S1 <= "0011"; --3
        when 4      => S1 <= "0100"; --4
        when 5      => S1 <= "0101"; --5
        when 6      => S1 <= "0110"; --6
        when 7      => S1 <= "0111"; --7
        when 8      => S1 <= "1000"; --8
        when others => S1 <= "1001"; --9
      end case;
end process;

nb_out <= S8 & S7 & S6 & S5 & S4 & S3 & S2 & S1;

end Behavioral;
