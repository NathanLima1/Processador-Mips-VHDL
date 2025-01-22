library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Control is 
    port(
        opcode: in std_logic_vector(5 downto 0);
        alu_op: out std_logic_vector(1 downto 0);
        reg_write, reg_dst, alu_src, branch, mem_write, mem_to_reg, jump, mem_read out std_logic
    );
end Control;

architecture Behavioral of Control is
begin
    process(opcode)
    begin
        reg_dst <= '0';
        branch <= '0';
        mem_read <= '0';
        mem_to_reg <= '0';
        alu_op <= "00";
        mem_write <= '0';
        alu_src <= '0';
        reg_write <= '0';

        case opcode is
            when "000000" => -- R
                alu_op <= "10"
                reg_dst <= '1';
                reg_write <= '1';
                
            when "001000" => -- I
                reg_write <= '1';
                alu_src <= '1';

            when "100011" => -- LW
                reg_write <= '1';
                alu_src <= '1';
                mem_to_reg <= '1';
                mem_read <= '1';

            when "101011" => -- SW
                alu_src <= '1';
                mem_write <= '1';

            when "000100" => --BEQ
                alu_op <= "01";
                branch <= '1';

            when "000010" => --j
                jump <= '1';
        end case;
    end process;
end Behavioral;