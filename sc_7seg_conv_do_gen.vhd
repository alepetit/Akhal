-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2015.4
-- Copyright (C) 2015 Xilinx Inc. All rights reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sc_7seg_conv_do_gen is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    i_value : IN STD_LOGIC_VECTOR (31 downto 0);
    o_value : OUT STD_LOGIC_VECTOR (31 downto 0);
    o_value_ap_vld : OUT STD_LOGIC;
    iStart : IN STD_LOGIC );
end;


architecture behav of sc_7seg_conv_do_gen is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_st2_fsm_1 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000000000000010";
    constant ap_ST_st3_fsm_2 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000000000000100";
    constant ap_ST_st4_fsm_3 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000000000001000";
    constant ap_ST_st5_fsm_4 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000000000010000";
    constant ap_ST_st6_fsm_5 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000000000100000";
    constant ap_ST_st7_fsm_6 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000000001000000";
    constant ap_ST_st8_fsm_7 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000000010000000";
    constant ap_ST_st9_fsm_8 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000000100000000";
    constant ap_ST_st10_fsm_9 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000001000000000";
    constant ap_ST_st11_fsm_10 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000010000000000";
    constant ap_ST_st12_fsm_11 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000100000000000";
    constant ap_ST_st13_fsm_12 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000001000000000000";
    constant ap_ST_st14_fsm_13 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000010000000000000";
    constant ap_ST_st15_fsm_14 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000100000000000000";
    constant ap_ST_st16_fsm_15 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000001000000000000000";
    constant ap_ST_st17_fsm_16 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000010000000000000000";
    constant ap_ST_st18_fsm_17 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000100000000000000000";
    constant ap_ST_st19_fsm_18 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000001000000000000000000";
    constant ap_ST_st20_fsm_19 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000010000000000000000000";
    constant ap_ST_st21_fsm_20 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000100000000000000000000";
    constant ap_ST_st22_fsm_21 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000001000000000000000000000";
    constant ap_ST_st23_fsm_22 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000010000000000000000000000";
    constant ap_ST_st24_fsm_23 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000100000000000000000000000";
    constant ap_ST_st25_fsm_24 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000001000000000000000000000000";
    constant ap_ST_st26_fsm_25 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000010000000000000000000000000";
    constant ap_ST_st27_fsm_26 : STD_LOGIC_VECTOR (38 downto 0) := "000000000000100000000000000000000000000";
    constant ap_ST_st28_fsm_27 : STD_LOGIC_VECTOR (38 downto 0) := "000000000001000000000000000000000000000";
    constant ap_ST_st29_fsm_28 : STD_LOGIC_VECTOR (38 downto 0) := "000000000010000000000000000000000000000";
    constant ap_ST_st30_fsm_29 : STD_LOGIC_VECTOR (38 downto 0) := "000000000100000000000000000000000000000";
    constant ap_ST_st31_fsm_30 : STD_LOGIC_VECTOR (38 downto 0) := "000000001000000000000000000000000000000";
    constant ap_ST_st32_fsm_31 : STD_LOGIC_VECTOR (38 downto 0) := "000000010000000000000000000000000000000";
    constant ap_ST_st33_fsm_32 : STD_LOGIC_VECTOR (38 downto 0) := "000000100000000000000000000000000000000";
    constant ap_ST_st34_fsm_33 : STD_LOGIC_VECTOR (38 downto 0) := "000001000000000000000000000000000000000";
    constant ap_ST_st35_fsm_34 : STD_LOGIC_VECTOR (38 downto 0) := "000010000000000000000000000000000000000";
    constant ap_ST_st36_fsm_35 : STD_LOGIC_VECTOR (38 downto 0) := "000100000000000000000000000000000000000";
    constant ap_ST_st37_fsm_36 : STD_LOGIC_VECTOR (38 downto 0) := "001000000000000000000000000000000000000";
    constant ap_ST_st38_fsm_37 : STD_LOGIC_VECTOR (38 downto 0) := "010000000000000000000000000000000000000";
    constant ap_ST_st39_fsm_38 : STD_LOGIC_VECTOR (38 downto 0) := "100000000000000000000000000000000000000";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_lv32_26 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000100110";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv4_8 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_lv4_1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_const_lv32_A : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001010";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv32_1F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011111";
    constant ap_const_lv65_19999999A : STD_LOGIC_VECTOR (64 downto 0) := "00000000000000000000000000000000110011001100110011001100110011010";
    constant ap_const_lv32_24 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000100100";
    constant ap_const_lv32_40 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001000000";

    signal ap_CS_fsm : STD_LOGIC_VECTOR (38 downto 0) := "000000000000000000000000000000000000010";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_sig_cseq_ST_st3_fsm_2 : STD_LOGIC;
    signal ap_sig_bdd_58 : BOOLEAN;
    signal tmp_read_fu_98_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_fu_155_p2 : STD_LOGIC_VECTOR (3 downto 0);
    signal i_reg_220 : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_sig_cseq_ST_st4_fsm_3 : STD_LOGIC;
    signal ap_sig_bdd_73 : BOOLEAN;
    signal p_Result_s_reg_225 : STD_LOGIC_VECTOR (27 downto 0);
    signal exitcond_i_fu_149_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal value_V_assign_1_fu_197_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal value_V_assign_1_reg_235 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_sig_cseq_ST_st9_fsm_8 : STD_LOGIC;
    signal ap_sig_bdd_89 : BOOLEAN;
    signal res_V_fu_205_p3 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_sig_cseq_ST_st39_fsm_38 : STD_LOGIC;
    signal ap_sig_bdd_98 : BOOLEAN;
    signal grp_fu_161_ap_done : STD_LOGIC;
    signal p_Val2_s_reg_110 : STD_LOGIC_VECTOR (31 downto 0);
    signal value_assign_reg_122 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_0_i_reg_132 : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_fu_161_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal grp_fu_181_p0 : STD_LOGIC_VECTOR (33 downto 0);
    signal grp_fu_181_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_181_p2 : STD_LOGIC_VECTOR (64 downto 0);
    signal tmp_3_fu_187_p4 : STD_LOGIC_VECTOR (28 downto 0);
    signal grp_fu_161_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal unit_V_fu_201_p1 : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_fu_161_ap_start : STD_LOGIC;
    signal grp_fu_161_ce : STD_LOGIC;
    signal grp_fu_181_ce : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (38 downto 0);
    signal grp_fu_181_p10 : STD_LOGIC_VECTOR (64 downto 0);

    component sc_7seg_conv_urem_32ns_5ns_32_36_seq IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (4 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component sc_7seg_conv_mul_34ns_32ns_65_6 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (33 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (64 downto 0) );
    end component;



begin
    sc_7seg_conv_urem_32ns_5ns_32_36_seq_U0 : component sc_7seg_conv_urem_32ns_5ns_32_36_seq
    generic map (
        ID => 1,
        NUM_STAGE => 36,
        din0_WIDTH => 32,
        din1_WIDTH => 5,
        dout_WIDTH => 32)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        start => grp_fu_161_ap_start,
        done => grp_fu_161_ap_done,
        din0 => value_assign_reg_122,
        din1 => grp_fu_161_p1,
        ce => grp_fu_161_ce,
        dout => grp_fu_161_p2);

    sc_7seg_conv_mul_34ns_32ns_65_6_U1 : component sc_7seg_conv_mul_34ns_32ns_65_6
    generic map (
        ID => 1,
        NUM_STAGE => 6,
        din0_WIDTH => 34,
        din1_WIDTH => 32,
        dout_WIDTH => 65)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_181_p0,
        din1 => grp_fu_181_p1,
        ce => grp_fu_181_ce,
        dout => grp_fu_181_p2);





    -- the current state (ap_CS_fsm) of the state machine. --
    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_st2_fsm_1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    -- i_0_i_reg_132 assign process. --
    i_0_i_reg_132_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_sig_cseq_ST_st39_fsm_38) and not((ap_const_logic_0 = grp_fu_161_ap_done)))) then 
                i_0_i_reg_132 <= i_reg_220;
            elsif (((ap_const_logic_1 = ap_sig_cseq_ST_st3_fsm_2) and not((tmp_read_fu_98_p2 = ap_const_lv1_0)))) then 
                i_0_i_reg_132 <= ap_const_lv4_0;
            end if; 
        end if;
    end process;

    -- p_Val2_s_reg_110 assign process. --
    p_Val2_s_reg_110_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_sig_cseq_ST_st39_fsm_38) and not((ap_const_logic_0 = grp_fu_161_ap_done)))) then 
                p_Val2_s_reg_110 <= res_V_fu_205_p3;
            elsif (((ap_const_logic_1 = ap_sig_cseq_ST_st3_fsm_2) and not((tmp_read_fu_98_p2 = ap_const_lv1_0)))) then 
                p_Val2_s_reg_110 <= ap_const_lv32_0;
            end if; 
        end if;
    end process;

    -- value_assign_reg_122 assign process. --
    value_assign_reg_122_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_sig_cseq_ST_st39_fsm_38) and not((ap_const_logic_0 = grp_fu_161_ap_done)))) then 
                value_assign_reg_122 <= value_V_assign_1_reg_235;
            elsif (((ap_const_logic_1 = ap_sig_cseq_ST_st3_fsm_2) and not((tmp_read_fu_98_p2 = ap_const_lv1_0)))) then 
                value_assign_reg_122 <= i_value;
            end if; 
        end if;
    end process;

    -- assign process. --
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_sig_cseq_ST_st4_fsm_3)) then
                i_reg_220 <= i_fu_155_p2;
            end if;
        end if;
    end process;

    -- assign process. --
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_sig_cseq_ST_st4_fsm_3) and (ap_const_lv1_0 = exitcond_i_fu_149_p2))) then
                p_Result_s_reg_225 <= p_Val2_s_reg_110(31 downto 4);
            end if;
        end if;
    end process;

    -- assign process. --
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_sig_cseq_ST_st9_fsm_8)) then
                    value_V_assign_1_reg_235(28 downto 0) <= value_V_assign_1_fu_197_p1(28 downto 0);
            end if;
        end if;
    end process;
    value_V_assign_1_reg_235(31 downto 29) <= "000";

    -- the next state (ap_NS_fsm) of the state machine. --
    ap_NS_fsm_assign_proc : process (ap_CS_fsm, tmp_read_fu_98_p2, exitcond_i_fu_149_p2, grp_fu_161_ap_done)
    begin
        case ap_CS_fsm is
            when ap_ST_st2_fsm_1 => 
                ap_NS_fsm <= ap_ST_st3_fsm_2;
            when ap_ST_st3_fsm_2 => 
                if (not((tmp_read_fu_98_p2 = ap_const_lv1_0))) then
                    ap_NS_fsm <= ap_ST_st4_fsm_3;
                else
                    ap_NS_fsm <= ap_ST_st3_fsm_2;
                end if;
            when ap_ST_st4_fsm_3 => 
                if (not((ap_const_lv1_0 = exitcond_i_fu_149_p2))) then
                    ap_NS_fsm <= ap_ST_st3_fsm_2;
                else
                    ap_NS_fsm <= ap_ST_st5_fsm_4;
                end if;
            when ap_ST_st5_fsm_4 => 
                ap_NS_fsm <= ap_ST_st6_fsm_5;
            when ap_ST_st6_fsm_5 => 
                ap_NS_fsm <= ap_ST_st7_fsm_6;
            when ap_ST_st7_fsm_6 => 
                ap_NS_fsm <= ap_ST_st8_fsm_7;
            when ap_ST_st8_fsm_7 => 
                ap_NS_fsm <= ap_ST_st9_fsm_8;
            when ap_ST_st9_fsm_8 => 
                ap_NS_fsm <= ap_ST_st10_fsm_9;
            when ap_ST_st10_fsm_9 => 
                ap_NS_fsm <= ap_ST_st11_fsm_10;
            when ap_ST_st11_fsm_10 => 
                ap_NS_fsm <= ap_ST_st12_fsm_11;
            when ap_ST_st12_fsm_11 => 
                ap_NS_fsm <= ap_ST_st13_fsm_12;
            when ap_ST_st13_fsm_12 => 
                ap_NS_fsm <= ap_ST_st14_fsm_13;
            when ap_ST_st14_fsm_13 => 
                ap_NS_fsm <= ap_ST_st15_fsm_14;
            when ap_ST_st15_fsm_14 => 
                ap_NS_fsm <= ap_ST_st16_fsm_15;
            when ap_ST_st16_fsm_15 => 
                ap_NS_fsm <= ap_ST_st17_fsm_16;
            when ap_ST_st17_fsm_16 => 
                ap_NS_fsm <= ap_ST_st18_fsm_17;
            when ap_ST_st18_fsm_17 => 
                ap_NS_fsm <= ap_ST_st19_fsm_18;
            when ap_ST_st19_fsm_18 => 
                ap_NS_fsm <= ap_ST_st20_fsm_19;
            when ap_ST_st20_fsm_19 => 
                ap_NS_fsm <= ap_ST_st21_fsm_20;
            when ap_ST_st21_fsm_20 => 
                ap_NS_fsm <= ap_ST_st22_fsm_21;
            when ap_ST_st22_fsm_21 => 
                ap_NS_fsm <= ap_ST_st23_fsm_22;
            when ap_ST_st23_fsm_22 => 
                ap_NS_fsm <= ap_ST_st24_fsm_23;
            when ap_ST_st24_fsm_23 => 
                ap_NS_fsm <= ap_ST_st25_fsm_24;
            when ap_ST_st25_fsm_24 => 
                ap_NS_fsm <= ap_ST_st26_fsm_25;
            when ap_ST_st26_fsm_25 => 
                ap_NS_fsm <= ap_ST_st27_fsm_26;
            when ap_ST_st27_fsm_26 => 
                ap_NS_fsm <= ap_ST_st28_fsm_27;
            when ap_ST_st28_fsm_27 => 
                ap_NS_fsm <= ap_ST_st29_fsm_28;
            when ap_ST_st29_fsm_28 => 
                ap_NS_fsm <= ap_ST_st30_fsm_29;
            when ap_ST_st30_fsm_29 => 
                ap_NS_fsm <= ap_ST_st31_fsm_30;
            when ap_ST_st31_fsm_30 => 
                ap_NS_fsm <= ap_ST_st32_fsm_31;
            when ap_ST_st32_fsm_31 => 
                ap_NS_fsm <= ap_ST_st33_fsm_32;
            when ap_ST_st33_fsm_32 => 
                ap_NS_fsm <= ap_ST_st34_fsm_33;
            when ap_ST_st34_fsm_33 => 
                ap_NS_fsm <= ap_ST_st35_fsm_34;
            when ap_ST_st35_fsm_34 => 
                ap_NS_fsm <= ap_ST_st36_fsm_35;
            when ap_ST_st36_fsm_35 => 
                ap_NS_fsm <= ap_ST_st37_fsm_36;
            when ap_ST_st37_fsm_36 => 
                ap_NS_fsm <= ap_ST_st38_fsm_37;
            when ap_ST_st38_fsm_37 => 
                ap_NS_fsm <= ap_ST_st39_fsm_38;
            when ap_ST_st39_fsm_38 => 
                if (not((ap_const_logic_0 = grp_fu_161_ap_done))) then
                    ap_NS_fsm <= ap_ST_st4_fsm_3;
                else
                    ap_NS_fsm <= ap_ST_st39_fsm_38;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end case;
    end process;

    -- ap_sig_bdd_58 assign process. --
    ap_sig_bdd_58_assign_proc : process(ap_CS_fsm)
    begin
                ap_sig_bdd_58 <= (ap_CS_fsm(2 downto 2) = ap_const_lv1_1);
    end process;


    -- ap_sig_bdd_73 assign process. --
    ap_sig_bdd_73_assign_proc : process(ap_CS_fsm)
    begin
                ap_sig_bdd_73 <= (ap_const_lv1_1 = ap_CS_fsm(3 downto 3));
    end process;


    -- ap_sig_bdd_89 assign process. --
    ap_sig_bdd_89_assign_proc : process(ap_CS_fsm)
    begin
                ap_sig_bdd_89 <= (ap_const_lv1_1 = ap_CS_fsm(8 downto 8));
    end process;


    -- ap_sig_bdd_98 assign process. --
    ap_sig_bdd_98_assign_proc : process(ap_CS_fsm)
    begin
                ap_sig_bdd_98 <= (ap_const_lv1_1 = ap_CS_fsm(38 downto 38));
    end process;


    -- ap_sig_cseq_ST_st39_fsm_38 assign process. --
    ap_sig_cseq_ST_st39_fsm_38_assign_proc : process(ap_sig_bdd_98)
    begin
        if (ap_sig_bdd_98) then 
            ap_sig_cseq_ST_st39_fsm_38 <= ap_const_logic_1;
        else 
            ap_sig_cseq_ST_st39_fsm_38 <= ap_const_logic_0;
        end if; 
    end process;


    -- ap_sig_cseq_ST_st3_fsm_2 assign process. --
    ap_sig_cseq_ST_st3_fsm_2_assign_proc : process(ap_sig_bdd_58)
    begin
        if (ap_sig_bdd_58) then 
            ap_sig_cseq_ST_st3_fsm_2 <= ap_const_logic_1;
        else 
            ap_sig_cseq_ST_st3_fsm_2 <= ap_const_logic_0;
        end if; 
    end process;


    -- ap_sig_cseq_ST_st4_fsm_3 assign process. --
    ap_sig_cseq_ST_st4_fsm_3_assign_proc : process(ap_sig_bdd_73)
    begin
        if (ap_sig_bdd_73) then 
            ap_sig_cseq_ST_st4_fsm_3 <= ap_const_logic_1;
        else 
            ap_sig_cseq_ST_st4_fsm_3 <= ap_const_logic_0;
        end if; 
    end process;


    -- ap_sig_cseq_ST_st9_fsm_8 assign process. --
    ap_sig_cseq_ST_st9_fsm_8_assign_proc : process(ap_sig_bdd_89)
    begin
        if (ap_sig_bdd_89) then 
            ap_sig_cseq_ST_st9_fsm_8 <= ap_const_logic_1;
        else 
            ap_sig_cseq_ST_st9_fsm_8 <= ap_const_logic_0;
        end if; 
    end process;

    exitcond_i_fu_149_p2 <= "1" when (i_0_i_reg_132 = ap_const_lv4_8) else "0";

    -- grp_fu_161_ap_start assign process. --
    grp_fu_161_ap_start_assign_proc : process(ap_sig_cseq_ST_st4_fsm_3, exitcond_i_fu_149_p2)
    begin
        if (((ap_const_logic_1 = ap_sig_cseq_ST_st4_fsm_3) and (ap_const_lv1_0 = exitcond_i_fu_149_p2))) then 
            grp_fu_161_ap_start <= ap_const_logic_1;
        else 
            grp_fu_161_ap_start <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_161_ce <= ap_const_logic_1;
    grp_fu_161_p1 <= ap_const_lv32_A(5 - 1 downto 0);
    grp_fu_181_ce <= ap_const_logic_1;
    grp_fu_181_p0 <= ap_const_lv65_19999999A(34 - 1 downto 0);
    grp_fu_181_p1 <= grp_fu_181_p10(32 - 1 downto 0);
    grp_fu_181_p10 <= std_logic_vector(resize(unsigned(value_assign_reg_122),65));
    i_fu_155_p2 <= std_logic_vector(unsigned(i_0_i_reg_132) + unsigned(ap_const_lv4_1));
    o_value <= p_Val2_s_reg_110;

    -- o_value_ap_vld assign process. --
    o_value_ap_vld_assign_proc : process(ap_sig_cseq_ST_st4_fsm_3, exitcond_i_fu_149_p2)
    begin
        if (((ap_const_logic_1 = ap_sig_cseq_ST_st4_fsm_3) and not((ap_const_lv1_0 = exitcond_i_fu_149_p2)))) then 
            o_value_ap_vld <= ap_const_logic_1;
        else 
            o_value_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    res_V_fu_205_p3 <= (unit_V_fu_201_p1 & p_Result_s_reg_225);
    tmp_3_fu_187_p4 <= grp_fu_181_p2(64 downto 36);
    tmp_read_fu_98_p2 <= (0=>iStart, others=>'-');
    unit_V_fu_201_p1 <= grp_fu_161_p2(4 - 1 downto 0);
    value_V_assign_1_fu_197_p1 <= std_logic_vector(resize(unsigned(tmp_3_fu_187_p4),32));
end behav;
