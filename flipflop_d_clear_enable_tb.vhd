--------------------------------------------------------------------------------
-- Engineer: Chat GPT
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Testbench para flipflop_d_clear_enable
entity tb_flipflop_d_clear_enable is
end tb_flipflop_d_clear_enable;

architecture Behavioral of tb_flipflop_d_clear_enable is
    -- Declaração do componente flipflop_d_clear_enable
    component flipflop_d_clear_enable
        port(
            D     : in std_logic;
            Q     : out std_logic;
            Enable : in std_logic;
            clk   : in std_logic;
            Clear : in std_logic
        );
    end component;

    -- Sinais para conectar ao flip-flop
    signal D     : std_logic := '0';
    signal Q     : std_logic;
    signal Enable : std_logic := '0';
    signal clk   : std_logic := '0';
    signal Clear : std_logic := '0';

begin
    -- Instancia o flip-flop
    uut: flipflop_d_clear_enable
        port map (
            D => D,
            Q => Q,
            Enable => Enable,
            clk => clk,
            Clear => Clear
        );

    -- Processo para gerar o clock
    clk_process: process
    begin
        -- Gera o clock com período de 10 ns (5 ns de '0' e 5 ns de '1')
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
        Enable <= '0';
        D <= '0';
        wait for 10 ns;

        -- Teste 1: Clear ativo (Q deve ser 0)
        Clear <= '1';
        wait for 10 ns;

        -- Teste 2: Clear desativado, Enable=0, D=1, espera-se Q=0, pois Enable está inativo
        Clear <= '0';
        Enable <= '0';
        D <= '1';
        wait for 10 ns;

        -- Teste 3: Clear desativado, Enable=1, D=1, espera-se Q=1 na borda de clk
        Enable <= '1';
        D <= '1';
        wait for 10 ns;

        -- Teste 4: Clear desativado, Enable=1, D=0, espera-se Q=0 na borda de clk
        D <= '0';
        wait for 10 ns;

        -- Teste 5: Clear ativo novamente (Q deve ser 0)
        Clear <= '1';
        wait for 10 ns;

        -- Teste 6: Clear desativado, Enable=1, D=1, espera-se Q=1 na borda de clk
        Clear <= '0';
        Enable <= '1';
        D <= '1';
        wait for 10 ns;

        -- Teste 7: Clear ativo novamente (Q deve ser 0)
        Clear <= '1';
        wait for 10 ns;

        -- Teste 8: Clear desativado, Enable=0, D=1, espera-se Q=0, pois Enable está inativo
        Clear <= '0';
        Enable <= '0';
        D <= '1';
        wait for 10 ns;

        -- Teste 9: Clear desativado, Enable=1, D=0, espera-se Q=0 na borda de clk
        Enable <= '1';
        D <= '0';
        wait for 10 ns;

        -- Teste 10: Clear desativado, Enable=1, D=1, espera-se Q=1 na borda de clk
        D <= '1';
        wait for 10 ns;

        -- Teste 11: Clear desativado, Enable=0, D=0, espera-se Q=0, pois Enable está inativo
        Enable <= '0';
        D <= '0';
        wait for 10 ns;

        -- Teste 12: Clear desativado, Enable=1, D=1, espera-se Q=1 na borda de clk
        Enable <= '1';
        D <= '1';
        wait for 10 ns;

        -- Teste 13: Clear ativo (Q deve ser 0)
        Clear <= '1';
        wait for 10 ns;

        -- Teste 14: Clear desativado, Enable=0, D=0, espera-se Q=0
        Clear <= '0';
        Enable <= '0';
        D <= '0';
        wait for 10 ns;

        -- Teste 15: Clear desativado, Enable=1, D=1, espera-se Q=1
        Enable <= '1';
        D <= '1';
        wait for 10 ns;

        -- Teste 16: Clear ativo novamente (Q deve ser 0)
        Clear <= '1';
        wait for 10 ns;

        -- Finaliza o processo de estímulo
        wait;
    end process;
end Behavioral;
