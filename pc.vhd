library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
    Port (
        clk    : in STD_LOGIC;
        reset  : in STD_LOGIC;
        d_in   : in STD_LOGIC_VECTOR(31 downto 0);
        q_out  : out STD_LOGIC_VECTOR(31 downto 0)
    );
end PC;

architecture Behavioral of PC_Register is
    signal reg_value : STD_LOGIC_VECTOR(31 downto 0) := X"00003000"; 
    component flipflop_d_c is
        port(
            D: in std_logic;
		    Q : out std_logic;
		    Clear : in std_logic;
		    clk : in std_logic
        );
    end component;

    component FlipFlop_D_P is
        port(
            D: in std_logic;
            Q : out std_logic;
            Preset : in std_logic;
            clk : in std_logic
        );
    end component;
begin

    iteraFFDCA: for i in 31 downto 14 generate
        FFDCA: flipflop_d_c port map(
            D => d_in(i),
            Q => reg_value(i),
            clear => reset,
            clk => clk
        );

    end generate;

    iteraFFDP: for i in 13 downto 12 generate
        FFDP: flipflop_d_p port map(
            D => d_in(i),
            Q => reg_value(i),
            clk => clk,
            preset => reset
        );
    end generate;

    iteraFFDCB: for i in 11 downto 0 generate
        FFDCB: flipflop_d_c port map(
            D => d_in(i),
            Q => reg_value(i),
            clear => reset,
            clk => clk
        );
    end generate;
    
    

    q_out <= reg_value;
end Behavioral;
