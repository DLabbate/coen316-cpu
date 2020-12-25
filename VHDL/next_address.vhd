library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity next_address is
    port(rt, rs : in std_logic_vector(31 downto 0);
     -- two register inputs
     pc : in std_logic_vector(31 downto 0);
     target_address : in std_logic_vector(25 downto 0);
     branch_type : in std_logic_vector(1 downto 0);
     pc_sel : in std_logic_vector(1 downto 0);
     next_pc : out std_logic_vector(31 downto 0));
end next_address ;

architecture sequential of next_address is

    signal branch_checker_out : std_logic_vector(31 downto 0); -- All 1's if branch condition is true
    signal adder_out : std_logic_vector(31 downto 0);
    signal adder_in1 : std_logic_vector(31 downto 0);

    -- The jump target address is 26 bits
    -- (in the case of a branch instruction the low order 16 bits of these 26 bits form the 16 bit immediate data representing the signed branch)
    signal branch_offset : std_logic_vector(15 downto 0);
    signal branch_offset_sign_extended : std_logic_vector(31 downto 0);

    -- target_address(26 bits) sign extended to 32 bits
    signal target_address_32: std_logic_vector(31 downto 0);

begin

    branch_offset <= target_address(15 downto 0);

    -- Sign extend the branch offset
    branch_offset_sign_extended(31 downto 16) <= (others => branch_offset(15)); -- Assign the MSB
    branch_offset_sign_extended(15 downto 0) <= branch_offset;                  -- The low order bits remain the same

    -- Sign extend target_address
    target_address_32(31 downto 26) <= (others => target_address(25));          -- Assign the MSB
    target_address_32(25 downto 0) <= target_address;                           -- The low order bits remain the same

    -- ADDER
    adder_in1 <= branch_checker_out and branch_offset_sign_extended;
    adder_out <= adder_in1 + pc;


    --------------------Process 1---------------------------------------------------------------------
    branch_checker : process( rt,rs, branch_type )
    begin
        case( branch_type ) is
        
            when "00" => 
                branch_checker_out <= (others => '0');

            when "01" => 
                if rs = rt  then
                    branch_checker_out <= (others => '1');
                else
                    branch_checker_out <= (others => '0');
                end if ;

            when "10" => 
                if rs /= rt  then
                    branch_checker_out <= (others => '1');
                else
                    branch_checker_out <= (others => '0');
                end if ;

            when others =>
                -- We branch if less than zero (if it is a negative number)
                -- So check MSB to get sign
                if rs(31) = '1'  then
                    branch_checker_out <= (others => '1');
                else
                    branch_checker_out <= (others => '0');
                end if ;
        
        end case ;
        
    end process ; -- branch_checker
    --------------------------------------------------------------------------------------------------



    --------------------Process 2---------------------------------------------------------------------
    alu : process( adder_out,target_address_32,rs,pc_sel )
    begin
        case( pc_sel ) is
        
            when "00" => next_pc <= adder_out + 1;          -- In the case that branch condition is false, the adder_out will be all zeros
            when "01" => next_pc <= target_address_32;      -- Assign the target address (sign extended to 32 bits)
            when "10" => next_pc <= rs;                     -- Assign the contents of rs
            when others => next_pc <= (others => '0');      -- This input is not used, so we simply reset the PC
        
        end case ;
        
    end process ; -- alu
    --------------------------------------------------------------------------------------------------



end sequential ; -- sequential