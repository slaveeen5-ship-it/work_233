-------------------------------------------------------------------------------
-- Copyright (c) 2026 Xilinx, Inc.
-- All Rights Reserved
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor     : Xilinx
-- \   \   \/     Version    : 14.7
--  \   \         Application: XILINX CORE Generator
--  /   /         Filename   : Ibert_my.vhd
-- /___/   /\     Timestamp  : Fri Mar 06 16:32:58 MSK 2026
-- \   \  /  \
--  \___\/\___\
--
-- Design Name: VHDL Synthesis Wrapper
-------------------------------------------------------------------------------
-- This wrapper is used to integrate with Project Navigator and PlanAhead

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY Ibert_my IS
  port (
    X0Y0_TX_P_OPAD: out std_logic;
    X0Y0_TX_N_OPAD: out std_logic;
    X0Y1_TX_P_OPAD: out std_logic;
    X0Y1_TX_N_OPAD: out std_logic;
    X0Y2_TX_P_OPAD: out std_logic;
    X0Y2_TX_N_OPAD: out std_logic;
    X0Y3_TX_P_OPAD: out std_logic;
    X0Y3_TX_N_OPAD: out std_logic;
    X0Y0_RXRECCLK_O: out std_logic;
    X1Y24_TX_P_OPAD: out std_logic;
    X1Y24_TX_N_OPAD: out std_logic;
    X1Y25_TX_P_OPAD: out std_logic;
    X1Y25_TX_N_OPAD: out std_logic;
    X1Y26_TX_P_OPAD: out std_logic;
    X1Y26_TX_N_OPAD: out std_logic;
    X1Y27_TX_P_OPAD: out std_logic;
    X1Y27_TX_N_OPAD: out std_logic;
    X1Y28_TX_P_OPAD: out std_logic;
    X1Y28_TX_N_OPAD: out std_logic;
    X1Y29_TX_P_OPAD: out std_logic;
    X1Y29_TX_N_OPAD: out std_logic;
    X1Y30_TX_P_OPAD: out std_logic;
    X1Y30_TX_N_OPAD: out std_logic;
    X1Y31_TX_P_OPAD: out std_logic;
    X1Y31_TX_N_OPAD: out std_logic;
    X1Y32_TX_P_OPAD: out std_logic;
    X1Y32_TX_N_OPAD: out std_logic;
    X1Y33_TX_P_OPAD: out std_logic;
    X1Y33_TX_N_OPAD: out std_logic;
    X1Y34_TX_P_OPAD: out std_logic;
    X1Y34_TX_N_OPAD: out std_logic;
    X1Y35_TX_P_OPAD: out std_logic;
    X1Y35_TX_N_OPAD: out std_logic;
    X1Y24_RXRECCLK_O: out std_logic;
    X1Y25_RXRECCLK_O: out std_logic;
    X1Y26_RXRECCLK_O: out std_logic;
    X1Y27_RXRECCLK_O: out std_logic;
    X1Y28_RXRECCLK_O: out std_logic;
    X1Y29_RXRECCLK_O: out std_logic;
    X1Y30_RXRECCLK_O: out std_logic;
    X1Y31_RXRECCLK_O: out std_logic;
    X1Y32_RXRECCLK_O: out std_logic;
    X1Y33_RXRECCLK_O: out std_logic;
    X1Y34_RXRECCLK_O: out std_logic;
    X1Y35_RXRECCLK_O: out std_logic;
    CONTROL: inout std_logic_vector(35 downto 0);
    X0Y0_RX_P_IPAD: in std_logic;
    X0Y0_RX_N_IPAD: in std_logic;
    X0Y1_RX_P_IPAD: in std_logic;
    X0Y1_RX_N_IPAD: in std_logic;
    X0Y2_RX_P_IPAD: in std_logic;
    X0Y2_RX_N_IPAD: in std_logic;
    X0Y3_RX_P_IPAD: in std_logic;
    X0Y3_RX_N_IPAD: in std_logic;
    X1Y24_RX_P_IPAD: in std_logic;
    X1Y24_RX_N_IPAD: in std_logic;
    X1Y25_RX_P_IPAD: in std_logic;
    X1Y25_RX_N_IPAD: in std_logic;
    X1Y26_RX_P_IPAD: in std_logic;
    X1Y26_RX_N_IPAD: in std_logic;
    X1Y27_RX_P_IPAD: in std_logic;
    X1Y27_RX_N_IPAD: in std_logic;
    X1Y28_RX_P_IPAD: in std_logic;
    X1Y28_RX_N_IPAD: in std_logic;
    X1Y29_RX_P_IPAD: in std_logic;
    X1Y29_RX_N_IPAD: in std_logic;
    X1Y30_RX_P_IPAD: in std_logic;
    X1Y30_RX_N_IPAD: in std_logic;
    X1Y31_RX_P_IPAD: in std_logic;
    X1Y31_RX_N_IPAD: in std_logic;
    X1Y32_RX_P_IPAD: in std_logic;
    X1Y32_RX_N_IPAD: in std_logic;
    X1Y33_RX_P_IPAD: in std_logic;
    X1Y33_RX_N_IPAD: in std_logic;
    X1Y34_RX_P_IPAD: in std_logic;
    X1Y34_RX_N_IPAD: in std_logic;
    X1Y35_RX_P_IPAD: in std_logic;
    X1Y35_RX_N_IPAD: in std_logic;
    Q1_CLK1_MGTREFCLK_I: in std_logic;
    IBERT_SYSCLOCK_I: in std_logic);
END Ibert_my;

ARCHITECTURE Ibert_my_a OF Ibert_my IS
BEGIN

END Ibert_my_a;
