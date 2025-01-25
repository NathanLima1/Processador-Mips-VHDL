library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2 is
	port (
		Sel, E0, E1 : in std_logic;
		Saida : out std_logic
	);
end mux_2;

architecture Behavioral of mux_2 is

begin
	Saida <= (not Sel and E0) or (Sel and E1);

end Behavioral;
