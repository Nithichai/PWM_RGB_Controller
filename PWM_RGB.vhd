library ieee;
use ieee.std_logic_1164.all;

entity PWM_RGB is
	port(CLK, RST_B : in std_logic;
			PB : in std_logic;
			Selector : in std_logic_vector(3 downto 0);
			PWM : out std_logic);
end PWM_RGB;

architecture Structural of PWM_RGB is

 component Debounce_switch
	port( CLK, button : in std_logic;
			result : out std_logic);
	end component;
	
 component binary_counter_4
	port(CLK, C_in, CLR: in std_logic;
			C_out: out std_logic := '0';
			O: out std_logic_vector(3 downto 0));
	end component;
	
 component GenPWM
	port(CLK, nRESET : in std_logic;
			PWM_set   : in std_logic_vector(3 downto 0);
			F_set	    : in std_logic_vector(3 downto 0);
			O			 : out std_logic);
	end component;
	
 signal debounce_out : std_logic;
 signal bnc_out : std_logic_vector(3 downto 0);
 signal carry_out : std_logic;
 begin
	debouce_box : Debounce_switch port map(CLK, PB, debounce_out);
	bnc_box : binary_counter_4 port map(CLK, debounce_out, RST_B, carry_out, bnc_out);
	pwm_box : GenPWM port map(CLK, RST_B, bnc_out, Selector, PWM);

end Structural;