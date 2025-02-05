library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux_2_x_5 is
end tb_mux_2_x_5;

architecture behavior of tb_mux_2_x_5 is
    component mux_2_x_5
        Port (
            A: in STD_LOGIC_VECTOR (4 downto 0);
            B: in STD_LOGIC_VECTOR (4 downto 0);
            Sel: in STD_LOGIC;
            Saida: out STD_LOGIC_VECTOR (4 downto 0)
        );
    end component;

    signal A : STD_LOGIC_VECTOR (4 downto 0);
    signal B : STD_LOGIC_VECTOR (4 downto 0);
    signal Sel : STD_LOGIC;
    signal Saida : STD_LOGIC_VECTOR (4 downto 0);

begin
    uut: mux_2_x_5
        port map (
            A => A,
            B => B,
            Sel => Sel,
            Saida => Saida
        );

    -- Processo de estímulo para os testes
    stim_proc: process
    begin        
        -- Teste 1: Sel = 0, espera-se a saída igual a A
        A <= "00001";  -- A = 1
        B <= "11111";  -- B = -1
        Sel <= '0';    -- Saída deve ser igual a A
        wait for 10 ns;

        -- Teste 2: Sel = 1, espera-se a saída igual a B
        A <= "00001";  -- A = 1
        B <= "11111";  -- B = -1
        Sel <= '1';    -- Saída deve ser igual a B
        wait for 10 ns;

        -- Teste 3: Sel = 0, A e B com valores diferentes, espera-se a saída igual a A
        A <= "01010";  -- A = 10
        B <= "10101";  -- B = -11
        Sel <= '0';    -- Saída deve ser igual a A
        wait for 10 ns;

        -- Teste 4: Sel = 1, A e B com valores diferentes, espera-se a saída igual a B
        A <= "01010";  -- A = 10
        B <= "10101";  -- B = -11
        Sel <= '1';    -- Saída deve ser igual a B
        wait for 10 ns;

        -- Teste 5: A e B com o mesmo valor, espera-se que a saída seja igual a A (ou B)
        A <= "11100";  -- A = -4
        B <= "11100";  -- B = -4
        Sel <= '0';    -- Saída deve ser igual a A (ou B, já que são iguais)
        wait for 10 ns;

        -- Teste 6: A e B com o mesmo valor, espera-se que a saída seja igual a B (ou A)
        A <= "11100";  -- A = -4
        B <= "11100";  -- B = -4
        Sel <= '1';    -- Saída deve ser igual a B (ou A, já que são iguais)
        wait for 10 ns;

        -- Teste 7: Testando os limites máximos e mínimos de 5 bits
        A <= "11111";  -- A = -1
        B <= "00000";  -- B = 0
        Sel <= '0';    -- Saída deve ser igual a A
        wait for 10 ns;

        -- Teste 8: Testando os limites máximos e mínimos de 5 bits
        A <= "11111";  -- A = -1
        B <= "00000";  -- B = 0
        Sel <= '1';    -- Saída deve ser igual a B
        wait for 10 ns;

        -- Finaliza os testes
        wait;
    end process;

end behavior;
