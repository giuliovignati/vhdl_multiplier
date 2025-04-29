library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity Testbench is
end Testbench;

architecture A of Testbench is
  
  component Multiplier_seriale
    port (
      clk     : in std_logic;
      resetn   : in std_logic;
      IN_A    : in  std_logic_vector(15 downto 0);
      IN_B    : in  std_logic_vector(15 downto 0);
      OUT_MUL : out std_logic_vector(31 downto 0);
      start : in std_logic;
      elab: out std_logic;
      done: out std_logic
      );
  end component;
  
  signal resetn  : std_logic;
  signal clk     : std_logic;
  signal IN_A    : std_logic_vector(15 downto 0);
  signal IN_B    : std_logic_vector(15 downto 0);
  signal OUT_MUL: std_logic_vector(31 downto 0);
  signal start, elab, done: std_logic;
  
  
begin
  
  UUT:  Multiplier_seriale 

  port map (clk, resetn, IN_A, IN_B, OUT_MUL, start, elab,done);

  clk_engine: process
    begin
    clk <= '0';
    wait for 10 ns;
      clk <= '1';
    wait for 10 ns;
  end process;  

  reset_engine: process
    begin
      wait for 5 ns;  
      resetn <= '0';
      wait for 20 ns;  
      resetn <= '1';
      wait;
    end process;
  
  
  test: process
  begin
    start <= '0';
    IN_A  <= conv_std_logic_vector(0,16);
    IN_B  <= conv_std_logic_vector(0,16);
    wait for 45 ns;
    start <= '1';
    IN_A <= conv_std_logic_vector(12,16);
    IN_B <= conv_std_logic_vector(12,16);  
    wait for 20 ns;
    start <='0';
    IN_A <= conv_std_logic_vector(27,16);
    IN_B <= conv_std_logic_vector(32,16); 
    wait for 340 ns;
    start <= '1';
    IN_A <= conv_std_logic_vector(37,16);
    IN_B <= conv_std_logic_vector(54,16); 
    wait for 20 ns;
    start <='0';
    wait for 340 ns;
    start <= '1';
    IN_A <= X"FFFF";  
    IN_B <= X"FFFF"; 
    wait for 20 ns;
    start <='0';
    wait;
  end process;
  
end A;
