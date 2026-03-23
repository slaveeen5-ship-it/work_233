--! @file
--! @brief Частотный блок
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

--! @brief Частотный блок
--! 
--! @details Компонент принимает входные частоты, буферизирует их, а затем подаёт
--!          их на примитив MMCM для формирования новых частот. Также компонент
--!          формирует сигнал сброса для других компонентов
--! 
--! @param[in] sys_clk_p,sys_clk_n,ref_clk_p,ref_clk_n,mgt_clk_p,mgt_clk_n -
--!            дифференциальные тактовые частоты
--! @param[out] cpu_clk,sys_clk,ref_clk,math_clk,mgt_clk - выходная шина тактовых частот
--! @param[out] sys_rst - выходной сигнал сброса
entity clock_block is
generic (
    SIMULATION         : integer   := 0          -- Set to 1 for simulation
);
   Port (
      sys_clk_p      : in STD_LOGIC;  -- 100 Mhz
      sys_clk_n      : in STD_LOGIC;  -- 100 Mhz
      -- ref_clk_p      : in STD_LOGIC;  -- 200 Mhz
      -- ref_clk_n      : in STD_LOGIC;  -- 200 Mhz
      mgt_clk_p      : in STD_LOGIC;  -- 125 Mhz
      mgt_clk_n      : in STD_LOGIC;  -- 125 Mhz

      -- cpu_clk        : out STD_LOGIC;
      sys_clk        : out STD_LOGIC;
      sys_rst        : out STD_LOGIC;
      -- ref_clk        : out STD_LOGIC;
      -- math_clk       : out STD_LOGIC
      mgt_clk        : out STD_LOGIC
   );
end clock_block;

architecture Behavioral of clock_block is

signal   sys_clk_ibufds    : std_logic := '0';
signal   sys_clk_fb        : std_logic := '0';
signal   sys_clk_out       : std_logic := '0';
signal   sys_clk_tmp       : std_logic := '0';
signal   sys_rst_tmp       : std_logic := '0';

-- signal   ref_clk_ibufg     : std_logic := '0';
-- signal   ref_clk_tmp       : std_logic := '0';

signal   math_clk_out      : std_logic := '0';
signal   math_clk_tmp      : std_logic := '0';

begin

   -- Input buffering
   mgt_clk_ibufds : IBUFDS_GTXE1
   port map
   (
      I  => mgt_clk_p,
      IB => mgt_clk_n,
      O  => mgt_clk,
      CEB => '0'
   );
   
   sys_clk_ibufds_i : IBUFDS
   generic map (
      DIFF_TERM => TRUE, -- Differential Termination 
      IBUF_LOW_PWR => FALSE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD => "DEFAULT")
   port map (
      O => sys_clk_ibufds,  -- Buffer output
      I => sys_clk_p,  -- Diff_p buffer input (connect directly to top-level port)
      IB => sys_clk_n -- Diff_n buffer input (connect directly to top-level port)
   );
   --
   -- ref_clk_ibufds_i : IBUFGDS 
   -- generic map (
   --    DIFF_TERM => TRUE, -- Differential Termination 
   --    IBUF_LOW_PWR => FALSE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
   --    IOSTANDARD => "DEFAULT")
   -- port map( 
   --    I => ref_clk_p,
   --    IB=> ref_clk_n,
   --    O => ref_clk_ibufg
   -- ); 

  -- Clocking PRIMITIVE
  --------------------------------------
  
   MMCM_BASE_inst : MMCM_BASE
   generic map (
      BANDWIDTH => "OPTIMIZED",  -- Jitter programming ("HIGH","LOW","OPTIMIZED")
      CLKFBOUT_MULT_F => 10.0,    -- Multiply value for all CLKOUT (5.0-64.0).
      CLKFBOUT_PHASE => 0.0,     -- Phase offset in degrees of CLKFB (0.00-360.00).
      CLKIN1_PERIOD => 10.000,      -- Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      CLKOUT0_DIVIDE_F => 15.0,   -- Divide amount for CLKOUT0 (1.000-128.000).
      -- CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      CLKOUT0_DUTY_CYCLE => 0.5,
      CLKOUT1_DUTY_CYCLE => 0.5,
      -- CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      CLKOUT0_PHASE => 0.0,
      CLKOUT1_PHASE => 0.0,
      -- CLKOUT1_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      CLKOUT1_DIVIDE => 5,
      CLKOUT4_CASCADE => FALSE,  -- Cascase CLKOUT4 counter with CLKOUT6 (TRUE/FALSE)
      CLOCK_HOLD => FALSE,       -- Hold VCO Frequency (TRUE/FALSE)
      DIVCLK_DIVIDE => 1,        -- Master division value (1-80)
      REF_JITTER1 => 0.05,        -- Reference input jitter in UI (0.000-0.999).
      STARTUP_WAIT => FALSE      -- Not supported. Must be set to FALSE.
   )
   port map (
      -- Clock Outputs: 1-bit (each) output: User configurable clock outputs
      CLKOUT0 => sys_clk_out,     -- 1-bit output: CLKOUT0 output
      CLKOUT0B => open,   -- 1-bit output: Inverted CLKOUT0 output
      CLKOUT1 => math_clk_out,     -- 1-bit output: CLKOUT1 output
      CLKOUT1B => open,   -- 1-bit output: Inverted CLKOUT1 output
      -- Feedback Clocks: 1-bit (each) output: Clock feedback ports
      CLKFBOUT => sys_clk_fb,   -- 1-bit output: Feedback clock output
      CLKFBOUTB => open, -- 1-bit output: Inverted CLKFBOUT output
      -- Status Port: 1-bit (each) output: MMCM status ports
      LOCKED => open,       -- 1-bit output: LOCK output
      -- Clock Input: 1-bit (each) input: Clock input
      CLKIN1 => sys_clk_ibufds,
      -- Control Ports: 1-bit (each) input: MMCM control ports
      PWRDWN => '0',       -- 1-bit input: Power-down input
      RST => '0',             -- 1-bit input: Reset input
      -- Feedback Clocks: 1-bit (each) input: Clock feedback ports
      CLKFBIN => sys_clk_fb      -- 1-bit input: Feedback clock input
   );
 
  -- Output buffering
  -------------------------------------
  sys_clk_bufg_i : BUFG
  port map (
     O => sys_clk_tmp, -- 1-bit output: Clock output
     I => sys_clk_out  -- 1-bit input: Clock input
  );

  
  sys_clk   <= sys_clk_tmp;   
    
  math_clk_bufg_i : BUFG
  port map (
     O => math_clk_tmp, -- 1-bit output: Clock output
     I => math_clk_out  -- 1-bit input: Clock input
  );

  -- math_clk  <= math_clk_tmp;  
  
  -- ref_clk_bufg_i : BUFG
  -- port map (
  --    O => ref_clk_tmp, -- 1-bit output: Clock output
  --    I => ref_clk_ibufg  -- 1-bit input: Clock input
  -- );

  -- ref_clk   <= ref_clk_tmp;   
    
  -- Output reset
  -----------------------------------
   SRL16_sys_rst_i : SRL16
   generic map (
      INIT => X"00FF")
   port map (
      Q => sys_rst_tmp, -- SRL data output
      A0 => '1',      -- Select[0] input
      A1 => '1',      -- Select[1] input
      A2 => '1',      -- Select[2] input
      A3 => '1',      -- Select[3] input
      CLK => sys_clk_tmp,     -- Clock input
      D => '0'        -- SRL data input
   );
   
   sys_rst  <= sys_rst_tmp;
   
  -- CPU clock
  -----------------------------------  
  -- cpu_clk   <= sys_clk_ibufds;

end Behavioral;
