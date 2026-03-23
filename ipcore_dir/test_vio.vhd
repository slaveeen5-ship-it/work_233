-------------------------------------------------------------------------------
-- Copyright (c) 2026 Xilinx, Inc.
-- All Rights Reserved
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor     : Xilinx
-- \   \   \/     Version    : 14.7
--  \   \         Application: XILINX CORE Generator
--  /   /         Filename   : test_vio.vhd
-- /___/   /\     Timestamp  : Tue Mar 17 10:08:35 MSK 2026
-- \   \  /  \
--  \___\/\___\
--
-- Design Name: VHDL Synthesis Wrapper
-------------------------------------------------------------------------------
-- This wrapper is used to integrate with Project Navigator and PlanAhead

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY test_vio IS
  port (
    CONTROL: inout std_logic_vector(35 downto 0);
    ASYNC_IN: in std_logic_vector(7 downto 0);
    ASYNC_OUT: out std_logic_vector(0 to 0));
END test_vio;

ARCHITECTURE test_vio_a OF test_vio IS
BEGIN

END test_vio_a;
