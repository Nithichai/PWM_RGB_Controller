library ieee;
use ieee.std_logic_1164.all;

entity PWM_ALL is
	generic(N : integer := 3);
	port(CLK, RST_B : in std_logic;
			PBs : in std_logic_vector(N downto 0);
			Selectors : in std_logic_vector(3 downto 0);
			PWMs : out std_logic_vector(N downto 0));
end PWM_ALL;

architecture data_flow of PWM_ALL is
	component PWM_RGB
	port(CLK, RST_B : in std_logic;
			PB : in std_logic;
			Selector : in std_logic_vector(3 downto 0);
			PWM : out std_logic);
	end component;
begin
	all_box : for i in 0 to N-1 generate
	all_box : PWM_RGB port map(CLK, RST_B, PBs(i), Selectors, PWMs(i));
	end generate;
end data_flow;