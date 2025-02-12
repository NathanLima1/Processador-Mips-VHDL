
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Testbench para FlipFlop_D_C
entity tb_FlipFlop_D_C is
end tb_FlipFlop_D_C;

architecture Behavioral of tb_FlipFlop_D_C is
    -- Component declaration for the FlipFlop_D_C
    component FlipFlop_D_C
        port(
            D     : in std_logic;
            Q     : out std_logic;
            Clear : in std_logic;
            clk   : in std_logic
        );
    end component;

    -- Signals to connect to the FlipFlop_D_C
    signal D     : std_logic := '0';
    signal Q     : std_logic;
    signal Clear : std_logic := '0';
    signal clk   : std_logic := '0';

begin
    -- Instancia o flip-flop D
    uut: FlipFlop_D_C
        port map (
            D => D,
            Q => Q,
            Clear => Clear,
            clk => clk
        );

    -- Processo para gerar o clock
    clk_process: process
    begin
        -- Gera o clock com período de 10 ns
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    -- Processo para aplicar estímulos
    stimulus_process: process
    begin
        -- Inicializa os sinais
        Clear <= '0';
        D <= '0';
        wait for 10 ns;

        -- Teste 1: Clear ativo (Q deve ser 0)
        Clear <= '1';
        wait for 10 ns;

        -- Teste 2: Clear desativado, D=1, espera-se Q=1 na borda de clk
        Clear <= '0';
        D <= '1';
        wait for 10 ns;

        -- Teste 3: D=0, espera-se Q=0 na borda de clk
        D <= '0';
        wait for 10 ns;

        -- Teste 4: Clear ativo novamente (Q deve ser 0)
        Clear <= '1';
        wait for 10 ns;

        -- Teste 5: Clear desativado, D=1, espera-se Q=1 na borda de clk
        Clear <= '0';
        D <= '1';
        wait for 10 ns;

        -- Teste 6: Clear ativo novamente (Q deve ser 0)
        Clear <= '1';
        wait for 10 ns;

        -- Finaliza o processo de estímulo
        wait;
    end process;
end Behavioral;

