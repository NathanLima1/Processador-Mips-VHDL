LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
USE ieee.numeric_std.ALL;
 
ENTITY caminho_de_dados_tb IS
END caminho_de_dados_tb;
 
ARCHITECTURE behavior OF caminho_de_dados_tb IS 
    COMPONENT caminho_de_dados
    PORT(
         CLK : IN  std_logic;
			pc_reset: in std_logic;
         debugEndereco : IN  std_logic_vector(31 downto 0);
         debugPalavra : OUT  std_logic_vector(31 downto 0);
         pc_outt : OUT  std_logic_vector(31 downto 0);
         debug_ula : OUT  std_logic_vector(31 downto 0);
			debug_ula_op1: out std_logic_vector(31 downto 0);
			debug_ula_op2: out std_logic_vector(31 downto 0);
			debug_rs: out std_logic_vector(31 downto 0);
			debug_rt: out std_logic_vector(31 downto 0);
			debug_wb:  out std_logic_vector(31 downto 0);
			debug_wb_addr: out std_logic_vector(4 downto 0);
			debug_muxf: out std_logic;
			debug_muxs: out std_logic

        );
    END COMPONENT;
    
	 signal debug_muxf: std_logic;
	signal debug_muxs: std_logic;

   --Inputs
   signal CLK : std_logic := '0';
	signal pc_reset: std_logic;
   signal debugEndereco : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal debugPalavra : std_logic_vector(31 downto 0);
   signal pc_outt : std_logic_vector(31 downto 0);
   signal debug_ula : std_logic_vector(31 downto 0);
	
	signal ula_1: std_logic_vector(31 downto 0);
	signal ula_2: std_logic_vector(31 downto 0);
	
	signal rs:  std_logic_vector(31 downto 0);
	signal rt:  std_logic_vector(31 downto 0);
	
	signal wb: std_logic_vector(31 downto 0);

	signal wb_addr: std_logic_vector(4 downto 0);	
	
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: caminho_de_dados PORT MAP (
          CLK => CLK,
			 pc_reset => pc_reset,
          debugEndereco => debugEndereco,
          debugPalavra => debugPalavra,
          pc_outt => pc_outt,
          debug_ula => debug_ula,
		    debug_ula_op1 => ula_1,
			 debug_ula_op2 => ula_2,
			 debug_rs => rs,
			 debug_rt => rt,
			 debug_wb => wb,
			 debug_wb_addr => wb_addr,
			 debug_muxf => debug_muxf,
			 debug_muxs => debug_muxs
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
--      -- hold reset state for 100 ns.
--		pc_reset <= '1';
--		wait for CLK_period*2;
--		pc_reset <= '0';
--		wait for CLk_period*50;
--		
--      debugEndereco <= std_logic_vector(to_signed(0, 32));
--		wait for CLk_period*2;
--		
--      debugEndereco <= std_logic_vector(to_signed(4, 32));
--		wait for CLk_period*2;
--		
--      debugEndereco <= std_logic_vector(to_signed(8, 32));
--		wait for CLk_period*2;
--		
--      debugEndereco <= std_logic_vector(to_signed(12, 32));
--		wait for CLk_period*2;
--		
--      debugEndereco <= std_logic_vector(to_signed(16, 32));
--		wait for CLk_period*2;
--		
--      debugEndereco <= std_logic_vector(to_signed(20, 32));
--		wait for CLk_period*2;
--		
--      debugEndereco <= std_logic_vector(to_signed(24, 32));
--		wait for CLk_period*2;
--		
--      debugEndereco <= std_logic_vector(to_signed(28, 32));
--		wait for CLk_period*2;

      -- insert stimulus here 
-- Inicializa o processador colocando o endereco inicial da memoria no PC
		-- Aguarda um pulso de clock e desativa a inicializacao
		pc_reset <= '1';
		wait for Clk_period;
		pc_reset <= '0';
		
		-- Espera por 50 pulsos de clock - numero aproximado para executar todo o 
		-- programa que gera as 10 primeiras posicoes da sequencia de fibonacci
		wait for Clk_period*50;
		
		-- Exibe as 11 primeiras posicoes da memoria de dados
		for i in 0 to 10 loop
			DebugEndereco <= std_logic_vector(to_unsigned(i*4,32));
			wait for Clk_period;
		end loop;
      wait;
   end process;

END;
