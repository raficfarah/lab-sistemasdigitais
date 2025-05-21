library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg_MA is
    generic (
        W       :       integer := 32
    );
	 
    port (
        CLK     : in    std_logic;
        RESET   : in    std_logic;
        INPUT   : in    std_logic_vector(W - 1 downto 0);
        OUTPUT  : out   std_logic_vector(W - 1 downto 0)
    );
	 
end Reg_MA;

architecture arch of Reg_MA is
	signal soma : unsigned(W + 1 downto 0);
	begin
		process(CLK, RESET) is
			variable var1 : unsigned(W + 1 downto 0);
			variable var2 : unsigned(W + 1 downto 0);
			variable var3 : unsigned(W + 1 downto 0);
			variable var4 : unsigned(W + 1 downto 0);
		--	variable soma : unsigned(W + 1 downto 0);
		begin
			if (RESET = '1') then
				var1 := to_unsigned(0,W + 2);
				var2 := to_unsigned(0,W + 2);
				var3 := to_unsigned(0,W + 2);
				var4 := to_unsigned(0,W + 2);
			elsif (rising_edge(CLK)) then
            var4 := var3;
				var3 := var2;
				var2 := var1;
				var1 := unsigned("00" & INPUT(W - 1 downto 0));
			end if;
       		
			soma <= var1 + var2 + var3 + var4;
			OUTPUT <= std_logic_vector(soma(W + 1 downto 2));
		  
		end process;
    
end arch;
