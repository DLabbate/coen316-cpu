-- 32 x 32 register file
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity d_cache is
port( din : in std_logic_vector(31 downto 0);
 reset : in std_logic;
 clk : in std_logic;
 write : in std_logic;
 address : in std_logic_vector(4 downto 0);
 d_out : out std_logic_vector(31 downto 0));
end d_cache ;

architecture sequential of d_cache is

    type t_reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal reg_array  : t_reg_array;

begin

    -- The design of this data cache follows similar logic to the regfile designed in a previous lab!
    -- precisely, we have a process for writing and a process for reading

    --------------------Process 1---------------------------------------------------------------------
    writing : process( clk,reset )
    begin
        if (reset = '1') then
            for i in 0 to 31 loop
                reg_array(i) <= "00000000000000000000000000000000";
            end loop ;
        
        elsif (clk'event and clk='1') then
            if (write='1') then -- only write under this condition
                reg_array(conv_integer(address)) <= din;
            end if ;
            
        end if ;

    end process ; -- write
    --------------------------------------------------------------------------------------------------



    --------------------Process 2---------------------------------------------------------------------
    reading : process( address,reg_array )
    begin
    
    d_out <= reg_array(conv_integer(address));

    end process ; -- read
    --------------------------------------------------------------------------------------------------


end sequential ; -- sequential