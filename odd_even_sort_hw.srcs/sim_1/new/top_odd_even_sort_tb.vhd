library IEEE;
library work;
use work.constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_odd_even_sort_tb is

end top_odd_even_sort_tb;

architecture arch of top_odd_even_sort_tb is

signal clk, rst, clear, enable, sort_done: std_logic;
constant clk_period: time := 10ns;
signal data_in: layer_signals_t(0 to 9);

begin

uut: entity work.top_odd_even_sort
        generic map(
                    SIZE => 10,
                    SORT_NETWORK_SIZE => 3
                    )
       port map(
                data_in => data_in,
                clk => clk, 
                rst => rst,
                enable => enable,
                clear => clear,
                sort_done => sort_done
                
                );
                
   
process
begin
    rst <= '1';
    wait for clk_period/2;
    rst <= '0';
    
    wait for clk_period/2;
    enable <= '1';
    
    data_in(0) <= x"AB";
    data_in(1) <= x"66";
    data_in(2) <= x"FF";
    data_in(3) <= x"AF";
    data_in(4) <= x"AB";
    data_in(5) <= x"66";
    data_in(6) <= x"F5";
    data_in(7) <= x"6F";
    data_in(8) <= x"AD";
    data_in(9) <= x"68";

    wait for clk_period*5;
    
end process;
              
                
process
begin
    clk <= '0';
    wait for clk_period / 2;   
    clk <= '1';
    wait for clk_period / 2;
end process;

end arch;
