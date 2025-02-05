library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_flipflop_d_enable_32 is
    -- Testbench não tem portas
end tb_flipflop_d_enable_32;

architecture behavior of tb_flipflop_d_enable_32 is
    -- Component declaration for the unit under test (UUT)
    component flipflop_d_enable_32
        port(
            D: in std_logic_vector(31 downto 0);
            Q: out std_logic_vector(31 downto 0);
            Enable: in std_logic;
            clk: in std_logic
        );
    end component;

    -- Testbench signals
    signal D_tb: std_logic_vector(31 downto 0) := (others => '0');
    signal Q_tb: std_logic_vector(31 downto 0);
    signal Enable_tb: std_logic := '0';
    signal clk_tb: std_logic := '0';

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: flipflop_d_enable_32
        port map(
            D => D_tb,
            Q => Q_tb,
            Enable => Enable_tb,
            clk => clk_tb
        );

    -- Clock generation process
    clk_process: process
    begin
        clk_tb <= '0';
        wait for 10 ns;
        clk_tb <= '1';
        wait for 10 ns;
    end process clk_process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1: Check if the flip-flop stores values when Enable is '1'
        Enable_tb <= '1';
        D_tb <= "00000000000000000000000000000001";  -- D = 1
        wait for 20 ns;
        assert (Q_tb = "00000000000000000000000000000001") report "Test case 1 failed" severity error;

        -- Test case 2: Check if the flip-flop doesn't store values when Enable is '0'
        Enable_tb <= '0';
        D_tb <= "00000000000000000000000000000010";  -- D = 2
        wait for 20 ns;
        assert (Q_tb = "00000000000000000000000000000001") report "Test case 2 failed" severity error;  -- Q should stay as 1

        -- Test case 3: Change D while Enable is '1'
        Enable_tb <= '1';
        D_tb <= "00000000000000000000000000000011";  -- D = 3
        wait for 20 ns;
        assert (Q_tb = "00000000000000000000000000000011") report "Test case 3 failed" severity error;

        -- Test case 4: Test reset of Q when Enable is '0' and D is changed
        Enable_tb <= '0';
        D_tb <= "00000000000000000000000000000100";  -- D = 4
        wait for 20 ns;
        assert (Q_tb = "00000000000000000000000000000011") report "Test case 4 failed" severity error;  -- Q should stay as 3

        -- Test case 5: Changing Enable back to '1' and checking the result
        Enable_tb <= '1';
        D_tb <= "00000000000000000000000000000101";  -- D = 5
        wait for 20 ns;
        assert (Q_tb = "00000000000000000000000000000101") report "Test case 5 failed" severity error;

        -- End the simulation
        wait;
    end process stim_proc;
end behavior;
