-- Comparador

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparador is

	generic
	(
		DATA_WIDTH : natural := 16
	);

	port 
	(
		a	: in std_logic_vector	((DATA_WIDTH-1) downto 0);
		b	: in std_logic_vector	((DATA_WIDTH-1) downto 0);
		maior	: out std_logic;
		menor	: out std_logic;
		igual	: out std_logic
	);

end entity;

architecture rtl of comparador is
begin
	
	maior <= '1' when unsigned(a) > unsigned(b) else '0';
	menor <= '1' when unsigned(a) < unsigned(b) else '0';
	igual <= '1' when unsigned(a) = unsigned(b) else '0';

end rtl;	
