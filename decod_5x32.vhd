----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Nathan Lima
-- 
-- Create Date:    15:17:50 01/22/2025 
-- Design Name: 
-- Module Name:    decod_5x32 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Decodificador que tem 5 entradas de endereço que determina a saida
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

entity Decod_5x32 is
    port(
        Entrada: in std_logic_vector(4 downto 0);
        Saida: out std_logic_vector(31 downto 0)
    );
end Decod_5x32;

architecture Behavioral of Decod_5x32 is
begin
    process(Entrada)
        variable index: integer;
    begin
        Saida <= (others => '0');

        index:= to_integer(unsigned(Entrada));

        for i in 0 to 31 loop
            if i = index then
                Saida(i) <= '1';
            else
                Saida(i) <= '0';
            end if;
        end loop;
    end process;
end Behavioral;
