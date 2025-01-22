----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Milene
-- 
-- Create Date:    11:17:41 04/26/2023 
-- Design Name: 
-- Module Name:    mux2 - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
	port (
		E : in std_logic_vector(0 to 1);
		Sel : in std_logic;
		Saida : out std_logic
	);
end mux2;

architecture Behavioral of mux2 is

begin
	Saida <= (not Sel and E(0)) or (Sel and E(1));

end Behavioral;

