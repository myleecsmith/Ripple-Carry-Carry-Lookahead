-- I/O Explanation (assumes the switches are on side of the
-- board that is closest to you)
-- switch(9) is the leftmost switch
-- button_n(1) is the top button
-- led5 is the leftmost 7-segment LED
-- ledx_dp is the decimal point on the 7-segment LED for LED x
-- Note: this code will cause a harmless synthesis warning because not all
-- the buttons are used and because some output pins are always '0' or '1'
-- Thank you Dr. Greg Stitt for allowing the use of former lab files and
--documentation
-- to form the core of this top_level file.
library ieee;
use ieee.std_logic_1164.all;
entity top_level is
port (
switch : in std_logic_vector(9 downto 0);
button_n : in std_logic_vector(1 downto 0);
led0 : out std_logic_vector(6 downto 0);
led0_dp : out std_logic;
led1 : out std_logic_vector(6 downto 0);
led1_dp : out std_logic;
led2 : out std_logic_vector(6 downto 0);
led2_dp : out std_logic;
led3 : out std_logic_vector(6 downto 0);
led3_dp : out std_logic;
led4 : out std_logic_vector(6 downto 0);
led4_dp : out std_logic;
led5 : out std_logic_vector(6 downto 0);
led5_dp : out std_logic
);
end top_level;
architecture STR of top_level is
signal button : std_logic_vector(button_n'range);
signal sum_rc : std_logic_vector(7 downto 0);
signal sum_cl : std_logic_vector(7 downto 0);
signal input1 : std_logic_vector(7 downto 0);
signal input2 : std_logic_vector(7 downto 0);
signal cout_rc : std_logic;
signal cout_cl : std_logic;
constant C0 : std_logic_vector(3 downto 0) := "0000";
begin -- STR
-- the buttons are active low
button <= not button_n;
-- map adder output to two LEDs
U_LED5 : entity work.decode7seg port map (
input => sum_rc(7 downto 4),
output => led5);
U_LED4 : entity work.decode7seg port map (
input => sum_rc(3 downto 0),
output => led4);
-- all other LEDs should display 0
U_LED3 : entity work.decode7seg port map (
input => sum_cl(7 downto 4),
output => led3);
U_LED2 : entity work.decode7seg port map (
input => sum_cl(3 downto 0),
output => led2);
U_LED1 : entity work.decode7seg port map (
input => C0,
output => led1);
U_LED0 : entity work.decode7seg port map (
input => C0,
output => led0);
-- With 10 switches, split 5 switches between each input
-- Concatenate 3 zeros to the front to match 8 bit inputs
input1 <= "000" & switch(9 downto 5);
input2 <= "000" & switch(4 downto 0);
-- instantiate Ripple Carry Adder
U_RC : entity work.adder(RIPPLE_CARRY)
generic map (
WIDTH => 8
)
port map (
x => input1,
y => input2,
carry_in => button(0), -- carry_in mapped to bottom button
s => sum_rc,
carry_out => cout_rc
);
-- instantiate Carry Look Ahead Adder
U_CL : entity work.adder(CARRY_LOOKAHEAD)
generic map (
WIDTH => 4
)
port map (
x => input1(3 downto 0),
y => input2(3 downto 0),
carry_in => button(1), -- carry_in mapped to bottom button
s => sum_cl(3 downto 0),
carry_out => cout_cl
);
-- show carry out on dp of leftmost LED
-- should never be asserted due to 5-bit inputs
-- show 6th sum bit (actual carry out) on led4 dp
led5_dp <= not cout_rc;
led4_dp <= not sum_rc(5);
led3_dp <= not cout_cl;
led2_dp <= not sum_cl(5);
led1_dp <= '1';
led0_dp <= '1';
end STR;
