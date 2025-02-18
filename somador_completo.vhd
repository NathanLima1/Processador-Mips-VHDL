library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somador_completo is
	port(
		A, B, VemUm : in std_logic;
		Soma, VaiUm : out std_logic
	);
end somador_completo;

architecture Behavioral of somador_completo is
-- Parte declarativa

-- Fim parte declarativa
begin
-- Parte lógica
	VaiUm <= (A and B) or ((A xor B) and VemUm);
	Soma <= (VemUm xor (A xor B));
-- Fim parte lógica
end Behavioral;