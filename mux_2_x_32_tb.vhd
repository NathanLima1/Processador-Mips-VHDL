library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux_2_x_32 is
end tb_mux_2_x_32;

architecture behavior of tb_mux_2_x_32 is
    component mux_2_x_32
        Port (
            A: in STD_LOGIC_VECTOR (31 downto 0);
            B: in STD_LOGIC_VECTOR (31 downto 0);
            Sel: in STD_LOGIC;
            Saida: out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    signal A : STD_LOGIC_VECTOR (31 downto 0);
    signal B : STD_LOGIC_VECTOR (31 downto 0);
    signal Sel : STD_LOGIC;
    signal Saida : STD_LOGIC_VECTOR (31 downto 0);

begin
    uut: mux_2_x_32
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
        A <= "00000000000000000000000000000001";  -- A = 1
        B <= "11111111111111111111111111111111";  -- B = -1
        Sel <= '0';
        wait for 10 ns;

        -- Teste 2: Sel = 1, espera-se a saída igual a B
        A <= "00000000000000000000000000000001";  -- A = 1
        B <= "11111111111111111111111111111111";  -- B = -1
        Sel <= '1';
        wait for 10 ns;

        -- Teste 3: Sel = 0, A com valor diferente de B, espera-se a saída igual a A
        A <= "00000000000000000000000000001000";  -- A = 8
        B <= "11111111111111111111111111110100";  -- B = -12
        Sel <= '0';
        wait for 10 ns;

        -- Teste 4: Sel = 1, A com valor diferente de B, espera-se a saída igual a B
        A <= "00000000000000000000000000001000";  -- A = 8
        B <= "11111111111111111111111111110100";  -- B = -12
        Sel <= '1';
        wait for 10 ns;

        -- Teste 5: Sel = 0, A e B com valores idênticos, espera-se a saída igual a A ou B (ambos são iguais)
        A <= "00000000000000000000000011111111";  -- A = 255
        B <= "00000000000000000000000011111111";  -- B = 255
        Sel <= '0';
        wait for 10 ns;

        -- Teste 6: Sel = 1, A e B com valores idênticos, espera-se a saída igual a A ou B (ambos são iguais)
        A <= "00000000000000000000000011111111";  -- A = 255
        B <= "00000000000000000000000011111111";  -- B = 255
        Sel <= '1';
        wait for 10 ns;

        -- Teste 7: Testando com valores maiores
        A <= "11111111111111111111111111111111";  -- A = -1
        B <= "00000000000000000000000000000001";  -- B = 1
        Sel <= '0';  -- Saída deve ser igual a A
        wait for 10 ns;

        -- Teste 8: Testando com valores menores
        A <= "00000000000000000000000000000000";  -- A = 0
        B <= "11111111111111111111111111111111";  -- B = -1
        Sel <= '1';  -- Saída deve ser igual a B
        wait for 10 ns;

        -- Finaliza os testes
        wait;
    end process;

end behavior;
