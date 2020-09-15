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
    clk, rst, clear, enable: in std_logic;
    data_in: in layer_signals_t(0 to (SIZE - 1));
    data_out: out layer_signals_t(0 to (SIZE - 1));
    sort_done: out std_logic
  );
end top_odd_even_sort;

architecture arch of top_odd_even_sort is

    type sort_network_signals_t is array (0 to (SORT_NETWORK_SIZE - 2)) of layer_signals_t (0 to SIZE - 1);
    --
    signal sort_network_intermediate: sort_network_signals_t;
    

begin



--process(clk,rst)
--begin
--    if(rst = '1') then
        
--    else if (rising_edge(clk)) then
       
--    end if;
--end process;    

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
    
  
end generate;

end arch;
