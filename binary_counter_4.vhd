library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity binary_counter_4 is
	port(CLK, C_in, CLR: in std_logic;
			C_out: out std_logic := '0';
			O: out std_logic_vector(3 downto 0) := "0000");
end binary_counter_4;

architecture Behavioral of binary_counter_4 is
signal tmp: std_logic_vector(3 downto 0);
signal overflow: std_logic := '0';
signal c : std_logic := '0';
type state_type is (s0, s1);
signal state : state_type := s0;
 begin
	overflow <= '1' when (tmp = "1011") else '0';
		process (CLK, C_in, CLR, overflow)
		 begin
			if CLR = '0' then
				tmp <= "0000";
				c <= '0';
			elsif overflow = '1' then
				tmp <= "0000";
				c <= '1';
			elsif rising_edge(CLK) then
				case state is
					when s0 =>
						if C_in = '0' then
							tmp <= tmp + 1;
							c <= '0';
							state <= s1;
						else
							state <= s0;
						end if;
					when s1 =>
						if C_in = '0' then
							state <= s1;
						else
							state <= s0;
						end if;
				end case;
			end if;
		end process;
	O <= tmp;
	C_out <= c;
end Behavioral;
							