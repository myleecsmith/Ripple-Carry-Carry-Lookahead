library ieee;
use ieee.std_logic_1164.all;

entity CLA2 is
	port(x, y : in std_logic_vector(1 downto 0);
	g, p: out std_logic_vector(1 downto 0));
end CLA2;

architecture Structure of CLA2 is
	begin
		p(0) <= x(0) or y(0);
		g(0) <= x(0) and y(0);
		
		p(1) <= x(1) or y(1);
		g(1) <= x(1) and y(1);

end Structure;

