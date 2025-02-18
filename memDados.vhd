----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Milene
-- 
-- Create Date:    13:50:52 07/01/2022 
-- Module Name:    memDados - Behavioral 
-- 
-- Memoria de dados do MIPS simplificada, contendo somente 256 palavras de 32 bits.
-- Essa memoria eh endereçada por bytes, mas a implementacao usa um vetor de palavras,
-- portanto, eh necessario converter o endereco de memoria de bytes para palavras.
-- A memoria possui 2 sinais adicionais para depuracao do processador (debug). Eles
-- permitem que no testbench do processador diversas posicoes da memoria sejam acessadas
-- independentemente de instrucoes do processador.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memDados is
	port (
		DadoLido : out std_logic_vector (31 downto 0);
		DadoEscrita : in std_logic_vector (31 downto 0);
		Endereco : in std_logic_vector (31 downto 0);
		EscreverMem : in std_logic;
		Clock : in std_logic;
		LerMem : in std_logic;
		DebugEndereco : in std_logic_vector(31 downto 0);
		DebugPalavra : out std_logic_vector(31 downto 0));
end memDados;

architecture Behavioral of memDados is
    type tipoMemoria is array(0 to 255) of std_logic_vector(31 downto 0);
    signal memoria : tipoMemoria;
begin
	process(Clock)
	begin
		if rising_edge(Clock) AND (EscreverMem='1') then
			-- Enderecar o vetor memoria por palavras
			-- converter de bytes para palavras (ignorar os 2 bits mais a direta) 
			-- limitar a memoria para somente 256 palavras (ignorar os bits acima 
			-- do decimo bit do endereco
			memoria(to_integer(unsigned(Endereco(9 downto 2)))) <= DadoEscrita;
		end if;
	end process;
	
	DadoLido <= memoria(to_integer(unsigned(Endereco(9 downto 2)))) when LerMem = '1';
	DebugPalavra <= memoria(to_integer(unsigned(DebugEndereco(9 downto 2))));
end Behavioral;