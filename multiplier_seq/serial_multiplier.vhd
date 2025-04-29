-- Moltiplicatore Seriale

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Multiplier_serial is
port (
clk : in std_logic;
resetn : in std_logic;
IN_A : in std_logic_vector(15 downto 0);         --MULTIPLIER
IN_B : in std_logic_vector(15 downto 0);         --MULTIPLICAND
OUT_MUL : out std_logic_vector(31 downto 0);
start : in std_logic;                            
elab : out std_logic;                            
done : out std_logic                            
);
end Multiplier_serial;

architecture A of Multiplier_serial is 

signal OUT_MUL_REG, OUT_MUL_IN : std_logic_vector(32 downto 0);
signal REG_MOLTIPLICANDO,REG_MULTIPLIER   : std_logic_vector(15 downto 0);
signal OUT_MUL_UP, PP_esteso, SUM: std_logic_vector(16 downto 0);
signal ProdottoParziale : std_logic_vector(15 downto 0);

signal cont, next_cont: unsigned(3 downto 0);  
signal fine_conteggio, reset_cont, en_cont: std_logic;
type stato is (IDLE, COUNT, STOP);
signal cs, ns: stato;

signal en_load, en_cycle, clear_result : std_logic;


begin

--MUL
OUT_MUL <= OUT_MUL_REG(31 downto 0);

ProdottoParziale <= REG_MOLTIPLICANDO when REG_MULTIPLIER(0) = '1' else (others => '0');
OUT_MUL_UP <= OUT_MUL_REG(32 downto 16);  
PP_esteso <= '0'&ProdottoParziale;     
SUM <= unsigned(OUT_MUL_UP) + unsigned(PP_esteso); 
OUT_MUL_IN <= '0'&SUM&OUT_MUL_REG(15 downto 1);

--Controllo FSM
en_cycle <= en_cont;
en_load <= start;
clear_result <= start;


--COUNTER
reg_COUNTtore: process(CLK)  
begin   
    if CLK'event and CLK='1' then     
        if reset_cont = '0' then        
            cont<= (others => '0');        
        elsif en_cont = '1'    then      
            cont <= next_cont;     
        end if;    
     end if;  
  end process;    
 
next_cont <= cont + conv_unsigned(1,4);
reset_cont <= not(fine_conteggio) and resetn;
fine_conteggio <= '1' when cont = conv_unsigned(15,4) else '0';


--SEQ FSM STATUS REG (resetn ASINCRONO)
process(clk, resetn)
	begin
		if resetn = '0' then 
			cs <= IDLE;
		elsif clk'event and clk='1' then
			cs <= ns;
		end if;
    end process;

  
-- SEQ CAMP MULTIPLIER
process(clk, resetn)
  begin
    if (resetn = '0' ) then
       REG_MULTIPLIER <= (others => '0'); 
    elsif (clk'event and clk = '1') then
       if en_load = '1' then
           REG_MULTIPLIER <= IN_A;
       elsif en_cycle = '1' then
           REG_MULTIPLIER <= '0'&REG_MULTIPLIER(15 downto 1);
       end if;
     end if;
  end process;


-- SEQ CAMP MULTIPLICAND 
process(clk, resetn)
  begin
    if (resetn = '0') then
         REG_MOLTIPLICANDO <= (others => '0'); 
    elsif (clk'event and clk = '1') then
       if en_load = '1' then
           REG_MOLTIPLICANDO <= IN_B;
     end if;
   end if;
   end process;


-- SEQ OUT
process(clk, resetn)
   begin
     if (resetn = '0') then
       OUT_MUL_REG <= (others => '0');   
    elsif (clk'event and clk = '1') then
       if clear_result = '1' then
           OUT_MUL_REG <= (others => '0');
       elsif en_cycle = '1' then
           OUT_MUL_REG <= OUT_MUL_IN;
       end if;
     end if;
  end process;


--


--FSM COMB
fsm: process(cs, start, fine_conteggio) 
   begin   
   
   en_cont <= '0';
   elab <= '0';
   done <= '0';
   
  case cs is

       when IDLE => 
        if start= '1' then
           ns <= COUNT;
        else 
           ns <= cs;
        end if;  
  
      when COUNT =>
        en_cont <= '1';
        elab <= '1';
        if fine_conteggio = '1' then
           ns <= STOP;
        else 
           ns <= cs;
        end if;

      when STOP =>
         done <= '1';
         ns <= IDLE;

       when others =>
          ns <= IDLE;

       end case;
end process;

end A;