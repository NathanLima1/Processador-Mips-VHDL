library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC_Register is
    Port (
        clk    : in STD_LOGIC;
        clear  : in STD_LOGIC;
        enable : in STD_LOGIC;
        preset : in STD_LOGIC;
        reset  : in STD_LOGIC;
        d_in   : in STD_LOGIC_VECTOR(31 downto 0);
        q_out  : out STD_LOGIC_VECTOR(31 downto 0)
    );
end PC_Register;

architecture Behavioral of PC_Register is
    signal reg_value : STD_LOGIC_VECTOR(31 downto 0) := X"00003000"; 
begin

    process (clk, reset, clear, preset)
    begin
        if reset = '1' then
            reg_value <= X"00003000"; 
        elsif clear = '1' then
            reg_value <= (others => '0');  
        elsif preset = '1' then
            reg_value <= (others => '1'); 
        elsif rising_edge(clk) then
            if enable = '1' then
                reg_value <= d_in;  
            end if;
        end if;
    end process;

    q_out <= reg_value;
end Behavioral;
