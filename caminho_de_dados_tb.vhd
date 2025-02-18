library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity caminho_de_dados_tb is
end caminho_de_dados_tb;

architecture tb of caminho_de_dados_tb is
    signal CLK: std_logic := '0';
    signal debugEndereco: std_logic_vector(31 downto 0) := (others => '0');
    signal debugPalavra: std_logic_vector(31 downto 0);
    signal debug_pc_out: std_logic_vector(31 downto 0);
	 signal debug_ula_out: std_logic_vector(31 downto 0);
	 
    constant CLK_PERIOD: time := 10 ns;
    
begin
    
    -- Instância do caminho de dados
    uut: entity work.caminho_de_dados
        port map (
            CLK => CLK,
            debugEndereco => debugEndereco,
            debugPalavra => debugPalavra,
				pc_outt => debug_pc_out,
				debug_ula => debug_ula_out
        );
    
    -- Processo de geração do clock
    process
    begin
        while now < 1000 ns loop -- Executa por um tempo definido
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;
    
    -- Processo de estímulo
    process
    begin
        wait for 20 ns;
        
        debugEndereco <= x"00000010";
        wait for 20 ns;
        
        debugEndereco <= x"00000020";
        wait for 20 ns;
        
        debugEndereco <= x"00000030";
        wait for 20 ns;
        
        wait;
    end process;
    
end tb;
