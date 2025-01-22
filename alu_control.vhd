library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AluControl is 
    port(
        funct: in std_logic_vector(5 downto 0);
        alu_op: in std_logic_vector(1 downto 0);
        a_inverte, b_inverte: out std_logic;
        operacao: out std_logic_vector(1 downto 0)
    );
end AluControl;

architecture Behavioral of AluControl is
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
                    b_inverte <= '1 ;
                
                when "100100" => -- And
                    operacao <= "00"

                when "100111" => -- Nor
                    a_inverte <= '1';
                    b_inverte <= '1';
                    operacao <= "00";

                when "100101" => -- Or
                    operacao <= "01";

                when "101010" => -- Slt
                    b_inverte <= '1';
                    operacao <= "11";
            end case;

        elsif alu_op = "01" then -- Beq
            b_inverte <= '1'
        end if;
    end process;
end Behavioral;


