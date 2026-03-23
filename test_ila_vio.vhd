library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity test_ila_vio is
 port (

sys_clk     : in     std_logic;
sys_rst		: in 		std_logic;
test_chscope: in 		std_logic_vector(7 downto 0)
);

end test_ila_vio;

architecture Behavioral of test_ila_vio is

--signal   count_test    : std_logic := '0';
signal count_test :   	std_logic_vector(7 downto 0);
signal CONTROL 	: 		std_logic_vector(35 downto 0) := (others => '0');
signal CONTROL_VIO: 		std_logic_vector(35 downto 0) := (others => '0');
signal vio_enable : 		std_logic_vector(0 downto 0) := (others => '0');


begin


process(sys_clk)
begin
    if rising_edge(sys_clk) then
        if sys_rst = '1' then
           count_test<= (others => '0'); 
        elsif (test_chscope = x"0A" and vio_enable(0) = '1') then
            count_test <= count_test + 1;
        end if;
    end if;
end process;

icon_test_inst : entity work.icon_test
    port map (
        CONTROL0 => CONTROL,
		  CONTROL1 => CONTROL_VIO
    );

ila_test_i : entity work.ila_test
  port map (
    CONTROL => CONTROL,
    CLK => sys_clk,
    DATA => (count_test & test_chscope),
    TRIG0 => count_test,
	 TRIG1 => test_chscope
	 );

test_vio_i : entity work.test_vio
  port map (
    CONTROL => CONTROL_VIO,
    ASYNC_IN => count_test,
    ASYNC_OUT => vio_enable
	 );


--process(clk, rst)
--begin
--    if rst = '1' then
--        q <= '0'; -- Асинхронный сброс
--    elsif rising_edge(clk) then
--        q <= d;
--    end if;
--end process;
--
--process(clk)
--begin
--    if rising_edge(clk) then
--        if rst = '1' then
--            q <= '0'; -- Синхронный сброс
--        else
--            q <= d;
--        end if;
--    end if;
--end process;


end Behavioral;

