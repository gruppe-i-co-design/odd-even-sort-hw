library IEEE;
library WORK;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


use work.constants.all;

entity top_odd_even_sort is
  generic (
    SIZE: integer := 8;
    SORT_NETWORK_SIZE: integer := 5
  );
  Port (
    clk,clear, enable: in std_logic;
    data_in: in layer_signals_t(0 to (SIZE - 1));
    data_out: out layer_signals_t(0 to (SIZE - 1));
    sort_done: out std_logic
  );
end top_odd_even_sort;

architecture arch of top_odd_even_sort is

    type sort_network_signals_t is array (0 to (SORT_NETWORK_SIZE - 2)) of layer_signals_t (0 to SIZE - 1);
    --
    signal sort_network_intermediate: sort_network_signals_t;
    signal  sort_network_output : layer_signals_t (0 to SIZE - 1);
    signal mux_out, reg_in, reg_out: layer_signals_t (0 to SIZE - 1);
    signal sorted, reg_mux, load:std_logic;
begin

sort_network: for i in 0 to (SORT_NETWORK_SIZE - 1) generate

    first_layer: if (i = 0) generate
      layer: entity work.sort_layer
        generic map(
            SIZE => SIZE
        )
        port map(   
           data_in => data_in,
           data_out =>  sort_network_intermediate(i),
           sorted => sorted
        );
    end generate;

      sort_layer: if (i > 0 and i < (SORT_NETWORK_SIZE -2)) generate
      layer: entity work.sort_layer
        generic map(
            SIZE => SIZE
        )
        port map(   
            data_in=> sort_network_intermediate(i-1),
            data_out =>  sort_network_intermediate(i),
            sorted => sorted
        );
     
    end generate;
  last_layer: if (i = (SORT_NETWORK_SIZE -2)) generate
      layer: entity work.sort_layer
        generic map(
            SIZE => SIZE
        )
        port map(   
           data_in => sort_network_intermediate(i-1),
           data_out =>  sort_network_output,
           sorted => sorted
        );
    end generate;
end generate;
-- iterative sort network


      iterative_sort_layer: entity work.sort_layer
        generic map(
            SIZE => SIZE
        )
        port map(   
           data_in => mux_out,
           data_out =>  reg_in,
           sorted => sorted
           
        );
    
    mux_out <=reg_out when reg_mux ='1' else  sort_network_output;
 

 data_out <=    reg_out;
 process (clk)
 begin 
  if(rising_edge (clk) and load ='1') then
    reg_out <= reg_in;
  end if;
end process;
 

end arch;
