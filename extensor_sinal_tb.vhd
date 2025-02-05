library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity tb_extensor_sinal is
end tb_extensor_sinal;

architecture behavior of tb_extensor_sinal is
    component extensor_sinal
        port(
            input_16: in std_logic_vector(15 downto 0);
            output_32: out std_logic_vector(31 downto 0)
        );
    end component;
  
    signal input_16 : std_logic_vector(15 downto 0);
    signal output_32 : std_logic_vector(31 downto 0);

begin
    uut: extensor_sinal
        port map (
            input_16 => input_16,
            output_32 => output_32
        );

    stim_proc: process
    begin        
        -- Teste 1: Valor positivo simples (sem extensão de sinal)
        input_16 <= "0000000000001010"; -- 10 em decimal
        wait for 10 ns;
      
        -- Teste 2: Valor negativo simples (com extensão de sinal)
        input_16 <= "1111111111111010"; -- -6 em decimal (com bit de sinal 1)
        wait for 10 ns;
        
        -- Teste 3: Valor máximo positivo (sem extensão de sinal)
        input_16 <= "0111111111111111"; -- 32767 em decimal
        wait for 10 ns;

        -- Teste 4: Valor mínimo negativo (extensão de sinal correta)
        input_16 <= "1000000000000000"; -- -32768 em decimal
        wait for 10 ns;

        -- Teste 5: Entrada de valor zero
        input_16 <= "0000000000000000"; -- 0 em decimal
        wait for 10 ns;

        -- Teste 6: Valor intermediário positivo
        input_16 <= "0000000010101101"; -- 109 em decimal
        wait for 10 ns;

        -- Teste 7: Valor intermediário negativo
        input_16 <= "1111111101101101"; -- -51 em decimal
        wait for 10 ns;

        -- Finaliza os testes
        wait;
    end process;

end behavior;
