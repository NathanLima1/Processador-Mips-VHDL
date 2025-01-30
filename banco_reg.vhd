----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Leonardo Guimarães de Oliveira
-- 
-- Create Date:    15:43:41 01/29/2025 
-- Design Name: 
-- Module Name:    banco_reg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.tipo;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity banco_reg is
	port(
		reg1_addr, reg2_addr: in std_logic_vector(4 downto 0);
		addr_write: in std_logic_vector(4 downto 0);
		write_data: in std_logic_vector(31 downto 0);
		reg_write: in std_logic;
		
		read_reg1, read_reg2: out std_logic_vector(31 downto 0);
		
		clock: in std_logic
		);
		
end banco_reg;

architecture Behavioral of banco_reg is

	component flipflop_d_enable_32 is
		port(
			D: in std_logic_vector(31 downto 0);
			Q: out std_logic_vector(31 downto 0);
			Enable: in std_logic;
			clk: in std_logic
		);
	 end component;

	component Decod_5x32 is
		port(
			Entrada: in std_logic_vector(4 downto 0);
			Saida: out std_logic_vector(31 downto 0)
		);
	end component;

component mux_32_x_32 is
	port (
		entrada : in tipo.vetor_de_palavras(0 to 31);
 	   selecao : in std_logic_vector(4 downto 0);
		saida : out std_logic_vector(31 downto 0) );
end component;

signal decod_sel: std_logic_vector(0 to 31);
signal enable_flipflop: std_logic_vector(0 to 31);

signal saidaread: tipo.vetor_de_palavras(0 to 31);

begin

	decodeWrite: Decod_5x32 port map (
		Entrada => addr_write,
		Saida => decod_sel
	);
	gen_regs: for i in 0 to 31 generate
		enable_flipflop(i) <= reg_write and decod_sel(i);
		reg: flipflop_d_enable_32 port map (
			D => write_data,
			clk => clock,
			Enable => enable_flipflop(i),
			Q => saidaread(i)
		);
	end generate gen_regs;

	MuxReadReg1: mux_32_x_32 port map(
			selecao => reg1_addr,
			Saida => read_reg1,
			Entrada => saidaread
		);
		
	
	MuxReadReg2: mux_32_x_32 port map(
			selecao => reg2_addr,
			Saida => read_reg2,
			Entrada => saidaread
			
		);
end Behavioral;

