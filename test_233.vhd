--! @file
--! @brief Верхний уровень ПО 8МЯ-233

-- Почему внутри компонента не нужно инстанциировать; 
-- Почему используем icon_test_inst : entity work.icon_test; 
-- MMCM внутри clock_block
-- тест двух ila  и iconв одном проеке, потом добавляеи vio and chipscope?
-- вынести count наружу и попробовать виртуальные ноги


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.vcomponents.all;

--! @brief Верхний уровень ПО 8МЯ-233
--! 
--! @details Компонент принимает данные с приемника по двум поляризациям и при
--!          необходимости обсчитывает плоскость, дальность, скорость. Также
--!          проверяет целостность данных и при успешной проверке кладёт по DMA
--!          в DDR для 232-ой ячейки.
--! 
--! @param[in] DEBUG_EN - параметр включения отладки
--! @param[in] DEVICE_ID,VENDOR_ID - параметры платы
--! @param[in] HARDWARE_ID,FIRMWARE_ID - параметры прошивки
--! @param[in] SIMULATION,SIM_TURNOFF_CORR,SIM_CAL_OPTION,SIM_INIT_OPTION -
--!            параметры симуляции
--! @param[in] SIM_CHIP_NUMBER - параметр порядкового номера на плате
--! @param[in] SIM_POLAR_MODE - параметр режима своей поляризации
--! @param[in] sys_clk_p,sys_clk_n,mgt_clk_p,mgt_clk_n,ref_clk_p,ref_clk_n,
--!            pcie_clk_p,pcie_clk_n - тактовые частоты
--! @param[in] RX1N_IN,RX1P_IN,RX2N_IN,RX2P_IN - дифференциальные сигналы приёма
--!            рокетов
--! @param[in] pci_exp_rxp,pci_exp_rxn - дифференциальные сигналы приёма PCIe
--! @param[out] TX1N_OUT,TX1P_OUT,TX2N_OUT,TX2P_OUT - дифференциальные сигналы
--!             передачи рокетов
--! @param[out] pci_exp_txp,pci_exp_txn - дифференциальные сигналы передачи PCIe
--! @param[out] Linear_Flash_we_n,Linear_Flash_oe_n,Linear_Flash_ce_n,Linear_Flash_ld_n,
--!             Linear_Flash_data,Linear_Flash_address - шина BPI флэш памяти
--! @param[out] qdrii_cq_p,qdrii_cq_n,qdrii_q,qdrii_k_p,qdrii_k_n,qdrii_c_p,qdrii_c_n,
--!             qdrii_d,qdrii_sa,qdrii_w_n,qdrii_r_n,qdrii_bw_n,qdrii_dll_off_n
--!             - шина данных QDR
entity test_com233 is
port (
    -- System clock 100 MHz
    sys_clk_p               : in    std_logic;
    sys_clk_n               : in    std_logic;
    
    -- GTP clock for RIO 125 MHz
    mgt_clk_p               : in    std_logic;
    mgt_clk_n               : in    std_logic;
    
    -- -- REF clock for QDR 200 MHz
    -- ref_clk_p               : in    std_logic;
    -- ref_clk_n               : in    std_logic
    
    -- -- PCIe Clock 125 MHz
    pcie_clk_p              : in    std_logic;
    pcie_clk_n              : in    std_logic;
    
--    -- RocketIO 0-1
--    RX1N_IN                 : in    std_logic_vector(1 downto 0);
--    RX1P_IN                 : in    std_logic_vector(1 downto 0);
--    TX1N_OUT                : out   std_logic_vector(1 downto 0);
--    TX1P_OUT                : out   std_logic_vector(1 downto 0);
--    
--    -- RocketIO 2-3
--    RX2N_IN                 : in    std_logic_vector(1 downto 0);
--    RX2P_IN                 : in    std_logic_vector(1 downto 0);
--    TX2N_OUT                : out   std_logic_vector(1 downto 0);
--    TX2P_OUT                : out   std_logic_vector(1 downto 0);
    
    -- -- PCIe
     pci_exp_rxp             : in    std_logic_vector(3 downto 0);
     pci_exp_rxn             : in    std_logic_vector(3 downto 0);
     pci_exp_txp             : out   std_logic_vector(3 downto 0);
     pci_exp_txn             : out   std_logic_vector(3 downto 0);
	  test_chscope_out 			  :out 	 std_logic_vector(7 downto 0)
	  

    
    -- -- bpi flash
    -- Linear_Flash_we_n       : out std_logic;
    -- Linear_Flash_oe_n       : out std_logic;
    -- Linear_Flash_ce_n       : out std_logic;
    -- Linear_Flash_ld_n       : out std_logic;
    -- Linear_Flash_data       : inout std_logic_vector(15 downto 0);
    -- Linear_Flash_address    : out std_logic_vector(22 downto 0);

    -- -- QDR Interface
    -- qdrii_cq_p              : in std_logic_vector(0 downto 0);
    -- qdrii_cq_n              : in std_logic_vector(0 downto 0);
    -- qdrii_q                 : in std_logic_vector(17 downto 0);
    -- qdrii_k_p               : out std_logic_vector(0 downto 0);
    -- qdrii_k_n               : out std_logic_vector(0 downto 0);
    -- qdrii_c_p               : out std_logic_vector(0 downto 0);
    -- qdrii_c_n               : out std_logic_vector(0 downto 0);
    -- qdrii_d                 : out std_logic_vector(17 downto 0);
    -- qdrii_sa                : out std_logic_vector(20 downto 0);
    -- qdrii_w_n               : out std_logic;
    -- qdrii_r_n               : out std_logic;
    -- qdrii_bw_n              : out std_logic_vector(1 downto 0);
    -- qdrii_dll_off_n         : out std_logic
);
end test_com233;


architecture Behavioral of test_com233 is

    signal sys_temp : std_logic_vector(9 downto 0);
	 signal test_chscope :   	std_logic_vector(7 downto 0);



    signal sys_rst_clk      : std_logic;
    signal sys_rst          : std_logic;
    signal sys_clk          : std_logic;
    -- signal cpu_clk          : std_logic;
    -- signal cpu_rst          : std_logic;
    -- signal axi_clk          : std_logic;
    -- signal ref_clk          : std_logic;
    signal mgt_clk          : std_logic;
    signal pci_clk          : std_logic;


    signal sysmon_debug_cs0 : std_logic_vector(35 downto 0) := (others => '0');




BEGIN

    ------------------------------------------------
    clock_block_i : entity work.clock_block
    port map (
        sys_clk_p => sys_clk_p,
        sys_clk_n => sys_clk_n,
        -- ref_clk_p => ref_clk_p,
        -- ref_clk_n => ref_clk_n,
        mgt_clk_p => mgt_clk_p,
        mgt_clk_n => mgt_clk_n,
         
        sys_rst => sys_rst_clk,
        sys_clk => sys_clk,
        -- cpu_clk => cpu_clk,
        -- ref_clk => ref_clk,
        -- math_clk => math_clk,
        mgt_clk => mgt_clk
    );
    ------------------------------------------------
    ------------------------------------------------

    ------------------------------------------------
--    system_monitor_i : entity work.system_monitor
--    port map (
--        sys_clk       => sys_clk,
--        sys_rst       => sys_rst_clk,
--        sys_temp      => sys_temp,
--        sys_debug_cs0 => sysmon_debug_cs0
--    );

	pci_clk_ibufds : IBUFDS_GTXE1
	port map
	(
		I	=> pcie_clk_p,
		IB	=> pcie_clk_n,
		O	=> pci_clk,
		CEB => '0'
	);

    ibert_wrapper_i : entity work.ibert_wrapper
    port map (
        pci_exp_txp     => pci_exp_txp,
        pci_exp_txn     => pci_exp_txn,

        pci_exp_rxp     => pci_exp_rxp,
        pci_exp_rxn     => pci_exp_rxn,

        sys_clk     => sys_clk,
        pci_clk     => pci_clk
    );

    ------------------------------------------------
    ------------------------------------------------

    ------------------------------------------------
--    payload_i : entity work.payload
--    port map (
--        sys_rst     => sys_rst_clk,
--        sys_clk     => sys_clk
--    );
    ----------------------------------------------
    ----------------------------------------------
    test_ila_vio_i : entity work.test_ila_vio
    port map (
        sys_clk     => sys_clk,
        sys_rst     => sys_rst,
		  test_chscope => test_chscope

    );
	 
process(sys_clk)
begin
    if rising_edge(sys_clk) then
        if sys_rst = '1' then
           test_chscope<= (others => '0'); 
        else
            test_chscope <= test_chscope + 1;
        end if;
    end if;
end process; 

test_chscope_out <= test_chscope;




end Behavioral;