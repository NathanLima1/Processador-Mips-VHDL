library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_deslocador_2b_esq is
end tb_deslocador_2b_esq;

architecture behavior of tb_deslocador_2b_esq is
    component deslocador_2b_esq
        port (
            entrada: in STD_LOGIC_VECTOR(31 downto 0);
            saida: out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    signal entrada : STD_LOGIC_VECTOR(31 downto 0);
    signal saida : STD_LOGIC_VECTOR(31 downto 0);

begin
    uut: deslocador_2b_esq
        port map (
            entrada => entrada,
            saida => saida
        );

    -- Processo de estímulo para os testes
    stim_proc: process
    begin        
        -- Teste 1: Deslocamento de um número simples
        entrada <= "00000000000000000000000000001111"; -- Entrada = 00000000000000000000000000001111
        wait for 10 ns;

        -- Teste 2: Deslocamento de número com valor alto
        entrada <= "11111111111111111111111111110000"; -- Entrada = 11111111111111111111111111110000
        wait for 10 ns;

        -- Teste 3: Deslocamento de número com todos os bits em 0
        entrada <= "00000000000000000000000000000000"; -- Entrada = 00000000000000000000000000000000
        wait for 10 ns;

        -- Teste 4: Deslocamento de número com todos os bits em 1
        entrada <= "11111111111111111111111111111111"; -- Entrada = 11111111111111111111111111111111
        wait for 10 ns;

        -- Teste 5: Deslocamento de número com valor intermediário
        entrada <= "00000000000000001111000011110000"; -- Entrada = 00000000000000001111000011110000
        wait for 10 ns;

        -- Teste 6: Deslocamento de número com valores específicos
        entrada <= "00001111000011110000111100001111"; -- Entrada = 00001111000011110000111100001111
        wait for 10 ns;

        -- Teste 7: Teste com todos os bits deslocados (simulando o efeito do deslocamento)
        entrada <= "00000000000000000000000000000001"; -- Entrada = 00000000000000000000000000000001
        wait for 10 ns;

        -- Finaliza os testes
        wait;
    end process;

end behavior;
