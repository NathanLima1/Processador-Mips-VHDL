----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Nathan Lima
-- 
-- Create Date:    08:12:01 01/24/2025 
-- Design Name: 
-- Module Name:    alu_control - Behavioral 
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

entity alu_control is 
    port(
        funct: in std_logic_vector(5 downto 0);
        alu_op: in std_logic_vector(1 downto 0);
        a_inverte, b_inverte: out std_logic;
        operacao: out std_logic_vector(1 downto 0)
    );
end alu_control;

architecture Behavioral of alu_control is
begin
    process(alu_op, funct)
    begin
        -- Valores padrao soma e LW/SW
        a_inverte <= '0';
        b_inverte <= '0';
        operacao <= "10";

        if alu_op = "10" then -- R
            case funct is
					
                when "100010" => -- Sub
                    b_inverte <= '1' ;
                
                when "100100" => -- And
                    operacao <= "00";

                when "100111" => -- Nor
                    a_inverte <= '1';
                    b_inverte <= '1';
                    operacao <= "00";

                when "100101" => -- Or
                    operacao <= "01";

                when "101010" => -- Slt
                    b_inverte <= '1';
                    operacao <= "11";
					 when others =>
						  null;
            end case;

        elsif alu_op = "01" then -- Beq
            b_inverte <= '1';
        end if;
    end process;
end Behavioral;