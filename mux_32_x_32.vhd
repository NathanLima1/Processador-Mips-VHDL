----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Milene
-- 
-- Create Date:    15:34:42 06/21/2022 
-- Module Name:    mux_32_x_32 - Behavioral 
-- 
-- Multiplexador de 32 entradas. Cada entrada é uma palavra de 32 bits. Para isso,
-- é necessária a inclusão da biblioteca tipo que define um vetor de palavras.
-- Além disso, para a implementação comportamental do multiplexador, foi utilizada
-- a função to_integer da biblioteca IEEE.NUMERIC_STD.ALL juntamente com o type
-- casting para uma representação sem sinal (unsigned) permitindo a conversão do
-- endereço de seleção para um índice do vetor.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.tipo;

entity mux_32_x_32 is
	port (
		entrada : in tipo.vetor_de_palavras(0 to 31);
 	   selecao : in std_logic_vector(4 downto 0);
		saida : out std_logic_vector(31 downto 0) );
end mux_32_x_32;

architecture Behavioral of mux_32_x_32 is

begin
  saida <= entrada(to_integer(unsigned(selecao)));
end Behavioral;