-- 32 x 32 register file
-- two read ports, one write port with write enable
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity regfile is
port( din : in std_logic_vector(31 downto 0);
 reset : in std_logic;
 clk : in std_logic;
 write : in std_logic;
 read_a : in std_logic_vector(4 downto 0);
 read_b : in std_logic_vector(4 downto 0);
 write_address : in std_logic_vector(4 downto 0);
 out_a : out std_logic_vector(31 downto 0);
 out_b : out std_logic_vector(31 downto 0));
end regfile ;

architecture sequential of regfile is

    type t_reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal reg_array  : t_reg_array;

begin

    --------------------Process 1---------------------------------------------------------------------
    writing : process( clk,reset )
    begin
        if (reset = '1') then
            for i in 0 to 31 loop
                reg_array(i) <= "00000000000000000000000000000000";
            end loop ;
        
        elsif (clk'event and clk='1') then
            if (write='1') then
                reg_array(conv_integer(write_address)) <= din;
            end if ;
            
        end if ;

    end process ; -- write
    --------------------------------------------------------------------------------------------------



    --------------------Process 2---------------------------------------------------------------------
    reading : process( read_a,read_b,reg_array )
    begin
    
    out_a <= reg_array(conv_integer(read_a));
    out_b <= reg_array(conv_integer(read_b));

    end process ; -- read
    --------------------------------------------------------------------------------------------------


end sequential ; -- sequential