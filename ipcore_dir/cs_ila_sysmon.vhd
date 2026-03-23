-------------------------------------------------------------------------------
-- Copyright (c) 2026 Xilinx, Inc.
-- All Rights Reserved
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor     : Xilinx
-- \   \   \/     Version    : 14.7
--  \   \         Application: XILINX CORE Generator
--  /   /         Filename   : cs_ila_sysmon.vhd
-- /___/   /\     Timestamp  : Fri Mar 06 16:21:30 MSK 2026
-- \   \  /  \
--  \___\/\___\
--
-- Design Name: VHDL Synthesis Wrapper
-------------------------------------------------------------------------------
-- This wrapper is used to integrate with Project Navigator and PlanAhead

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY cs_ila_sysmon IS
  port (
    CONTROL: inout std_logic_vector(35 downto 0);
    CLK: in std_logic;
    DATA: in std_logic_vector(31 downto 0);
    TRIG0: in std_logic_vector(7 downto 0));
END cs_ila_sysmon;

ARCHITECTURE cs_ila_sysmon_a OF cs_ila_sysmon IS
BEGIN

END cs_ila_sysmon_a;
