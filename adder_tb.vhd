library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_tb is
end adder_tb;


architecture TB of adder_tb is

    component adder
        generic (
            WIDTH : positive := 8);
        port (
            x, y : in  std_logic_vector(WIDTH-1 downto 0);
            carry_in  : in  std_logic;
            s    : out std_logic_vector(WIDTH-1 downto 0);
            carry_out : out std_logic);
    end component;

    constant TEST_WIDTH  : positive := 8;
    constant TEST_WIDTH2 : positive := 4;

    signal x_rc, y_rc      : std_logic_vector(TEST_WIDTH-1 downto 0);
    signal x_cl, y_cl      : std_logic_vector(TEST_WIDTH2-1 downto 0);
    signal cin_rc          : std_logic;
	signal cin_cl		   : std_logic;
    signal s_rc            : std_logic_vector(TEST_WIDTH-1 downto 0);
    signal s_cl            : std_logic_vector(TEST_WIDTH2-1 downto 0);
    signal cout_rc         : std_logic;
    signal cout_cl         : std_logic;

begin  -- TB

    U_RIPPLE_CARRY : entity work.adder(RIPPLE_CARRY)
        generic map (
            WIDTH => TEST_WIDTH)
        port map (
            x    => x_rc,
            y    => y_rc,
            carry_in  => cin_rc,
            s    => s_rc,
            carry_out => cout_rc);


    U_CARRY_LOOKAHEAD : entity work.adder(CARRY_LOOKAHEAD)
        generic map (
            WIDTH => TEST_WIDTH2)
        port map (
            x    => x_cl,
            y    => y_cl,
            carry_in  => cin_cl,
            s    => s_cl,
            carry_out => cout_cl);


    process
        variable error_rc        : integer;
        variable error_cl        : integer;
        variable result_tmp      : unsigned(TEST_WIDTH downto 0);
        variable result_tmp2     : unsigned(TEST_WIDTH2 downto 0);
        variable correct_result  : std_logic_vector(TEST_WIDTH-1 downto 0);
        variable correct_result2 : std_logic_vector(TEST_WIDTH2-1 downto 0);
        variable correct_cout    : std_logic;
        variable correct_cout2   : std_logic;

        variable score_rc  : integer;
        variable score_cla : integer;
        variable score_h   : integer;
        
    begin

        error_rc := 0;
        error_cl := 0;

        report "******************TESTING CARRY LOOK AHEAD********************";

        for i in 0 to TEST_WIDTH-1 loop

            x_cl <= std_logic_vector(to_unsigned(i, TEST_WIDTH2));

            for j in 0 to TEST_WIDTH-1 loop

                y_cl <= std_logic_vector(to_unsigned(j, TEST_WIDTH2));

                for k in 0 to 1 loop

                    cin_cl <= std_logic(to_unsigned(k, 1)(0));

                    wait for 10 ns;

                    result_tmp2     := unsigned("0"&x_cl) + unsigned("0"&y_cl) + to_unsigned(k, 1);
                    correct_result2 := std_logic_vector(result_tmp2(TEST_WIDTH2-1 downto 0));
                    correct_cout2   := std_logic(result_tmp2(TEST_WIDTH2));

                    if (s_cl /= correct_result2) then
                        error_cl := error_cl + 1;
                        report "Error : CL, " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & integer'image(to_integer(unsigned(s_cl))) severity warning;
                    end if;

                end loop;  -- k
            end loop;  -- j      
        end loop;  -- i

        report "******************TESTING RIPPLE CARRY********************";

		for i in 0 to TEST_WIDTH-1 loop

            x_rc <= std_logic_vector(to_unsigned(i, TEST_WIDTH));

            for j in 0 to TEST_WIDTH-1 loop

                y_rc <= std_logic_vector(to_unsigned(j, TEST_WIDTH));

                for k in 0 to 1 loop

                    cin_rc <= std_logic(to_unsigned(k, 1)(0));

                    wait for 10 ns;

                    result_tmp     := unsigned("0"&x_rc) + unsigned("0"&y_rc) + to_unsigned(k, 1);
                    correct_result := std_logic_vector(result_tmp(TEST_WIDTH-1 downto 0));
                    correct_cout   := std_logic(result_tmp(TEST_WIDTH));

                    if (s_rc /= correct_result) then
                        error_rc := error_rc + 1;
                        report "Error : RC, " & integer'image(i) & " + " & integer'image(j) & " + " & integer'image(k) & " = " & integer'image(to_integer(unsigned(s_rc))) severity warning;
                    end if;

                end loop;  -- k
            end loop;  -- j      
        end loop;  -- i

        report "Ripple carry errors     : " & integer'image(error_rc);
		report "Carry look ahead errors : " & integer'image(error_cl);

        wait;

    end process;

end TB;