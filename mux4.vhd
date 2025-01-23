----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Nathan Lima
-- 
-- Create Date:    11:17:41 04/26/2023 
-- Design Name: 
-- Module Name:    mux_4 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity mux_4 is
    port(
        E: in std_logic(0 to 3);
        Sel: in std_logic_vector(1 downto 0);
        Saida: out std_logic
    );
end mux_4;

architecture Behavioral of mux_4 is
    signal a1: std_logic;
    signal a2: std_logic;
    signal a3: std_logic;
    signal a4: std_logic;
begin
    a1 <= (E(0) and (not Sel(0)) and (not Sel(1)));
    a2 <= (E(1) and (not Sel(1) and Sel(0)));
    a3 <= (E(2) and Sel(1) and (not Sel(0)));
    a4 <= (E(3) and Sel(1) and Sel(0));
    Saida <= a1 or a2 or a3 or a4;
end Behavioral;