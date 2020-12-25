library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity pc is
  port (
    din : in std_logic_vector(31 downto 0);
    reset : in std_logic;
    clk : in std_logic;
    q: out std_logic_vector(31 downto 0)
  ) ;
end pc;

architecture sequential of pc is

begin

    --------------------Process 1---------------------------------------------------------------------
    clock : process( clk,reset )
    begin
        if (reset = '1') then
            q <= (others => '0');
        
        elsif (clk'event and clk='1') then
            q <= din;
        end if ;
    end process ; -- write
    --------------------------------------------------------------------------------------------------

end sequential ; -- sequential