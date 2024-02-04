library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fa_tb is
end entity fa_tb;

architecture tb_arch of fa_tb is
	signal x_sig:  std_logic := '0';
	signal y_sig:  std_logic := '1';
	signal carry_in_sig:  std_logic := '0';
	signal s_sig:  std_logic;
	signal carry_out_sig: std_logic;
begin
	UUT: entity work.fa
	generic map (WIDTH => 8)
	
	port map (
	x => x_sig,
	y => y_sig,
	carry_in => carry_in_sig,
	s => s_sig,
	carry_out => carry_out_sig
	);
	
process
begin
	wait for 10 ns; -- Allow for some simulation time
	
	x_sig <= '1';
	wait for 10 ns; -- Allow for some simulation time
	
	carry_in_sig <= '1';
	wait for 10 ns; -- Allow for some simulation time
	
	y_sig <= '0';
	x_sig <= '0';
	carry_in_sig <= '1';
	wait for 10 ns; -- Allow for some simulation time
	
	wait;
	
end process;
end architecture tb_arch;
