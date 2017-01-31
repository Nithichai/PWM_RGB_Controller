library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Debounce_switch is
	port( CLK, button : in std_logic;
			result : out std_logic := '0');
end Debounce_switch;

architecture Behavioral of Debounce_switch is
 signal inff : std_logic_vector(1 downto 0);
 constant cnt_max : integer := 5;
 signal count : integer range 0 to cnt_max := 0;
 signal keepResult : std_logic := '1';
  begin
	result <= keepResult;
		process(CLK)
		 begin
			if rising_edge(CLK) then
				inff <= inff(0) & button;
				if inff(0) /= inff(1) then
					count <= 0;
				elsif count < cnt_max then
					count <= count + 1;
				else
					keepResult <= inff(1);
				end if;
			end if;
		end process;
end Behavioral;
	