library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Or32 is
    port(
        entrada: in std_logic_vector(31 down to 0);
        saida: out std_logic
    );
end Or32;

architecture Behavioral of Or32 is
    signal n1: std_logic_vector(15 down to 0);
    signal n2: std_logic_vector(7 down to 0);
    signal n3: std_logic_vector(3 down to 0);
    signal n4: std_logic_vector(1 down to 0);
begin
    gen_n1: for i in 0 to 15 generate
        n1(i) <= entrada(2*i) or entrada(2*i+1);
    end generate;

    gen_n2: for i in 0 to 7 generate
        n2(i) <= n1(2*i) or n1(2*i+1);
    end generate;

    gen_n3: for i in 0 to 3 generate
        n3(i) <= n2(2*i) or n2(2*i+1);
    end generate;

    gen_n4: for i in 0 to 1 generate
        n4(i) <= n3(2*i) or n3(2*i+1);
    end generate;

    saida <= n4(0) or n4(1);
end Behavioral;