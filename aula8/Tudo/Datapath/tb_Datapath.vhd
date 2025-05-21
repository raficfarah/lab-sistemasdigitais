library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Datapath is
end tb_Datapath;

architecture behaviour of tb_Datapath is
	signal fio_E : std_logic_vector(3 downto 0) := "0000";
	signal fio_CLK, fio_LoadE, fio_ResetMA	: std_logic := '0';
	signal fio_S, fio_D, fio_A : std_logic := '0';
	signal fio_Sobe, fio_Desce, fio_Maior, fio_Menor :	std_logic := '0';
	signal fio_Media : std_logic_vector(6 downto 0);
	
	constant CLK_PERIOD : time := 10 ns;

	component Datapath is
		port (
			E		: in std_logic_vector(3 downto 0);
			CLK : in std_logic;
			
			LoadE, ResetMA: in std_logic;
			S, D, A : in std_logic;
			
			Sobe, Desce, Maior, Menor : out std_logic;
			Media : out std_logic_vector(6 downto 0)
		);
	
	end component;
	
begin
	uut : Datapath
	port map(
		E	=> fio_E,
		CLK => fio_CLK,
		
		LoadE => fio_LoadE,
		ResetMA => fio_ResetMA,
		
		S => fio_S,
		D => fio_D,
		A => fio_A,
		
		Sobe => fio_Sobe,
		Desce => fio_Desce,
		Maior => fio_Maior,
		Menor => fio_Menor,
		
		Media => fio_Media
	);
	
	fio_CLK <= not(fio_CLK) after CLK_PERIOD/2;
	fio_E <= "1000" after CLK_PERIOD*2;
	fio_LoadE <= '0', '1' after 20 ns, '0' after 30 ns;
	
	fio_S <= '0', '1' after CLK_PERIOD*2;
	fio_D <= '0', '1' after CLK_PERIOD*2;
	fio_A <= '0', '1' after 20 ns, '0' after 30 ns;
	
	
end behaviour;
