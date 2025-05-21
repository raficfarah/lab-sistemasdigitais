library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Datapath is

	port (
		E		: in std_logic_vector (3 downto 0);
		CLK : in std_logic;
		
		LoadE, ResetMA: in std_logic;
		S, D, A : in std_logic;
		
		Sobe, Desce, Maior, Menor : out std_logic;
		Media : out std_logic_vector (6 downto 0)
	);

end Datapath;

architecture RTL of Datapath is
	
	signal SigSD_in, SigSD_out	: std_logic_vector(1 downto 0);
	signal SigE 	: std_logic_vector(3 downto 0);
	signal SigM		: std_logic_vector(3 downto 0);
	
	--------
	component RegW is
		generic(
			W	: natural := 4
		);
		
		port(
			CLK	: in std_logic;
			D		: in std_logic_vector((W-1) downto 0);
			Q		: out std_logic_vector((W-1) downto 0);
			LOAD 	: in std_logic
		);
	end component;
	--------
	component Reg_MA is
		generic(
			W       :       integer := 32
		);
	 
		port(
			CLK     : in    std_logic;
			RESET   : in    std_logic;
			INPUT   : in    std_logic_vector(W - 1 downto 0);
			OUTPUT  : out   std_logic_vector(W - 1 downto 0)
		);
	end component;
	--------
	component comparador is
		generic(
			DATA_WIDTH : natural := 16
		);

		port(
			a		: in std_logic_vector	((DATA_WIDTH-1) downto 0);
			b		: in std_logic_vector	((DATA_WIDTH-1) downto 0);
			maior	: out std_logic;
			menor	: out std_logic;
			igual	: out std_logic
		);
	end component;
	--------
	component BCD_7seg is
		port(
			entrada: in std_logic_vector (3 downto 0);
			saida: out std_logic_vector (6 downto 0)
		);
	end component;
	--------
	
begin
	
	--------
	RegE : RegW
	generic map(
		W => 4
	)
	
	port map(
		CLK => CLK,
		D => E,
		Q => SigE,
		LOAD => LoadE
	);
	
	--------
	
	Reg_SD : RegW
	generic map(
		W => 2
	)
	
	port map(
		CLK => CLK,
		D => SigSD_in,
		Q => SigSD_out,
		LOAD => A
	);
	
	SigSD_in <= S & D;
	Sobe <= SigSD_out(1);
	Desce <= SigSD_out(0);
	
	--------
	
	myReg_MA : Reg_MA
	generic map(
		W => 4
	)
	
	port map(
		CLK => CLK,
		RESET => ResetMA,
		INPUT => SigE,
		OUTPUT => SigM
	);
	
	--------
	
	myComparador : comparador
	generic map(
		DATA_WIDTH => 4
	)

	port map(
		a	=> SigE,
		b	=> SigM,
		maior	=> Maior,
		menor	=> Menor
	);
	
	BCD : BCD_7seg
	port map(
		entrada => SigM,
		Saida => Media
	);
	
end RTL;