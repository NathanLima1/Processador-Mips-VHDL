library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2_x_32 is
	Port (
    	  A: in STD_LOGIC_VECTOR (31 downto 0);
        B: in STD_LOGIC_VECTOR (31 downto 0);
        Sel: in STD_LOGIC;
        Saida: out STD_LOGIC_VECTOR (31 downto 0)
  );
end mux_2_x_32;

architecture Structural of mux_2_x_32 is
begin
	gen_mux: for i in 0 to 31 generate
    	mux2_instance: entity work.mux_2 port map (
        	  E0 => A(i),
            E1 => B(i),
            Sel => Sel,
            Saida => Saida(i)        
      );
  end generate gen_mux;
end Structural;