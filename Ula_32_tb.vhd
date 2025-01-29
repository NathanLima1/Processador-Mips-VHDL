library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_Ula_32 is
end tb_Ula_32;

architecture behavior of tb_Ula_32 is
    -- Component declaration for the ULA_32
    component Ula_32
        Port (
            A : in std_logic_vector(31 downto 0);
            B : in std_logic_vector(31 downto 0);
            Anegate : in std_logic;
            Bnegate : in std_logic;
            Operacao : in std_logic_vector(1 downto 0);
            Resultado : out std_logic_vector(31 downto 0);
            Zero : out std_logic
        );
    end component;

    -- Signals to connect to the ULA_32
    signal A : std_logic_vector(31 downto 0);
    signal B : std_logic_vector(31 downto 0);
    signal Anegate : std_logic;
    signal Bnegate : std_logic;
    signal Operacao : std_logic_vector(1 downto 0);
    signal Resultado : std_logic_vector(31 downto 0);
    signal Zero : std_logic;

begin
    -- Instantiate the Ula_32 component
    uut: Ula_32 port map (
        A => A,
        B => B,
        Anegate => Anegate,
        Bnegate => Bnegate,
        Operacao => Operacao,
        Resultado => Resultado,
        Zero => Zero
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test 1: Operação AND (Operacao = "00")
        -- A = 00000001 (1), B = 00000001 (1)
        -- Operação AND: Resultado = 00000001 (1), Zero = 0
        A <= X"00000001";  -- 1
        B <= X"00000001";  -- 1
        Anegate <= '0';
        Bnegate <= '0';
        Operacao <= "00";  -- AND
        wait for 10 ns;
        -- Esperado: Resultado = 00000001 (1), Zero = 0

        -- Test 2: Operação OR (Operacao = "01")
        -- A = 00000001 (1), B = 00000000 (0)
        -- Operação OR: Resultado = 00000001 (1), Zero = 0
        A <= X"00000001";  -- 1
        B <= X"00000000";  -- 0
        Anegate <= '0';
        Bnegate <= '0';
        Operacao <= "01";  -- OR
        wait for 10 ns;
        -- Esperado: Resultado = 00000001 (1), Zero = 0

        -- Test 3: Operação Soma (Operacao = "10")
        -- A = 00000001 (1), B = 00000001 (1)
        -- Operação de soma: Resultado = 00000010 (2), Zero = 0
        A <= X"00000001";  -- 1
        B <= X"00000001";  -- 1
        Anegate <= '0';
        Bnegate <= '0';
        Operacao <= "10";  -- Soma
        wait for 10 ns;
        -- Esperado: Resultado = 00000010 (2), Zero = 0

        -- Test 4: Operação SLT (Operacao = "11")
        -- A = 00000001 (1), B = 00000010 (2)
        -- A é menor que B, então Resultado = 00000001 (1), Zero = 0
        A <= X"00000001";  -- 1
        B <= X"00000010";  -- 2
        Anegate <= '0';
        Bnegate <= '0';
        Operacao <= "11";  -- SLT
        wait for 10 ns;
        -- Esperado: Resultado = 00000001 (1), Zero = 0 (A < B, então SLT deve ser 1)

        -- Test 5: Operação SLT com Anegate (Operacao = "11")
        -- A = 00000010 (2), B = 00000001 (1), Anegate = 1
        -- A negado (A = FFFFFFFE) é menor que B, então Resultado = 00000001 (1), Zero = 0
        A <= X"00000010";  -- 2
        B <= X"00000001";  -- 1
        Anegate <= '1';  -- A negado
        Bnegate <= '0';
        Operacao <= "11";  -- SLT
        wait for 10 ns;
        -- Esperado: Resultado = 00000001 (1), Zero = 0 (Anegate: A < B após inversão)

        -- Test 6: Zero Check
        -- A = 00000000 (0), B = 00000000 (0)
        -- Operação de soma: Resultado = 00000000 (0), Zero = 1
        A <= X"00000000";  -- 0
        B <= X"00000000";  -- 0
        Anegate <= '0';
        Bnegate <= '0';
        Operacao <= "10";  -- Soma
        wait for 10 ns;
        -- Esperado: Resultado = 00000000 (0), Zero = 1 (porque o resultado é zero)

        -- Finish simulation
        wait;
    end process;
end behavior;
