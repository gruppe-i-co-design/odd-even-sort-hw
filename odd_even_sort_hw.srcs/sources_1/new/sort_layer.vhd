library IEEE;
library WORK;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
package constants is 

constant DATA_LEN: integer := 8;
type layer_signals_t is array (natural range <> ) of std_logic_vector((DATA_LEN -1) downto 0);

end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library WORK;
use work.constants.all;
entity sort_layer is

generic (   
    SIZE: integer := 8  
);
port (  
    data_in : in layer_signals_t(0 to (SIZE -1));
    data_out: out layer_signals_t(0 to (SIZE -1));
    sorted: out std_logic
);

end sort_layer;

architecture arch of sort_layer is

signal intermediate: layer_signals_t(0 to (SIZE-1));
signal swap_signals: std_logic_vector(0 to (SIZE-2));
begin
comparators: for i in 0 to (SIZE -1) generate
    first: if (i =0) generate
        data_out(i)<= intermediate(i);
   
    end generate;
  last: if (i = (SIZE-1)) generate
        data_out (i)<= intermediate(i);
   
    end generate;
    
    even: if (i mod 2 = 0) generate 
        comp: entity work.comparator 
            generic map (
                        DATA_LEN => DATA_LEN
                        )
            port map(
                        A => data_in (i),
                        B => data_in(i+1),
                        min => intermediate(i),
                        max => intermediate(i+1),
                        swapped => swap_signals(i)
                    );
        
       end generate;
    odd: if (i mod 2 /= 0 and i < (SIZE -1)) generate 
       comp: entity work.comparator
            generic map (
                        DATA_LEN => DATA_LEN
                        )
            port map(  
                        min => data_out(i),
                        max => data_out (i+1),
                        A => intermediate(i),
                        B => intermediate(i+1),
                        swapped => swap_signals(i)
                    );       
       end generate;
end generate;

sorted <= '1' when unsigned(swap_signals)= 0 else '0';

end arch;
