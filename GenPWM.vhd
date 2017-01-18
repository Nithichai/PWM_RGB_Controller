library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GenPWM is
	generic(max_period : integer := 100000);
	port(CLK, nRESET : in std_logic;
			PWM_set   : in std_logic_vector(3 downto 0);
			F_set	    : in std_logic_vector(3 downto 0);
			O			 : out std_logic);
end GenPWM;

architecture SYNTH_1 of GenPWM is
 signal pwm_period : integer range 0 to max_period := max_period;
 signal cnt, duty : integer range 0 to max_period;
  begin
	process(nRESET, CLK, PWM_set) 
		begin
			if nRESET = '0' then
				duty <= 0;
				pwm_period <= 100000;
			elsif rising_edge(CLK) then
				case F_set is
					when "0000" => pwm_period <= 100;--100000;
					when "0001" => pwm_period <= 93;--93808;
					when "0010" => pwm_period <= 88;--88339;
					when "0011" => pwm_period <= 83;--83472;
					when "0100" => pwm_period <= 79;--79113;
					when "0101" => pwm_period <= 75;--75187;
					when "0110" => pwm_period <= 71;--71633;
					when "0111" => pwm_period <= 68;--68399;
					when "1000" => pwm_period <= 65;--65445;
					when "1001" => pwm_period <= 62;--62735;
					when "1010" => pwm_period <= 60;--60240;
					when "1011" => pwm_period <= 57;--57937;
					when "1100" => pwm_period <= 55;--55803;
					when "1101" => pwm_period <= 53;--53821;
					when "1110" => pwm_period <= 51;--51975;
					when "1111" => pwm_period <= 50;--50000;
				end case;
				case PWM_set is
					when "0000" => duty <= 0;
					when "0001" => duty <= (pwm_period/10);
					when "0010" => duty <= (pwm_period/10)*2;
					when "0011" => duty <= (pwm_period/10)*3;
					when "0100" => duty <= (pwm_period/10)*4;
					when "0101" => duty <= (pwm_period/10)*5;
					when "0110" => duty <= (pwm_period/10)*6;
					when "0111" => duty <= (pwm_period/10)*7;
					when "1000" => duty <= (pwm_period/10)*8;
					when "1001" => duty <= (pwm_period/10)*9;
					when "1010" => duty <= (pwm_period-1);
					when others => duty <= 0;
				end case;
			end if;
	end process;

	process(nRESET, CLK)
		begin
		if nRESET = '0' then
			cnt <= 0;
			O <= '0';
		elsif rising_edge(CLK) then
			if cnt = pwm_period - 1 then
				cnt <= 0;
				O <= '1';
			else
				cnt <= cnt + 1;
				if cnt < duty then
					O <= '1';
				elsif cnt >= duty then
					O <= '0';
				end if;
			end if;
		end if;
	end process;
end SYNTH_1;
