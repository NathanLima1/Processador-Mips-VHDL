----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:00:55 07/01/2022 
--
-- Memoria de instrucoes MIPS simplificada, contendo as instrucoes em binario.
-- Essa memoria eh somente leitura e endereçada por bytes, mas a implementacao 
-- usa um vetor de palavras, portanto, eh necessario converter o endereco de 
-- memoria de bytes para palavras.
-- A memoria eh simplificada e possui no maximo 256 instrucoes.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memInstrucoes is
	port (
		Endereco : in std_logic_vector(31 downto 0);
		Palavra : out std_logic_vector(31 downto 0)
	);
end memInstrucoes;

architecture Behavioral of memInstrucoes is
	type tipoMemoria is array(0 to 255) of std_logic_vector(31 downto 0);
	signal memoria : tipoMemoria;    
	 
begin
	memoria(0 to 11) <= 
	 ("00100000000010000000000000000001", "00100000000010010000000000101000", 
    "10101100000010000000000000000000", "10101100000010000000000000000100", 
    "00100000000010100000000000001000", "00010001010010010000000000000110", 
    "10001101010010111111111111111100", "10001101010011001111111111111000", 
    "00000001011011000110100000100000", "10101101010011010000000000000000", 
    "00100001010010100000000000000100", "00001000000100000000000000000101");

-- Codigo gerador da sequencia de fibonacci montada para o MIPS compacto com segmento 
-- de dados iniciado em 0 do MARS: Settings -> Memory Configuration, selecione a opção 
-- Compact, Data at Address 0 e clique no botão Apply and Close
-- .text		
-- 	addi $t0, $zero, 1	# define o valor inicial da sequencia
-- 	addi $t1, $zero, 40	# define a posicao final da sequencia
-- 	
-- 	sw $t0, 0($zero)	# armazena o valor inicial na primeira posicao da memoria de dados
-- 	sw $t0, 4($zero)	# armazena o valor inicial na segunda posicao da memoria de dados	
-- 	
-- 	addi $t2, $zero, 8	# inicia o contador na terceira posicao da memoria de dados	
-- 	
-- for:	beq $t2, $t1, fim	# verifica se o contador ja chegou a ultima posicao da sequencia
-- 	lw $t3, -4($t2)		# le ultimo valor adicionado a sequencia
-- 	lw $t4, -8($t2)		# le penultimo valor adicionado a sequencia	
-- 	add $t5, $t3, $t4	# adiciona os dois valores lidos anteriormente
-- 	sw $t5, 0($t2)		# armazena o resultado na sequencia
-- 	addi $t2, $t2, 4	# passa o contador para a proxima posicao da sequencia
-- 	j for			
-- fim:

	Palavra <= memoria(to_integer(unsigned(Endereco(9 downto 2)))); 
	-- ignora os 2 bits menos significativos para converter de bytes para palavras.
end Behavioral;