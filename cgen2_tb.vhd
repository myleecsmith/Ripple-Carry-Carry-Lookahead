library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cgen2_tb is
end entity cgen2_tb;

architecture tb_arch of cgen2_tb is
	signal p_sig:  std_logic_vector(3 downto 0) := "0000";
	signal g_sig:  std_logic_vector(3 downto 0) := "0001";
	signal carry_in_sig:  std_logic := '0';
	signal s_sig:  std_logic_vector(3 downto 0);
	signal carry_out_sig: std_logic;
begin
	UUT: entity work.cgen2
	generic map (WIDTH => 8)
	
	port map (
	p => p_sig,
	g => g_sig,
	carry_in => carry_in_sig,
	s => s_sig,
	carry_out => carry_out_sig
	);
	
process
begin
	wait for 10 ns; -- Allow for some simulation time
	
	p_sig <= "1000";
	wait for 10 ns; -- Allow for some simulation time
	
	carry_in_sig <= '1';
	g_sig <= "0100";
	wait for 10 ns; -- Allow for some simulation time
	
	p_sig <= "1000";
	g_sig <= "1010";
	carry_in_sig <= '1';
	wait for 10 ns; -- Allow for some simulation time
	
	wait;
	
end process;
end architecture tb_arch;
