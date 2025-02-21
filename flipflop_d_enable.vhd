library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflop_d_enable is
	port(
		D: in std_logic;
		Q : out std_logic;
		Enable : in std_logic;
		clk : in std_logic
	);

end flipflop_d_enable;

architecture Behavioral of flipflop_d_enable is
begin
	process (clk)
	begin
		if falling_edge(clk) then
			if Enable='1' then
				Q <= D;

			end if;
		end if;
	end process;

end Behavioral;
