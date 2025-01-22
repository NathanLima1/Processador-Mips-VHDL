library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ExtSinal is 
    port(
        input_16: in std_logic_vector(15 downto 0);
        output_32: out std_logic_vector(31 downto 0);
    );
end ExtSinal;

architecture GenerateBased of ExtSinal is
    begin
    output_32(15 downto 0) <= input_16;

    gen: for i in 16 to 31 generate
        output_32 <= input_16(15);
    end generate;
end GenerateBased;