library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cla2_tb is
end entity cla2_tb;

architecture tb_arch of cla2_tb is
	signal x_sig:  std_logic_vector(1 downto 0) := "01";
	signal y_sig:  std_logic_vector(1 downto 0) := "00";
	signal p_sig:  std_logic_vector(1 downto 0);
	signal g_sig:  std_logic_vector(1 downto 0);
begin
	UUT: entity work.cla2
	generic map (WIDTH => 8)
	
	port map (
	x => x_sig,
	y => y_sig,
	p => p_sig,
	g => g_sig
	);
	
process
begin
	wait for 10 ns; -- Allow for some simulation time
	
	x_sig <= "10";
	y_sig <= "10";
	wait for 10 ns; -- Allow for some simulation time
	
	x_sig <= "11";
	y_sig <= "10";
	wait for 10 ns; -- Allow for some simulation time
	
	x_sig <= "10";
	y_sig <= "01";
	wait for 10 ns; -- Allow for some simulation time
	
	wait;
	
end process;
end architecture tb_arch;
