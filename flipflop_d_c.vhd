----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Nathan Lima
-- 
-- Create Date:    15:17:50 01/22/2025 
-- Design Name: 
-- Module Name:    FlipFlopD - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: FlipFlop D com clear e borda de subida
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

--use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity FlipFlop_D_C is
	port(
		D: in std_logic;
		Q : out std_logic;
		Clear : in std_logic;
		clk : in std_logic
	);

end FlipFlop_D_C;

architecture Behavioral of FlipFlop_D_C is
begin
	process (clk)
	begin
		if Clear='1' then
			Q <= '0';
		elsif rising_edge(clk) then
			Q <= D;
		end if;
	end process;

end Behavioral;
