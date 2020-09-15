library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparator is
generic (
          DATA_LEN: integer := 8
         );
    port ( 
           A,B : in std_logic_vector((DATA_LEN -1) downto 0);
           max, min: out std_logic_vector((DATA_LEN -1) downto 0);
           swapped: out std_logic
          );
end comparator;

architecture arch of comparator is

begin
max <= A when A > B else B;
min <= B when A > B else A;
-- if not swapped then the values are already sorted
swapped <= '1' when  A > B else '0';
end arch;
