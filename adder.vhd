library ieee;
use ieee.std_logic_1164.all;

entity adder is
generic (WIDTH : positive := 8);
	port (x, y : in std_logic_vector(WIDTH-1 downto 0);
	carry_in : in std_logic;
	s : out std_logic_vector(WIDTH-1 downto 0);
	carry_out : out std_logic);
end adder;

--RIPPLE_CARRY implementation
architecture RIPPLE_CARRY of adder is

--full adder component
component fa
	port (x, y : in std_logic; 
	carry_in : in std_logic;
	carry_out : out std_logic;
	s : out std_logic);
end component;

signal c : std_logic_vector(WIDTH downto 0);

	begin
		c(0) <= carry_in;
		carry_out <= c(WIDTH);
	
		LOOP_ADD : for i in 0 to WIDTH-1 generate
			--port map full adder to ripple carry
			adder_inst : fa
			PORT MAP (x => x(i), y => y(i), carry_in => c(i), carry_out => c(i+1), s => s(i));
		end generate;
		
end RIPPLE_CARRY;

--CARRY_LOOKAHEAD implementation
architecture CARRY_LOOKAHEAD of adder is

--2 CLA components -> CGEN
component CLA2
	port(x, y : in std_logic_vector(1 downto 0);
	g, p: out std_logic_vector(1 downto 0));
end component;

--CLA -> CGEN
component CGEN2
	port(p, g: in std_logic_vector(3 downto 0);
	carry_in : in std_logic;
	s : out std_logic_vector(3 downto 0);
	carry_out : out std_logic);
end component;

--define signals here
signal g : std_logic_vector(3 downto 0);
signal p : std_logic_vector(3 downto 0);

	begin
		--create two instances of CLA
		cla_0 : CLA2 PORT MAP(x(1 downto 0) => x(1 downto 0), y(1 downto 0) => y(1 downto 0),
		g(1 downto 0) => g(1 downto 0), p(1 downto 0) => p(1 downto 0));
		
		cla_1 : CLA2 PORT MAP(x(1 downto 0) => x(3 downto 2), y(1 downto 0) => y(3 downto 2),
		g(1 downto 0) => g(3 downto 2), p(1 downto 0) => p(3 downto 2));
		
		--create an instance of CGEN
		CGEN : CGEN2 PORT MAP(p(3 downto 0) => p(3 downto 0), g(3 downto 0) => g(3 downto 0), carry_in => carry_in,
		carry_out => carry_out, s(3 downto 0) => s(3 downto 0));
end CARRY_LOOKAHEAD;