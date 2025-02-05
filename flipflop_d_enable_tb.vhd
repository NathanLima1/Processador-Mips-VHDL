----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Leonardo Guimarães de Oliveira
-- 
-- Create Date:    15:17:50 01/22/2025 
-- Design Name: 
-- Module Name:    FlipFlopD_tb
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Testbench para o flip-flop D com habilitação
-- 
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - Arquivo Criado
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlopD_tb is
end FlipFlopD_tb;

architecture behavior of FlipFlopD_tb is
    -- Component declaration for the unit under test (UUT)
    component flipflop_d_enable
        port(
            D: in std_logic;
            Q : out std_logic;
            Enable : in std_logic;
            clk : in std_logic
        );
    end component;

    -- Signals to connect to the UUT
    signal D : std_logic := '0';
    signal Q : std_logic;
    signal Enable : std_logic := '0';
    signal clk : std_logic := '0';

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: flipflop_d_enable
        port map (
            D => D,
            Q => Q,
            Enable => Enable,
            clk => clk
        );

    -- Clock process (gerador de clock)
    clk_process :process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus process (aplicação de estímulos)
    stim_proc: process
    begin
        -- Teste 1: Com Enable = 0, Q não deve mudar
        Enable <= '0';
        D <= '1';
        wait for 20 ns;

        -- Teste 2: Com Enable = 1, D deve ser transferido para Q na borda de descida do clock
        Enable <= '1';
        D <= '0';
        wait for 20 ns;

        -- Teste 3: Com Enable = 1, Q deve continuar com o valor de D
        D <= '1';
        wait for 20 ns;

        -- Teste 4: Com Enable = 0, Q não deve mudar
        Enable <= '0';
        D <= '0';
        wait for 20 ns;

        -- Finalizando o processo
        wait;
    end process;

end behavior;
