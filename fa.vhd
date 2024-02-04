library ieee;
use ieee.std_logic_1164.all;

entity fa is
	port (x, y : in std_logic;
	carry_in : in std_logic;
	s : out std_logic;
	carry_out : out std_logic);
end fa;


architecture fa_arch of fa is
	begin
		s <= x xor y xor carry_in;
		carry_out <= (x and y) or (x and carry_in) or (y and carry_in);
end fa_arch;