library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity Multiplier_comb is
port (
		clk : in std_logic;
		resetn : in std_logic;
		IN_A : in std_logic_vector(15 downto 0); --- multiplier
		IN_B : in std_logic_vector(15 downto 0); --- multiplicand
		OUT_MUL : out std_logic_vector(31 downto 0)
);
end Multiplier_comb;

architecture combinatorio of Multiplier_comb is

signal in_1, in_2: std_logic_vector(15 downto 0);
signal out_d, out_q: std_logic_vector(31 downto 0);

begin

	process(clk, resetn)
	begin
		if resetn='0' then
			in_1 <= (others => '0');
			in_2 <= (others => '0');
			out_q <= (others => '0');
		elsif clk'event and clk='1' then
			in_1 <= IN_A;
			in_2 <= IN_B;
			out_q <= out_d;
		end if;
	end process;
	
	out_d <= unsigned(in_2) * unsigned(in_1);
	OUT_MUL <= out_q; 

end combinatorio;
