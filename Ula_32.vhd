library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Ula_32 is 
  Port (
      -- Entradas
      A : in std_logic_vector(31 downto 0);
      B : in std_logic_vector(31 downto 0);
      Anegate : in std_logic;
      Bnegate : in std_logic;
      Operacao : in std_logic_vector(1 downto 0);
      
      -- Saidas
      Resultado : out std_logic_vector(31 downto 0);
      Zero : out std_logic
  );
end Ula_32;

architecture Behavioral of Ula_32 is
	signal VaiUm : std_logic_vector(31 downto 0);
   	signal OrResult : std_logic;
	signal VaiSet : std_logic;
	signal ResultadoLocal : std_logic_vector (31 downto 0);
begin
	-- Instanciação da primeira ULA de 1 bit. 
   	Ula0_1 : entity work.ula_1
	    port map (
            	A => A(0),
            	B => B(0),
            	Ainvert => Anegate,
            	Binvert => Bnegate,
            	VemUm => Bnegate, -- Adiciona 1 caso a operacao seja de subtracao
            	Operacao => Operacao,
            	Resultado => ResultadoLocal(0),
            	VaiUm => VaiUm(0),
	    	Less => VaiSet
            );

	-- Generate das ULAs dos bits de 1 - 30
	gen_ula : for i in 1 to 30 generate
    	    begin
            	Ula0_resto : entity work.ula_1
                   port map (
                      A => A(i),
                      B => B(i),
                      Ainvert => Anegate,
                      Binvert => Bnegate,
                      VemUm => VaiUm(i-1),
                      Operacao => Operacao,
                      Resultado => ResultadoLocal(i),
                      VaiUm => VaiUm(i),
		      Less => '0'
                   );
	    end generate;

	-- Instanciação da última ULA de 1 bit
	Ula31_1 : entity work.ula_1
	   port map (
	      A => A(31),
	      B => B(31),
	      Ainvert => Anegate,
	      Binvert => Bnegate,
	      VemUm => VaiUm(30),
	      Operacao => Operacao,
              Resultado => ResultadoLocal(31),
	      VaiUm => VaiUm(31),
	      Less => '0',
	      Set => VaiSet
	   );
	
	Or_32Instancia : entity work.or_32
	   port map (
	      E => ResultadoLocal,
	      Saida => OrResult
	   );
			
	Resultado <= ResultadoLocal;
	Zero <= not OrResult;
end Behavioral;
