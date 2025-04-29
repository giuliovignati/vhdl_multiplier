library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity Testbench is
end Testbench;

Architecture combinatorio of Testbench is

component Multiplier_comb
port (
		clk : in std_logic;
		resetn : in std_logic;
		IN_A : in std_logic_vector(15 downto 0);
		IN_B : in std_logic_vector(15 downto 0);
		OUT_MUL : out std_logic_vector(31 downto 0)
);
end component;

signal clk, resetn: std_logic;
signal IN_A, IN_B: std_logic_vector(15 downto 0);
signal OUT_MUL: std_logic_vector(31 downto 0);

begin

	UUT : Multiplier_comb port map (clk, resetn, IN_A, IN_B, OUT_MUL);
	
	xsclock_engine : process
    	begin
      		clk <= '0';
      		wait for 5 ns;
      		clk <= '1';
      		wait for 5 ns;
    	end process;

    	reset_engine : process
      	begin
        	wait for 3 ns;
        	resetn <= '0';
        	wait for 10 ns;
        	resetn <= '1';
        	wait;
    	end process;

	input_data : process
	begin
		IN_A <= conv_std_logic_vector(0, 16);
		IN_B <= conv_std_logic_vector(0, 16);
		wait for 30 ns;
		IN_A <= conv_std_logic_vector(75, 16);
		IN_B <= conv_std_logic_vector(112, 16);
		wait for 10 ns;
		IN_A <= conv_std_logic_vector(164, 16);
		IN_B <= conv_std_logic_vector(89, 16);
		wait for 10 ns;
		IN_A <= conv_std_logic_vector(225, 16);
		IN_B <= conv_std_logic_vector(311, 16);
		wait for 10 ns;
		IN_A <= conv_std_logic_vector(417, 16);
		IN_B <= conv_std_logic_vector(458, 16);
		wait;
	end process;

end combinatorio;
