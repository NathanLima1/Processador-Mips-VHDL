----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Nathan Lima
-- 
-- Create Date:    15:17:50 01/22/2025 
-- Design Name: 
-- Module Name:    PC - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Program counter
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

--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    port(
        Clk: in std_logic;
        Reset: in std_logic;
        Enable: in std_logic;
        Entrada: in std_logic_vector(31 downto 0);
        Saida: out std_logic_vector(31 downto 0)
    );
end PC;

architecture Behavioral of PC is
    signal Q: std_logic_vector(31 downto 0);

    constant RESET_ADDR: std_logic_vector(31 downto 0) := X"00003000";

begin
    process(Reset)
    begin
        if Reset = '1' then
            Q <= RESET_ADDR;
        end if;
    end process;

    FF_D_Clear: for i in 0 to 31 generate
        FF: entity work.FlipFlop_D_C
            port map(
                D => Entrada(i),
                Clk => Clk,
                Clear => Reset,
                Q => Q(i)
            );
    end generate;

    FF_D_Preset: for i in 0 to 31 generate
        FF: entity work.FlipFlop_D_P
            port map(
                D => Entrada(i);
                Clk => Clk;
                Preset => Reset,
                Q => Q(i)
            );
    end generate;

    process(Clk)
    begin
        if rising_edge(Clk) then
            if Enable = '1' then
                Saida <= Q;
            end if;
        end if;
    end process;
end Behavioral;