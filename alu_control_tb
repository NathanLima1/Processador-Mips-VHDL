LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ALU_Control_TB IS
END ALU_Control_TB;

ARCHITECTURE behavior OF ALU_Control_TB IS 

    -- Componente a ser testado
    COMPONENT alu_control
    PORT(
         funct : IN std_logic_vector(5 downto 0);
         alu_op : IN std_logic_vector(1 downto 0);
         a_inverte, b_inverte : OUT std_logic;
         operacao : OUT std_logic_vector(1 downto 0)
    );
    END COMPONENT;
   
    -- Sinais para o teste
    SIGNAL funct : std_logic_vector(5 downto 0) := (others => '0');
    SIGNAL alu_op : std_logic_vector(1 downto 0) := (others => '0');
    SIGNAL a_inverte, b_inverte : std_logic;
    SIGNAL operacao : std_logic_vector(1 downto 0);
    
BEGIN

    -- Instancia o componente
    uut: alu_control PORT MAP (
          funct => funct,
          alu_op => alu_op,
          a_inverte => a_inverte,
          b_inverte => b_inverte,
          operacao => operacao
    );

    -- Processo de estimulação
    stim_proc: PROCESS
    BEGIN				    
        -- Testa soma padrão (LW/SW)
        alu_op <= "00";
        funct <= "000000";
        WAIT FOR 10 ns;
        
        -- Testa operação tipo R (Subtração)
        alu_op <= "10";
        funct <= "100010";
        WAIT FOR 10 ns;
        
        -- Testa operação tipo R (AND)
        funct <= "100100";
        WAIT FOR 10 ns;
        
        -- Testa operação tipo R (NOR)
        funct <= "100111";
        WAIT FOR 10 ns;
        
        -- Testa operação tipo R (OR)
        funct <= "100101";
        WAIT FOR 10 ns;
        
        -- Testa operação tipo R (SLT)
        funct <= "101010";
        WAIT FOR 10 ns;
        
        -- Testa BEQ
        alu_op <= "01";
        funct <= "000000";
        WAIT FOR 10 ns;
        
        -- Finaliza a simulação
        WAIT;
    END PROCESS;
END behavior;
