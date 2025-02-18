----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Leonardo Guimarães de Oliveira
-- 
-- Create Date:    15:17:50 01/22/2025 
-- Design Name: 
-- Module Name:    FlipFlopD - Behavioral 
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

--use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity flipflop_d_clear_enable is
	port(
		D : in std_logic;
		Q : out std_logic;
		Enable : in std_logic;
		clk : in std_logic;
    Clear: in std_logic
	);

end flipflop_d_clear_enable;

architecture Behavioral of flipflop_d_clear_enable is
begin
	process (clk, Clear)
	begin

    if Clear='1' then
      Q <= '0';

		elsif falling_edge(clk) then
			if Enable='1' then
				Q <= D;
			end if;
		end if;

	end process;
end Behavioral;