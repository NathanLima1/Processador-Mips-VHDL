library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlop_D_P is
	port(
		D: in std_logic;
		Q : out std_logic;
		Preset : in std_logic;
		clk : in std_logic
	);

end FlipFlop_D_P;

architecture Behavioral of FlipFlop_D_P is
begin
	process (clk)
	begin
	if Preset = '1' then
            Q <= '1';
        elsif rising_edge(clk) then
            Q <= D;
	end if;
	end process;

end Behavioral;
