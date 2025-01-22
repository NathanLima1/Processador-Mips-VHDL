library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Deslocador2bEsq is
    port(
        entrada: in std_logic_vector(31 down to 0);
        saida: out std_logic_vector(31 down to 0)
    );
end Deslocador2bEsq;

architecture Behavioral of Deslocador2bEsq is
begin
    process(entrada)
    begin
        saida(31 down to 2) <= entrada(29 down to 0);
        saida(1 down to 0) <= "00";
    end process;
end Behavioral;