library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula_1 is
  Port (
    A : in std_logic;
    B : in std_logic;
    Ainvert : in std_logic;
    Binvert : in std_logic;
    VemUm : in std_logic; -- Mesmo que CarryIn
    Operacao: in std_logic_vector (1 downto 0);
    Less : in std_logic;

    Resultado : out std_logic;
    VaiUm: out std_logic;
	 Set: out std_logic
  );
end ula_1;

architecture Behavioral of ula_1 is
  signal Ainvertido : std_logic;
  signal Binvertido : std_logic;
  signal AndResult : std_logic;
  signal OrResult: std_logic;
  signal SomaResult: std_logic;
  signal A_barr: std_logic;
  signal B_barr: std_logic;
begin
	a_barr <= not A;
	b_barr <= not B;
  mux_2_instancia_A: entity work.mux_2
		port map(
			E0 => A,
			E1 => a_barr,
			Sel => Ainvert,
			Saida => Ainvertido
		);
		
	mux_2_instancia_B: entity work.mux_2
		port map(
			E0 => B,
			E1 => b_barr,
			Sel => Binvert,
			Saida => Binvertido
		);

  -- Operações Lógicas
  AndResult <= Ainvertido and Binvertido;
  OrResult <= Ainvertido or Binvertido;

  -- Operação de soma utilizando o módulo de Somador Completo
  somador_completo_instancia_vhdl: entity  work.somador_completo
    port map (
      A => Ainvertido,
      B => Binvertido,
      VemUm => VemUm,
      Soma => SomaResult,
      VaiUm => VaiUm
    );

  -- Seleção do resultado usando o mux_4
  Mux_4Instancia : entity work.mux_4
    port map (
      E(0) => AndResult,
      E(1) => OrResult,
      E(2) => SomaResult,
      E(3) => Less,
      Sel => Operacao,
      Saida => Resultado
    );

	
	Set <= SomaResult;

end Behavioral;