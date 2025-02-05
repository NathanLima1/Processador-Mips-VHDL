----------------------------------------------------------------------------------
-- Engineer: Leonardo Guimarães de Oliveira
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflop_d_clear_enable_32 is
    port(
        D: in std_logic_vector(31 downto 0);
        Q: out std_logic_vector(31 downto 0);
        Enable: in std_logic;
        Clear: in std_logic;
        clk: in std_logic
    );
end flipflop_d_clear_enable_32;

architecture Behavioral of flipflop_d_clear_enable_32 is
    component flipflop_d_clear_enable is
        port(
            D, Enable, Clear, clk: in std_logic;
            Q: out std_logic
        );
    end component;
begin
    gen_flipflops: for i in 0 to 31 generate
        ff: flipflop_d_clear_enable port map(
                D => D(i),
                Enable => Enable,
                Clear => Clear,
                clk => clk,
                Q => Q(i)
            );
    end generate gen_flipflops;
end Behavioral;
