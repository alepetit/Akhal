----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2017 09:35:52
-- Design Name: 
-- Module Name: transcod2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity transcod2 is
    Port ( vect_hls : in STD_LOGIC_VECTOR (31 downto 0);
           S1 : out STD_LOGIC_VECTOR (6 downto 0);
           S2 : out STD_LOGIC_VECTOR (6 downto 0);
           S3 : out STD_LOGIC_VECTOR (6 downto 0);
           S4 : out STD_LOGIC_VECTOR (6 downto 0);
           S5 : out STD_LOGIC_VECTOR (6 downto 0);
           S6 : out STD_LOGIC_VECTOR (6 downto 0);
           S7 : out STD_LOGIC_VECTOR (6 downto 0);
           S8 : out STD_LOGIC_VECTOR (6 downto 0));
end transcod2;

architecture Behavioral of transcod2 is

signal t1, t2, t3, t4, t5, t6, t7, t8 : std_logic_vector(3 downto 0);

begin

t1 <= vect_hls(3 downto 0);
t2 <= vect_hls(7 downto 4);                              
t3 <= vect_hls(11 downto 8);
t4 <= vect_hls(15 downto 12);
t5 <= vect_hls(19 downto 16);
t6 <= vect_hls(23 downto 20);
t7 <= vect_hls(27 downto 24);
t8 <= vect_hls(31 downto 28);

--t1(0) <= vect_hls(0);
--t1(1) <= vect_hls(1);
--t1(2) <= vect_hls(2);
--t1(3) <= vect_hls(3);

--t2(0) <= vect_hls(4);
--t2(1) <= vect_hls(5);
--t2(2) <= vect_hls(6);
--t2(3) <= vect_hls(7);

--t3(0) <= vect_hls(8);
--t3(1) <= vect_hls(9);
--t3(2) <= vect_hls(10);
--t3(3) <= vect_hls(11);

--t4(0) <= vect_hls(12);
--t4(1) <= vect_hls(13);
--t4(2) <= vect_hls(14);
--t4(3) <= vect_hls(15);

--t5(0) <= vect_hls(16);
--t5(1) <= vect_hls(17);
--t5(2) <= vect_hls(18);
--t5(3) <= vect_hls(19);

--t6(0) <= vect_hls(20);
--t6(1) <= vect_hls(21);
--t6(2) <= vect_hls(22);
--t6(3) <= vect_hls(23);

--t7(0) <= vect_hls(24);
--t7(1) <= vect_hls(25);
--t7(2) <= vect_hls(26);
--t7(3) <= vect_hls(27);

--t8(0) <= vect_hls(28);
--t8(1) <= vect_hls(29);
--t8(2) <= vect_hls(30);
--t8(3) <= vect_hls(31);

process (t1)
begin
      case t1 is
        when "0000" => S1 <= "0000001"; --0
        when "0001" => S1 <= "1001111"; --1
        when "0010" => S1 <= "0010010"; --2
        when "0011" => S1 <= "0000110"; --3
        when "0100" => S1 <= "1001100"; --4
        when "0101" => S1 <= "0100100"; --5
        when "0110" => S1 <= "0100000"; --6
        when "0111" => S1 <= "0001111"; --7
        when "1000" => S1 <= "0000000"; --8
        when "1001" => S1 <= "0000100"; --9
        when others => S1 <= "1111110";
      end case;
end process;

process (t2)
begin
      case t2 is
        when "0000" => S2 <= "0000001"; --0
        when "0001" => S2 <= "1001111"; --1
        when "0010" => S2 <= "0010010"; --2
        when "0011" => S2 <= "0000110"; --3
        when "0100" => S2 <= "1001100"; --4
        when "0101" => S2 <= "0100100"; --5
        when "0110" => S2 <= "0100000"; --6
        when "0111" => S2 <= "0001111"; --7
        when "1000" => S2 <= "0000000"; --8
        when "1001" => S2 <= "0000100"; --9
        when others => S2 <= "1111110";
      end case;
end process;

process (t3)
begin
      case t3 is
        when "0000" => S3 <= "0000001"; --0
        when "0001" => S3 <= "1001111"; --1
        when "0010" => S3 <= "0010010"; --2
        when "0011" => S3 <= "0000110"; --3
        when "0100" => S3 <= "1001100"; --4
        when "0101" => S3 <= "0100100"; --5
        when "0110" => S3 <= "0100000"; --6
        when "0111" => S3 <= "0001111"; --7
        when "1000" => S3 <= "0000000"; --8
        when "1001" => S3 <= "0000100"; --9
        when others => S3 <= "1111110";
      end case;
end process;

process (t4)
begin
      case t4 is
        when "0000" => S4 <= "0000001"; --0
        when "0001" => S4 <= "1001111"; --1
        when "0010" => S4 <= "0010010"; --2
        when "0011" => S4 <= "0000110"; --3
        when "0100" => S4 <= "1001100"; --4
        when "0101" => S4 <= "0100100"; --5
        when "0110" => S4 <= "0100000"; --6
        when "0111" => S4 <= "0001111"; --7
        when "1000" => S4 <= "0000000"; --8
        when "1001" => S4 <= "0000100"; --9
        when others => S4 <= "1111110";
      end case;
end process;

process (t5)
begin
      case t5 is
        when "0000" => S5 <= "0000001"; --0
        when "0001" => S5 <= "1001111"; --1
        when "0010" => S5 <= "0010010"; --2
        when "0011" => S5 <= "0000110"; --3
        when "0100" => S5 <= "1001100"; --4
        when "0101" => S5 <= "0100100"; --5
        when "0110" => S5 <= "0100000"; --6
        when "0111" => S5 <= "0001111"; --7
        when "1000" => S5 <= "0000000"; --8
        when "1001" => S5 <= "0000100"; --9
        when others => S5 <= "1111110";
      end case;
end process;

process (t6)
begin
      case t6 is
        when "0000" => S6 <= "0000001"; --0
        when "0001" => S6 <= "1001111"; --1
        when "0010" => S6 <= "0010010"; --2
        when "0011" => S6 <= "0000110"; --3
        when "0100" => S6 <= "1001100"; --4
        when "0101" => S6 <= "0100100"; --5
        when "0110" => S6 <= "0100000"; --6
        when "0111" => S6 <= "0001111"; --7
        when "1000" => S6 <= "0000000"; --8
        when "1001" => S6 <= "0000100"; --9
        when others => S6 <= "1111110";
      end case;
end process;

process (t7)
begin
      case t7 is
        when "0000" => S7 <= "0000001"; --0
        when "0001" => S7 <= "1001111"; --1
        when "0010" => S7 <= "0010010"; --2
        when "0011" => S7 <= "0000110"; --3
        when "0100" => S7 <= "1001100"; --4
        when "0101" => S7 <= "0100100"; --5
        when "0110" => S7 <= "0100000"; --6
        when "0111" => S7 <= "0001111"; --7
        when "1000" => S7 <= "0000000"; --8
        when "1001" => S7 <= "0000100"; --9
        when others => S7 <= "1111110";
      end case;
end process;

process (t8)
begin
      case t8 is
        when "0000" => S8 <= "0000001"; --0
        when "0001" => S8 <= "1001111"; --1
        when "0010" => S8 <= "0010010"; --2
        when "0011" => S8 <= "0000110"; --3
        when "0100" => S8 <= "1001100"; --4
        when "0101" => S8 <= "0100100"; --5
        when "0110" => S8 <= "0100000"; --6
        when "0111" => S8 <= "0001111"; --7
        when "1000" => S8 <= "0000000"; --8
        when "1001" => S8 <= "0000100"; --9
        when others => S8 <= "1111110";
      end case;
end process;

end Behavioral;
