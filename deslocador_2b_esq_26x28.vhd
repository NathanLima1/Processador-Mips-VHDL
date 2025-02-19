library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity deslocador_2b_esq_26x28 is
	port(
		entrada: in std_logic_vector(25 downto 0);
		
		saida: out std_logic_vector(27 downto 0)
	);

end deslocador_2b_esq_26x28;

architecture Behavioral of deslocador_2b_esq_26x28 is

begin
	process(entrada)
	begin
		saida(27 downto 2) <= entrada(25 downto 0);
		saida(1 downto 0) <= "00";

	end process;

end Behavioral;
