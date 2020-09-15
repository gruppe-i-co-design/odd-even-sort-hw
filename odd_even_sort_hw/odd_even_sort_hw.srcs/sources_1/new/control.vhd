library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control is
    Port (
        clk, rst, enable, clear, sorted: in std_logic;
        reg_mux, load, sorte_done: out std_logic
        
    );
end control;

architecture Behavioral of control is

    type t_state is (idle, iterate);
    signal current_state, next_state: t_state;

begin

-- state register
process (clk, rst)
begin
	if (rst = '1') then
		current_state <= idle;
	elsif rising_edge(clk) then
		current_state <= next_state;
	end if;
end process;

-- next-state logic
process (current_state, enable)
begin
	next_state <= current_state; 
	reg_mux <= '0';
	load <= '0';
	sorte_done <= '0';

	case current_state is
		when idle =>
			if enable = '1' then 
			     reg_mux <= '0';
			     load <= '1';
			     next_state <= iterate;
			end if;
        when iterate =>
            if clear = '1' then 
                next_state <= idle;
            else
                if (sorted = '1') then
                    sorte_done <= '1';
                else 
                    reg_mux <= '1';
                    load <= '1';
                end if;
			end if;
	end case;
end process;

end Behavioral;
