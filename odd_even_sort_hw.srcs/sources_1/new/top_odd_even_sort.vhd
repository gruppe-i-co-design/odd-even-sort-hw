library IEEE;
library WORK;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


use work.constants.all;

entity top_odd_even_sort is
  generic (
    SIZE: integer := 8;
    SORT_NETWORK_SIZE: integer := 3
  );
  Port (
    clk,clear, enable,rst: in std_logic;
    data_in: in layer_signals_t(0 to (SIZE - 1));
    data_out: out layer_signals_t(0 to (SIZE - 1));
    sort_done: out std_logic
  );
  
end top_odd_even_sort;
architecture arch of top_odd_even_sort is

    type sort_network_signals_t is array (0 to (SORT_NETWORK_SIZE - 2)) of layer_signals_t (0 to SIZE - 1);
    --
    signal sort_network_intermediate: sort_network_signals_t;
    signal  sort_network_output, iterative_sort_network : layer_signals_t (0 to SIZE - 1);
    signal mux_out, reg_in, reg_out: layer_signals_t (0 to SIZE - 1);
    signal sorted, reg_mux, load:std_logic;
begin
control: entity work.control
port map(
        clk => clk, rst => rst, enable=> enable, clear => clear, sorted => sorted,
        reg_mux => reg_mux, load => load, sort_done => sort_done
         );
sort_network: for i in 0 to (SORT_NETWORK_SIZE - 1) generate

    first_layer: if (i = 0) generate
      layer: entity work.sort_layer
        generic map(
            SIZE => SIZE
        )
        port map(   
           data_in => data_in,
           data_out =>  sort_network_intermediate(i)
           
        );
    end generate;

      sort_layer: if (i > 0 and i < (SORT_NETWORK_SIZE -2)) generate
      layer: entity work.sort_layer
        generic map(
            SIZE => SIZE
        )
        port map(   
            data_in=> sort_network_intermediate(i-1),
            data_out =>  sort_network_intermediate(i)
          
        );
     
    end generate;
  last_layer: if (i = (SORT_NETWORK_SIZE -2)) generate
      layer: entity work.sort_layer
        generic map(
            SIZE => SIZE
        )
        port map(   
           data_in => sort_network_intermediate(i-1),
           data_out =>  sort_network_output
           
        );
    end generate;
end generate;
-- iterative sort network


      iterative_sort_layer: entity work.sort_layer
        generic map(
            SIZE => SIZE
        )
        port map(   
           data_in => reg_out,
           data_out =>iterative_sort_network,
           sorted => sorted
           
        );
    
    mux_out <=iterative_sort_network when reg_mux ='1' else  sort_network_output;
    reg_in <= mux_out;

 data_out <=  iterative_sort_network  ;
 process (clk, load)
 begin 
  if(rising_edge (clk) and load ='1') then
    reg_out <= reg_in;
  end if;
end process;
 

end arch;
