library ieee;
use ieee.std_logic_1164.all;

entity CGEN2 is
	port(p, g: in std_logic_vector(3 downto 0);
	carry_in : in std_logic;
	s : out std_logic_vector(3 downto 0);
	carry_out : out std_logic);
end CGEN2;

architecture Structure of CGEN2 is
	signal c : std_logic_vector(4 downto 0);
	
	begin
		--fill carry vector
		c(0) <= carry_in;
		c(1) <= g(0) or (p(0) and c(0));
		c(2) <= g(1) or (p(1) and c(1));
		c(3) <= g(2) or (p(2) and c(2));
		c(4) <= g(3) or (p(3) and c(4));
		
		--generate output
		LOOP_FILL : for i in 0 to 3 generate
			s(i) <= g(i) xor p(i) xor c(i);
		end generate;
		
		carry_out <= c(4);

end Structure;

