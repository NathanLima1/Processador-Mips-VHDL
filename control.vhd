----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Nathan Lima
-- 
-- Create Date:    08:07:15 01/24/2025 
-- Design Name: 
-- Module Name:    control - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control is 
    port(
        opcode: in std_logic_vector(5 downto 0);
        alu_op: out std_logic_vector(1 downto 0);
        reg_write, reg_dst, alu_src, branch, mem_write, mem_to_reg, jump, mem_read: out std_logic
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
        jump <= '0';

        if opcode = "000000" then -- R
            alu_op <= "10";
            reg_dst <= '1';
            reg_write <= '1';

        elsif opcode = "001000" then -- I
            reg_write <= '1';
            alu_src <= '1';

        elsif opcode = "100011" then -- LW
            reg_write <= '1';
            alu_src <= '1';
            mem_to_reg <= '1';
            mem_read <= '1';

        elsif opcode = "101011" then-- SW
            alu_src <= '1';
            mem_write <= '1';

        elsif opcode = "000100" then --BEQ
            alu_op <= "01";
            branch <= '1';

        elsif opcode = "000010" then --j
            jump <= '1';

        else
            alu_op <= "00";
            reg_dst <= '0';
            reg_write <= '0';
        end if;
    end process;
end Behavioral;