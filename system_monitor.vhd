--! @file
--! @brief Системный монитор
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

--! @brief Системный монитор
--! 
--! @details Компонент осуществляет слежение за температурой, а также выдаёт
--!          значение температуры на чипскоп.
--! 
--! @param[in] sys_clk - тактовая частота
--! @param[in] sys_rst - системный сброс
--! @param[out] sys_temp - шина температуры
--! @param[out] sys_debug_cs0 - шина чипскопа
entity system_monitor is
  Port (
    sys_clk       : in      STD_LOGIC; -- 8..80 MHz
    sys_rst       : in      STD_LOGIC;
    sys_temp      : out     STD_LOGIC_VECTOR(9 downto 0);
    sys_debug_cs0 : inout   STD_LOGIC_VECTOR(35 downto 0)
  );
end system_monitor;

architecture Behavioral of system_monitor is

    component sys_mon
    port (
        DADDR_IN            : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
        DCLK_IN             : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
        DEN_IN              : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
        DI_IN               : in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
        DWE_IN              : in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
        DO_OUT              : out STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
        DRDY_OUT            : out STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
        VP_IN               : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
        VN_IN               : in  STD_LOGIC
    );
    end component;

    signal  drp_clk       : std_logic;
    signal  drp_rst       : std_logic;
    signal  drp_en        : std_logic;
    signal  drp_wr        : std_logic;
    signal  drp_rdy       : std_logic;
    signal  drp_addr      : std_logic_vector(6 downto 0);
    signal  drp_cnt       : std_logic_vector(11 downto 0):= (others => '0');
    signal  drp_din       : std_logic_vector(15 downto 0);
    signal  drp_dout      : std_logic_vector(15 downto 0);
    signal  drp_temp      : std_logic_vector(9 downto 0);

    component cs_ila_sysmon
    port (
        CONTROL   : INOUT   STD_LOGIC_VECTOR(35 DOWNTO 0);
        CLK       : IN      STD_LOGIC;
        DATA      : IN      STD_LOGIC_VECTOR(31 DOWNTO 0);
        TRIG0     : IN      STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    end component;

    signal  cs_trig     : std_logic_vector(7 downto 0)  := (others => '0');
    signal  cs_data     : std_logic_vector(31 downto 0) := (others => '0');




BEGIN

    drp_clk  <= sys_clk;
    drp_rst  <= sys_rst;
    drp_wr   <= '0';
    drp_addr <= "0000000";
    drp_din  <= x"0000";

    sysmon_i : sys_mon
    port map (
        DADDR_IN            => drp_addr, 
        DCLK_IN             => drp_clk, 
        DEN_IN              => drp_en, 
        DI_IN               => drp_din,
        DWE_IN              => drp_wr, 
        DO_OUT              => drp_dout,
        DRDY_OUT            => drp_rdy,
        VP_IN               => '0', 
        VN_IN               => '0'
    );

    process (drp_clk)
    begin
        if rising_edge(drp_clk) then
            if drp_cnt(11) = '0' then 
                drp_cnt <= drp_cnt + 1;
            else
                drp_cnt <= (others => '0');
            end if;
        end if;
    end process;

    process (drp_clk) 
    begin
        if rising_edge(drp_clk) then
            drp_en <= drp_cnt(11);
        end if;
    end process;  

    process (drp_clk, drp_rst)
    begin
        if drp_rst = '1' then
            drp_temp  <= (others => '0');
        elsif rising_edge(drp_clk) then
            if drp_rdy = '1' then 
                drp_temp  <= drp_dout(15 downto 6);
            end if;
        end if;
    end process;

    sys_temp  <= drp_temp;



----------------------------------------------
----------------------------------------------

    cs_ila_sysmon_i : cs_ila_sysmon
    port map (
        CONTROL => sys_debug_cs0,
        CLK     => drp_clk,
        DATA    => cs_data,
        TRIG0   => cs_trig
    );
    
    cs_trig(0)  <= drp_rst;
    cs_trig(1)  <= drp_en;
    cs_trig(2)  <= drp_wr;
    cs_trig(3)  <= drp_rdy;
    cs_trig(7 downto 4)  <= x"0";

    cs_data(0)  <= drp_rst;
    cs_data(1)  <= drp_en;
    cs_data(2)  <= drp_wr;
    cs_data(3)  <= drp_rdy;

    cs_data(7 downto 4)  <= x"0";
    
    cs_data(14 downto 8)    <= drp_addr;
    cs_data(15)  <= '0';
    cs_data(31 downto 16)   <= drp_dout;

end Behavioral;
