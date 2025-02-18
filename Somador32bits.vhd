library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Somador32bits is
	port(
		A, B: in std_logic_vector(31 downto 0);
		Soma: out std_logic_vector(31 downto 0)
	);
end Somador32bits;

architecture Behavioral of Somador32bits is
	component somador_completo is
		port(
			A, B, VemUm : in std_logic;
			Soma, VaiUm : out std_logic
		);
	end component;
	signal VaiUm : std_logic_vector(0 to 33);
begin	
	VaiUm(0) <= '0';
	iteraSoma: for i in 0 to 31 generate
		somaTudo: somador_completo port map (
			A => A(i),
			B => B(i),
			VemUm => VaiUm(i),
			Soma => Soma(i),
			VaiUm => VaiUm(i+1)
		);
	end generate;
end Behavioral;