LIBRARY IEEE;
use ieee.std_logic_1164.all;

entity RegW is

	generic (
		W	: natural := 4
	);
	
	port(
		CLK	: in std_logic;
	   D		: in std_logic_vector((W-1) downto 0);
		Q		: out std_logic_vector((W-1) downto 0);
		LOAD : in std_logic
	);
	
end RegW;

architecture RTL of RegW is
begin
	process(CLK, load)
	begin
		if (rising_edge(CLK) and LOAD='1') then
			Q <= D;
		end if;
	end process;
end RTL;