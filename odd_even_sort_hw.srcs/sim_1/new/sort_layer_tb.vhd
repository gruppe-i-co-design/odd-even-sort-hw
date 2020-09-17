library IEEE;
library work;
use work.constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sort_layer_tb is

end sort_layer_tb;

architecture arch of sort_layer_tb is

signal clk: std_logic;
constant clk_period: time := 10ns;
signal data_in: layer_signals_t(0 to 3);

begin

uut: entity work.sort_layer
        generic map(
                    SIZE => 4
                    )
       port map(
                data_in => data_in
            
                );
                
   
process
begin
    
    data_in(0) <= x"AB";
    data_in(1) <= x"66";
    data_in(2) <= x"FF";
    data_in(3) <= x"AF";
    wait for clk_period;
    
    data_in(0) <= x"66";
    data_in(1) <= x"AB";
    data_in(2) <= x"AF";
    data_in(3) <= x"FF";
    wait for clk_period;
end process;
              
                
process
begin
    clk <= '0';
    wait for clk_period / 2;
    
    
    
    clk <= '1';
    wait for clk_period / 2;
end process;

end arch;
