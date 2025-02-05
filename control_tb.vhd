----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Nathan Lima
-- 
-- Create Date:    16:12:11 05/02/2025
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Control_TB IS
END Control_TB;

ARCHITECTURE behavior OF Control_TB IS 

    -- Componente a ser testado
    COMPONENT Control
    PORT(
         opcode : IN std_logic_vector(5 downto 0);
         alu_op : OUT std_logic_vector(1 downto 0);
         reg_write, reg_dst, alu_src, branch, mem_write, mem_to_reg, jump, mem_read : OUT std_logic
    );
    END COMPONENT;
   
    -- Sinais para o teste
    SIGNAL opcode : std_logic_vector(5 downto 0) := (others => '0');
    SIGNAL alu_op : std_logic_vector(1 downto 0);
    SIGNAL reg_write, reg_dst, alu_src, branch, mem_write, mem_to_reg, jump, mem_read : std_logic;
    
BEGIN

    -- Instancia o componente
    uut: Control PORT MAP (
          opcode => opcode,
          alu_op => alu_op,
          reg_write => reg_write,
          reg_dst => reg_dst,
          alu_src => alu_src,
          branch => branch,
          mem_write => mem_write,
          mem_to_reg => mem_to_reg,
          jump => jump,
          mem_read => mem_read
    );

    -- Processo de estimulação
    stim_proc: PROCESS
    BEGIN				    
        -- Testa operação tipo R (opcode = "000000")
        opcode <= "000000";
        WAIT FOR 10 ns;
        
        -- Testa operação I (opcode = "001000")
        opcode <= "001000";
        WAIT FOR 10 ns;
        
        -- Testa Load Word (opcode = "100011")
        opcode <= "100011";
        WAIT FOR 10 ns;
        
        -- Testa Store Word (opcode = "101011")
        opcode <= "101011";
        WAIT FOR 10 ns;
        
        -- Testa Branch Equal (opcode = "000100")
        opcode <= "000100";
        WAIT FOR 10 ns;
        
        -- Testa Jump (opcode = "000010")
        opcode <= "000010";
        WAIT FOR 10 ns;
        
        -- Finaliza a simulação
        WAIT;
    END PROCESS;
END behavior;
