library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_32 is 
	Port (
		E : in std_logic_vector(31 downto 0);
		Saida : out std_logic
   );
end or_32;

architecture Behavioral of or_32 is 
	signal Camada1 : std_logic_vector(15 downto 0);
    signal Camada2 : std_logic_vector(7 downto 0);
    signal Camada3 : std_logic_vector(3 downto 0);
    signal Camada4 : std_logic_vector(1 downto 0);
begin
	gen_camada1: for i in 0 to 15 generate
    	begin 
        	Camada1(i) <= E(2*i) or E(2*i + 1);
	end generate;
    
    gen_camada2: for i in 0 to 7 generate
    	begin 
        	Camada2(i) <= Camada1(2*i) or Camada1(2*i + 1);
	end generate;
    
    gen_camada3: for i in 0 to 3 generate
    	begin 
        	Camada3(i) <= Camada2(2*i) or Camada2(2*i + 1);
	end generate;
    
   gen_camada4: for i in 0 to 1 generate
    	begin 
        	Camada4(i) <= Camada3(2*i) or Camada3(2*i + 1);
	end generate;
    
    -- Nao precisa de generate para a ultima camada, basta
    -- fazer uma or simples entre os dois ultimos indices
    Saida <= Camada4(0) or Camada4(1);
    
end Behavioral;
