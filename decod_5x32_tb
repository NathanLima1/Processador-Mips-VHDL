LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Decod_5x32_TB IS
END Decod_5x32_TB;

ARCHITECTURE behavior OF Decod_5x32_TB IS 

    -- Componente a ser testado
    COMPONENT Decod_5x32
    PORT(
         Entrada : IN std_logic_vector(4 downto 0);
         Saida : OUT std_logic_vector(31 downto 0)
    );
    END COMPONENT;
   
    -- Sinais para o teste
    SIGNAL Entrada : std_logic_vector(4 downto 0) := (others => '0');
    SIGNAL Saida : std_logic_vector(31 downto 0);
    
BEGIN

    -- Instancia o componente
    uut: Decod_5x32 PORT MAP (
          Entrada => Entrada,
          Saida => Saida
    );

    -- Processo de estimulação
    stim_proc: PROCESS
    BEGIN				    
        -- Testa diversas entradas
        Entrada <= "00000"; WAIT FOR 10 ns;
        Entrada <= "00001"; WAIT FOR 10 ns;
        Entrada <= "00010"; WAIT FOR 10 ns;
        Entrada <= "00100"; WAIT FOR 10 ns;
        Entrada <= "01000"; WAIT FOR 10 ns;
        Entrada <= "10000"; WAIT FOR 10 ns;
        Entrada <= "11111"; WAIT FOR 10 ns;
        
        -- Finaliza a simulação
        WAIT;
    END PROCESS;
END behavior;
