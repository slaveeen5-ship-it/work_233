-------------------------------------------------------------------------------
-- Copyright (c) 2026 Xilinx, Inc.
-- All Rights Reserved
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor     : Xilinx
-- \   \   \/     Version    : 14.7
--  \   \         Application: XILINX CORE Generator
--  /   /         Filename   : ila_test.vhd
-- /___/   /\     Timestamp  : Fri Mar 13 15:49:15 MSK 2026
-- \   \  /  \
--  \___\/\___\
--
-- Design Name: VHDL Synthesis Wrapper
-------------------------------------------------------------------------------
-- This wrapper is used to integrate with Project Navigator and PlanAhead

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY ila_test IS
  port (
    CONTROL: inout std_logic_vector(35 downto 0);
    CLK: in std_logic;
    DATA: in std_logic_vector(15 downto 0);
    TRIG0: in std_logic_vector(7 downto 0);
    TRIG1: in std_logic_vector(7 downto 0));
END ila_test;

ARCHITECTURE ila_test_a OF ila_test IS
BEGIN

END ila_test_a;
