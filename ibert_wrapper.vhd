

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


library UNISIM;
use UNISIM.VComponents.all;

entity ibert_wrapper is
    port (
	     pci_exp_txp             : out   std_logic_vector(3 downto 0);
        pci_exp_txn             : out   std_logic_vector(3 downto 0);
        pci_exp_rxp             : in    std_logic_vector(3 downto 0);
		  pci_exp_rxn             : in    std_logic_vector(3 downto 0);

--        RX1N_IN     : in    std_logic_vector(1 downto 0);
--        RX1P_IN     : in    std_logic_vector(1 downto 0);
--        TX1N_OUT    : out   std_logic_vector(1 downto 0);
--        TX1P_OUT    : out   std_logic_vector(1 downto 0);
--
--        RX2N_IN     : in    std_logic_vector(1 downto 0);
--        RX2P_IN     : in    std_logic_vector(1 downto 0);
--        TX2N_OUT    : out   std_logic_vector(1 downto 0);
--        TX2P_OUT    : out   std_logic_vector(1 downto 0);

        sys_clk     : in    std_logic;
        pci_clk     : in    std_logic

    );
end ibert_wrapper;

architecture Imp of ibert_wrapper is

    signal control_ibert : std_logic_vector(35 downto 0) := (others => '0');


component Ibert_my
  PORT (
    X0Y0_TX_P_OPAD : OUT STD_LOGIC;
    X0Y0_TX_N_OPAD : OUT STD_LOGIC;
    X0Y1_TX_P_OPAD : OUT STD_LOGIC;
    X0Y1_TX_N_OPAD : OUT STD_LOGIC;
    X0Y2_TX_P_OPAD : OUT STD_LOGIC;
    X0Y2_TX_N_OPAD : OUT STD_LOGIC;
    X0Y3_TX_P_OPAD : OUT STD_LOGIC;
    X0Y3_TX_N_OPAD : OUT STD_LOGIC;
    X0Y0_RXRECCLK_O : OUT STD_LOGIC;
    X1Y24_TX_P_OPAD : OUT STD_LOGIC;
    X1Y24_TX_N_OPAD : OUT STD_LOGIC;
    X1Y25_TX_P_OPAD : OUT STD_LOGIC;
    X1Y25_TX_N_OPAD : OUT STD_LOGIC;
    X1Y26_TX_P_OPAD : OUT STD_LOGIC;
    X1Y26_TX_N_OPAD : OUT STD_LOGIC;
    X1Y27_TX_P_OPAD : OUT STD_LOGIC;
    X1Y27_TX_N_OPAD : OUT STD_LOGIC;
    X1Y28_TX_P_OPAD : OUT STD_LOGIC;
    X1Y28_TX_N_OPAD : OUT STD_LOGIC;
    X1Y29_TX_P_OPAD : OUT STD_LOGIC;
    X1Y29_TX_N_OPAD : OUT STD_LOGIC;
    X1Y30_TX_P_OPAD : OUT STD_LOGIC;
    X1Y30_TX_N_OPAD : OUT STD_LOGIC;
    X1Y31_TX_P_OPAD : OUT STD_LOGIC;
    X1Y31_TX_N_OPAD : OUT STD_LOGIC;
    X1Y32_TX_P_OPAD : OUT STD_LOGIC;
    X1Y32_TX_N_OPAD : OUT STD_LOGIC;
    X1Y33_TX_P_OPAD : OUT STD_LOGIC;
    X1Y33_TX_N_OPAD : OUT STD_LOGIC;
    X1Y34_TX_P_OPAD : OUT STD_LOGIC;
    X1Y34_TX_N_OPAD : OUT STD_LOGIC;
    X1Y35_TX_P_OPAD : OUT STD_LOGIC;
    X1Y35_TX_N_OPAD : OUT STD_LOGIC;
    X1Y24_RXRECCLK_O : OUT STD_LOGIC;
    X1Y25_RXRECCLK_O : OUT STD_LOGIC;
    X1Y26_RXRECCLK_O : OUT STD_LOGIC;
    X1Y27_RXRECCLK_O : OUT STD_LOGIC;
    X1Y28_RXRECCLK_O : OUT STD_LOGIC;
    X1Y29_RXRECCLK_O : OUT STD_LOGIC;
    X1Y30_RXRECCLK_O : OUT STD_LOGIC;
    X1Y31_RXRECCLK_O : OUT STD_LOGIC;
    X1Y32_RXRECCLK_O : OUT STD_LOGIC;
    X1Y33_RXRECCLK_O : OUT STD_LOGIC;
    X1Y34_RXRECCLK_O : OUT STD_LOGIC;
    X1Y35_RXRECCLK_O : OUT STD_LOGIC;
    CONTROL : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    X0Y0_RX_P_IPAD : IN STD_LOGIC;
    X0Y0_RX_N_IPAD : IN STD_LOGIC;
    X0Y1_RX_P_IPAD : IN STD_LOGIC;
    X0Y1_RX_N_IPAD : IN STD_LOGIC;
    X0Y2_RX_P_IPAD : IN STD_LOGIC;
    X0Y2_RX_N_IPAD : IN STD_LOGIC;
    X0Y3_RX_P_IPAD : IN STD_LOGIC;
    X0Y3_RX_N_IPAD : IN STD_LOGIC;
    X1Y24_RX_P_IPAD : IN STD_LOGIC;
    X1Y24_RX_N_IPAD : IN STD_LOGIC;
    X1Y25_RX_P_IPAD : IN STD_LOGIC;
    X1Y25_RX_N_IPAD : IN STD_LOGIC;
    X1Y26_RX_P_IPAD : IN STD_LOGIC;
    X1Y26_RX_N_IPAD : IN STD_LOGIC;
    X1Y27_RX_P_IPAD : IN STD_LOGIC;
    X1Y27_RX_N_IPAD : IN STD_LOGIC;
    X1Y28_RX_P_IPAD : IN STD_LOGIC;
    X1Y28_RX_N_IPAD : IN STD_LOGIC;
    X1Y29_RX_P_IPAD : IN STD_LOGIC;
    X1Y29_RX_N_IPAD : IN STD_LOGIC;
    X1Y30_RX_P_IPAD : IN STD_LOGIC;
    X1Y30_RX_N_IPAD : IN STD_LOGIC;
    X1Y31_RX_P_IPAD : IN STD_LOGIC;
    X1Y31_RX_N_IPAD : IN STD_LOGIC;
    X1Y32_RX_P_IPAD : IN STD_LOGIC;
    X1Y32_RX_N_IPAD : IN STD_LOGIC;
    X1Y33_RX_P_IPAD : IN STD_LOGIC;
    X1Y33_RX_N_IPAD : IN STD_LOGIC;
    X1Y34_RX_P_IPAD : IN STD_LOGIC;
    X1Y34_RX_N_IPAD : IN STD_LOGIC;
    X1Y35_RX_P_IPAD : IN STD_LOGIC;
    X1Y35_RX_N_IPAD : IN STD_LOGIC;
    Q1_CLK1_MGTREFCLK_I : IN STD_LOGIC;
    IBERT_SYSCLOCK_I : IN STD_LOGIC
	 );

END COMPONENT;


BEGIN


    --ibert_115_i : entity work.ibert_115
	 Ibert_my_i : Ibert_my
    port map (

        X0Y0_TX_P_OPAD     => pci_exp_txp(0),
        X0Y0_TX_N_OPAD     => pci_exp_txn(0),
        X0Y1_TX_P_OPAD     => pci_exp_txp(1),
        X0Y1_TX_N_OPAD     => pci_exp_txn(1),
        X0Y2_TX_P_OPAD     => pci_exp_txp(2),
        X0Y2_TX_N_OPAD     => pci_exp_txn(2),
        X0Y3_TX_P_OPAD     => pci_exp_txp(3),
        X0Y3_TX_N_OPAD     => pci_exp_txn(3),
	 X0Y0_RXRECCLK_O => open,
    X1Y24_TX_P_OPAD => open,
    X1Y24_TX_N_OPAD => open,
    X1Y25_TX_P_OPAD => open,
    X1Y25_TX_N_OPAD => open,
    X1Y26_TX_P_OPAD => open,
    X1Y26_TX_N_OPAD => open,
    X1Y27_TX_P_OPAD => open,
    X1Y27_TX_N_OPAD => open,
    X1Y28_TX_P_OPAD => open,
    X1Y28_TX_N_OPAD => open,
    X1Y29_TX_P_OPAD => open,
    X1Y29_TX_N_OPAD => open,
    X1Y30_TX_P_OPAD => open,
    X1Y30_TX_N_OPAD => open,
    X1Y31_TX_P_OPAD => open,
    X1Y31_TX_N_OPAD => open,
    X1Y32_TX_P_OPAD => open,
    X1Y32_TX_N_OPAD => open,
    X1Y33_TX_P_OPAD => open,
    X1Y33_TX_N_OPAD => open,
    X1Y34_TX_P_OPAD => open,
    X1Y34_TX_N_OPAD => open,
    X1Y35_TX_P_OPAD => open,
    X1Y35_TX_N_OPAD => open,
    X1Y24_RXRECCLK_O => open,
    X1Y25_RXRECCLK_O => open,
    X1Y26_RXRECCLK_O => open,
    X1Y27_RXRECCLK_O => open,
    X1Y28_RXRECCLK_O => open,
    X1Y29_RXRECCLK_O => open,
    X1Y30_RXRECCLK_O => open,
    X1Y31_RXRECCLK_O => open,
    X1Y32_RXRECCLK_O => open,
    X1Y33_RXRECCLK_O => open,
    X1Y34_RXRECCLK_O => open,
    X1Y35_RXRECCLK_O => open,

        CONTROL             => control_ibert,

        X0Y0_RX_P_IPAD     => pci_exp_rxp(0),
        X0Y0_RX_N_IPAD     => pci_exp_rxn(0),
        X0Y1_RX_P_IPAD     => pci_exp_rxp(1),
        X0Y1_RX_N_IPAD     => pci_exp_rxn(1),
        X0Y2_RX_P_IPAD     => pci_exp_rxp(2),
        X0Y2_RX_N_IPAD     => pci_exp_rxn(2),
        X0Y3_RX_P_IPAD     => pci_exp_rxp(3),
        X0Y3_RX_N_IPAD     => pci_exp_rxn(3),
	 X1Y24_RX_P_IPAD => '0',
    X1Y24_RX_N_IPAD => '0',
    X1Y25_RX_P_IPAD => '0',
    X1Y25_RX_N_IPAD => '0',
    X1Y26_RX_P_IPAD => '0',
    X1Y26_RX_N_IPAD => '0',
    X1Y27_RX_P_IPAD => '0',
    X1Y27_RX_N_IPAD => '0',
    X1Y28_RX_P_IPAD => '0',
    X1Y28_RX_N_IPAD => '0',
    X1Y29_RX_P_IPAD => '0',
    X1Y29_RX_N_IPAD => '0',
    X1Y30_RX_P_IPAD => '0',
    X1Y30_RX_N_IPAD => '0',
    X1Y31_RX_P_IPAD => '0',
    X1Y31_RX_N_IPAD => '0',
    X1Y32_RX_P_IPAD => '0',
    X1Y32_RX_N_IPAD => '0',
    X1Y33_RX_P_IPAD => '0',
    X1Y33_RX_N_IPAD => '0',
    X1Y34_RX_P_IPAD => '0',
    X1Y34_RX_N_IPAD => '0',
    X1Y35_RX_P_IPAD => '0',
    X1Y35_RX_N_IPAD => '0',

        Q1_CLK1_MGTREFCLK_I => pci_clk,
        IBERT_SYSCLOCK_I    => sys_clk
    );

    icon_ibert_inst : entity work.icon_ibert
    port map (
        CONTROL0 => control_ibert
    );


end Imp;

