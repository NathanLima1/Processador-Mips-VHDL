----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Nathan Lima
-- 
-- Create Date:    07:59:36 01/24/2025 
-- Design Name: 
-- Module Name:    extensor_sinal - Behavioral 
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
use IEEE.numeric_std.all;

entity extensor_sinal is 
    port(
        input_16: in std_logic_vector(15 downto 0);
        output_32: out std_logic_vector(31 downto 0)
    );
end extensor_sinal;

architecture GenerateBased of extensor_sinal is
    begin
    output_32(15 downto 0) <= input_16;

    gen: for i in 16 to 31 generate
        output_32(i) <= input_16(15);
    end generate;
end GenerateBased;