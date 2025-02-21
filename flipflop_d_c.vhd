library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlop_D_C is
	port(
		D: in std_logic;
		Q : out std_logic;
		Clear : in std_logic;
		clk : in std_logic
	);

end FlipFlop_D_C;

architecture Behavioral of FlipFlop_D_C is
begin
	process (clk)
	begin
		if Clear='1' then
			Q <= '0';
		elsif rising_edge(clk) then
			Q <= D;
		end if;
	end process;

end Behavioral;
