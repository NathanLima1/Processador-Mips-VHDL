library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity caminho_de_dados is
	port(
		-- Sinal de Clock
		CLK: in std_logic;
		
		-- Entradas
		debugEndereco: in std_logic_vector(31 downto 0);
		
		-- Saídas
		debugPalavra: out std_logic_vector(31 downto 0);
		pc_outt: out std_logic_vector(31 downto 0);
		debug_ula: out std_logic_vector(31 downto 0)
	);
end caminho_de_dados;

architecture Behavioral of caminho_de_dados is
    -- Fios do PC
	signal pc_in: std_logic_vector(31 downto 0) := x"00003000";
	signal pc_out: std_logic_vector(31 downto 0);
	
    -- Fio do PC+4
    signal pc_mais_quatro: std_logic_vector(31 downto 0); 
    
    -- Fio da instrução que veio da memória de instruções
    signal instrucao: std_logic_vector(31 downto 0);
    
    -- Fio para guardar o endereço de jump
    signal jump_adr_from_deslocador_2b_esq : std_logic_vector(31 downto 0);
    
    -- Fios para as saídas da unidade de controle
    signal jump_sel: std_logic;
    signal reg_dst_cable: std_logic;
    signal reg_write_cable: std_logic;
    signal alu_op_cable: std_logic_vector(1 downto 0);
    signal branch_cable: std_logic;
    signal alu_src_cable: std_logic;
    signal mem_write_cable: std_logic;
    signal mem_read_cable: std_logic;
    signal mem_to_reg_cable: std_logic;
    
    -- Fio para o registrador selecionado para a escrita
    signal reg_to_write: std_logic_vector(4 downto 0);
    
    -- Fios para o endereço de desvio
    signal desvio_addr_pre_alinhamento: std_logic_vector(31 downto 0);
    signal desvio_addr_pos_alinhamento: std_logic_vector(31 downto 0);
    
    -- Fios para a unidade de controle da ULA
    signal a_inverte_cable: std_logic;
    signal b_inverte_cable: std_logic;
    signal operacao_da_ula_cable: std_logic_vector(1 downto 0);
    
    -- Fios da ULA
    signal result_zero_cable: std_logic;
    signal ula_result_cable: std_logic_vector(31 downto 0);
    
    -- Fio para identificar o resultado entre a soma do endereço de desvio e o PC
    signal soma_branch_pc_cable: std_logic_vector(31 downto 0);
    
    -- Fio para identificar branch
    signal branch_if_eqz_cable: std_logic;

	-- Fio para conectar a saída do primeiro mux do PC
    signal first_mux_pc: std_logic_vector(31 downto 0);

	-- Fios para os operandos da ULA
    signal first_reg_content: std_logic_vector(31 downto 0);
    signal second_reg_content: std_logic_vector(31 downto 0);
    signal ula_second_op: std_logic_vector(31 downto 0);
    
    -- Fio para a saída da memória de dados
    signal dado_lido_cable: std_logic_vector(31 downto 0);
    
    -- Fio escreve dado
    signal data_write_cable: std_logic_vector(31 downto 0);
	 
	 -- Fio inicial do pc reset
	 signal pc_reset_init: std_logic := '1';

begin
    Instance_PC: entity work.PC 
    	Port Map(
	-- Entradas
            CLK => clk, 
	    reset => pc_reset_init,
            
            d_in => pc_in,
            
            -- Saídas
            q_out => pc_out
		);
	 pc_reset_init <= '0';
	 
    -- Incrementador do PC
    Instance_Somador32bits_PC: entity work.Somador32bits
	 Port Map(
        	-- Entradas do incrementador do PC
            A => pc_out,
            B => std_logic_vector(to_unsigned(4, 32)), 
            
            -- Saídas do incrementador do PC
            Soma => pc_mais_quatro
        );
	
   
    Instance_MemoriaInstrucoes: entity work.memInstrucoes
    	Port Map(
        	-- Entradas
         Endereco => pc_out,
            
         -- Saídas
        	Palavra => instrucao
        );
    
     
    Instance_Deslocador2bits_esq_jump: entity work.deslocador_2b_esq
    	Port Map(
        	-- Entradas
         entrada => instrucao,
            
         -- Saídas
         saida => jump_adr_from_deslocador_2b_esq
        );
    
    -- O endereço de jump deslocado recebe os 4 bits mais à esquerda 
    -- do endereço do PC+4
    --jump_adr_from_deslocador_2b_esq(31 downto 28) <= pc_mais_quatro(31 downto 28);
    
    Instance_Unidade_de_Controle: entity work.control
    	Port Map(
        	-- Entradas:
         opcode => instrucao(31 downto 26),
          	
         -- Saídas
         alu_op => alu_op_cable,
         reg_write => reg_write_cable,
         reg_dst => reg_dst_cable,
         alu_src => alu_src_cable,
         branch => branch_cable,
         mem_write => mem_write_cable,
         mem_to_reg => mem_to_reg_cable,
        	jump => jump_sel,
         mem_read => mem_read_cable
      );
        
	
    Instance_Mux2x5_Sel_Reg: entity work.mux_2_X_5
    	Port Map(
        	-- Entradas
        	A => instrucao(20 downto 16),
         B => instrucao(15 downto 11),
         Sel => reg_dst_cable,
        	
        	-- Saídas
         Saida => reg_to_write
      );
        
    -- Banco de registradores
    Instance_Banco_Reg: entity work.banco_reg
    	Port Map(
        	-- Entradas
            reg1_addr => instrucao(25 downto 21),
            reg2_addr => instrucao(20 downto 16),
            write_data => data_write_cable,
            reg_write => reg_write_cable,
				addr_write => reg_to_write,
            clock => CLK,
            
            -- Saídas
				read_reg1 => first_reg_content,
            read_reg2 => second_reg_content
        );
    
    -- Extensão de sinal do imediato de desvio
    Instance_Extensao_Sinal_EndDesvio: entity work.extensor_sinal
    	Port Map(
        	-- Entradas
            input_16 => instrucao(15 downto 0),
            
        	-- Saídas
            output_32 => desvio_addr_pre_alinhamento
        );
    
    -- Alinha o incremento do descvio
    Instance_Deslocador_2b_esq_alinhamento_desvio: entity work.deslocador_2b_esq
    	Port Map(
        	-- Entradas
            entrada => desvio_addr_pre_alinhamento,
            
            -- Saídas
            saida => desvio_addr_pos_alinhamento
        );
        
    -- Unidade de controle da ULA
    Instance_Unidade_de_Controle_ULA: entity work.alu_control
    	Port Map(
        	-- Entradas
            funct => instrucao(5 downto 0),
            alu_op => alu_op_cable,
            
            -- Saídas
            a_inverte => a_inverte_cable,
            b_inverte => b_inverte_cable,
            operacao => operacao_da_ula_cable
        );
    
    -- Soma o incremento do branch com o PC+4
   	Instance_Somador32bits_Branch: entity work.Somador32bits
    	Port Map(
        	-- Entradas
            A => pc_mais_quatro,
            B => desvio_addr_pos_alinhamento,
            
            -- Saídas
            Soma => soma_branch_pc_cable
        );
        
    -- Instancia o primeiro mux que determina o próximo endereço
    -- do PC
    branch_if_eqz_cable <= branch_cable and result_zero_cable;
   	Instance_Mux2x32_Branch: entity work.mux_2_x_32
    	Port Map(
        	-- Entradas
            A => pc_mais_quatro,
            B => soma_branch_pc_cable,
            Sel => branch_if_eqz_cable,
            
            -- Saídas
        	Saida => first_mux_pc
        );
        
    -- Instancia o segundo mux que determina o próximo endereço
    -- do PC
	Instance_Mux2x32_Branch_PC_Jump: entity work.mux_2_x_32
    	Port Map(
        	-- Entradas
            A => first_mux_pc,
            B => pc_mais_quatro(31 downto 0),
            Sel => jump_sel,
            
            -- Saídas
            Saida => pc_in
        );
        
    Instance_Mux2x32_ULA_2nd_op: entity work.mux_2_x_32
    	Port Map(
        	-- Entradas
            A => second_reg_content,
            B => desvio_addr_pre_alinhamento,
            Sel => alu_src_cable,
            
            -- Saídas
        	Saida => ula_second_op
        );
    
    -- Unidade de Controle (ULA)
    Instance_ULA: entity work.Ula_32
    	Port Map(
        	-- Entradas
            A => first_reg_content,
            B => ula_second_op,
            Anegate => a_inverte_cable,
            Bnegate => b_inverte_cable,
            Operacao => operacao_da_ula_cable,
            
            -- Saídas
        	Resultado => ula_result_cable,
            Zero => result_zero_cable
        );
   	
    -- Memória de dados
    Instance_memDados: entity work.memDados
    	Port Map(
        	-- Entradas
            DadoEscrita => second_reg_content,
            Endereco => ula_result_cable,
            EscreverMem => mem_write_cable,
            CLOCK => CLK,
            LerMem => mem_read_cable,
            DebugEndereco => DebugEndereco,
            
            -- Saídas
				DadoLido => dado_lido_cable,
            DebugPalavra => DebugPalavra
        );
    
    -- Último Mux do caminho de dados
    Instance_Mux2x32_Memtoreg: entity work.mux_2_x_32
    	Port Map(
        	-- Entradas
            A => ula_result_cable,
            B => dado_lido_cable,
            Sel => mem_to_reg_cable,
            
            -- Saídas
            Saida => data_write_cable
        );
	
	pc_outt <= pc_out;
	debug_ula <= ula_result_cable;
    
end Behavioral;
