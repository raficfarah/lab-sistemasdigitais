library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity tb_RegW is
end tb_RegW;

architecture teste of tb_RegW is

component RegW is 
	generic(
		W	: natural := 4
	);
	
	port(
		clock	: in std_logic;
	   D		: in std_logic_vector((W-1) downto 0);
		Q		: out std_logic_vector((W-1) downto 0);
		load	: in std_logic
	);
end component;

signal fio_D, fio_Q: std_logic_vector(3 downto 0);
signal fio_load: std_logic;
signal meu_clock: std_logic := '0';

begin

instancia_RegW: RegW 
	generic map (
		W => 4
	) 
	
	port map(
		clock=>meu_clock,
		D=>fio_D, 
		Q=>fio_Q, 
		load=>fio_load
	);

fio_D <= "0000", "0000" after 10 ns, "0001" after 20 ns, "0000" after 30 ns;
fio_load <= '0', '0' after 10 ns,  '1' after 20 ns,  '0' after 30 ns;
meu_clock <= not meu_clock after 1 ns;

end teste;
