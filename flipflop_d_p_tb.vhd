----------------------------------------------------------------------------------
-- Company: UFSJ
-- Engineer: Nathan Lima
-- 
-- Create Date:    15:17:50 02/05/2025 
-- Design Name: 
-- Module Name:    tb_FlipFlop_D_P
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Testbench para FlipFlop D com Preset assíncrono
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

entity tb_FlipFlop_D_P is
end tb_FlipFlop_D_P;

architecture behavior of tb_FlipFlop_D_P is
    -- Component declaration for the FlipFlop_D_P
    component FlipFlop_D_P is
        port(
            D : in std_logic;
            Q : out std_logic;
            Preset : in std_logic;
            clk : in std_logic
        );
    end component;

    -- Signal declarations
    signal D      : std_logic := '0';
    signal Q      : std_logic;
    signal Preset : std_logic := '0';
    signal clk    : std_logic := '0';

begin
    -- Instantiate the FlipFlop_D_P
    uut: FlipFlop_D_P port map (
        D => D,
        Q => Q,
        Preset => Preset,
        clk => clk
    );

    -- Clock generation process
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        -- Test 1: Verify preset behavior (Preset = 1, Q should be 1 regardless of clk)
        Preset <= '1';
        wait for 20 ns;
        assert (Q = '1') report "Test 1 Failed: Q should be 1 when Preset is 1" severity error;
        
        -- Test 2: Remove preset and check behavior with D and clk (Preset = 0)
        Preset <= '0';
        D <= '0'; wait for 20 ns; -- D = 0, clk rising edge should set Q to 0
        assert (Q = '0') report "Test 2 Failed: Q should be 0 when D is 0 on clk edge" severity error;
        
        D <= '1'; wait for 20 ns; -- D = 1, clk rising edge should set Q to 1
        assert (Q = '1') report "Test 3 Failed: Q should be 1 when D is 1 on clk edge" severity error;

        -- Test 3: Check preset behavior after clk cycles (Preset = 1, Q should be 1 again)
        Preset <= '1';
        wait for 20 ns;
        assert (Q = '1') report "Test 4 Failed: Q should be 1 when Preset is 1, even after clk edge" severity error;

        -- Test 4: Verify when D changes at next rising edge (Preset = 0)
        Preset <= '0';
        D <= '0'; wait for 20 ns; -- D = 0, clk rising edge should set Q to 0
        assert (Q = '0') report "Test 5 Failed: Q should be 0 when D is 0 on clk edge" severity error;
        
        -- End of simulation
        wait;
    end process;

end behavior;
