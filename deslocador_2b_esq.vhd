library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity deslocador_2b_esq is
    port(
        entrada: in std_logic_vector(31 downto 0);
        saida: out std_logic_vector(31 downto 0)
    );
end deslocador_2b_esq;

architecture Behavioral of deslocador_2b_esq is
begin
    process(entrada)
    begin
        saida(31 downto 2) <= entrada(29 downto 0);
        saida(1 downto 0) <= "00";
    end process;
end Behavioral;
