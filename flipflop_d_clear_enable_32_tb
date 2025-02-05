library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity flipflop_d_clear_enable_32_tb is
end flipflop_d_clear_enable_32_tb;

architecture testbench of flipflop_d_clear_enable_32_tb is
    signal D     : std_logic_vector(31 downto 0);
    signal Q     : std_logic_vector(31 downto 0);
    signal Enable: std_logic;
    signal Clear : std_logic;
    signal clk   : std_logic := '0';

    component flipflop_d_clear_enable_32
        port(
            D: in std_logic_vector(31 downto 0);
            Q: out std_logic_vector(31 downto 0);
            Enable: in std_logic;
            Clear: in std_logic;
            clk: in std_logic
        );
    end component;

begin
    uut: flipflop_d_clear_enable_32 port map(
        D => D,
        Q => Q,
        Enable => Enable,
        Clear => Clear,
        clk => clk
    );

    clk_process: process
    begin
        while now < 200 ns loop
            clk <= not clk;
            wait for 10 ns;
        end loop;
        wait;
    end process;

    stim_proc: process
    begin
        Clear <= '1';
        Enable <= '0';
        D <= (others => '0');
        wait for 20 ns;

        Clear <= '0';
        Enable <= '1';
        D <= X"FFFFFFFF";
        wait for 20 ns;

        D <= X"00000000";
        wait for 20 ns;

        D <= X"AAAA5555";
        wait for 20 ns;

        Enable <= '0';
        D <= X"FFFF0000"; -- Não deve alterar Q
        wait for 20 ns;

        Enable <= '1';
        D <= X"12345678";
        wait for 20 ns;

        Clear <= '1';
        wait for 20 ns;
        Clear <= '0';
        wait for 20 ns;

        wait;
    end process;
end testbench;
