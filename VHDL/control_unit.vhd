library ieee;
use IEEE.std_logic_1164.all;

entity control_unit is
  port (
    op: in std_logic_vector(5 downto 0);
    fn: in std_logic_vector(5 downto 0);
    reg_write : out std_logic;
    reg_dst : out std_logic;
    reg_in_src : out std_logic;
    alu_src : out std_logic;
    add_sub : out std_logic;
    logic_func : out std_logic_vector(1 downto 0);
    func : out std_logic_vector(1 downto 0); -- specifying the type of sign extension to be performed
    data_write : out std_logic;
    branch_type : out std_logic_vector(1 downto 0);
    pc_sel : out std_logic_vector(1 downto 0)
    );
end control_unit;

architecture sequential of control_unit  is

begin

    -- The following process is a case statement to generate the control signals 
    -- based on the opcode and fn
    --------------------Process 1---------------------------------------------------------------------
    cases : process( op,fn )
    begin
        case( op ) is
        
            -- lui
            when "001111" =>
                            reg_write   <=  '1';
                            reg_dst     <=  '0';
                            reg_in_src  <=  '1';
                            alu_src     <=  '1';
                            add_sub     <=  '0';    -- don't care
                            data_write  <=  '0';
                            logic_func  <=  "00";   -- don't care
                            func        <=  "00";
                            branch_type <=  "00";
                            pc_sel      <=  "00";
            
            when "000000" => 
                            case( fn ) is
                            
                                -- add
                                when "100000" =>
                                                reg_write   <=  '1';
                                                reg_dst     <=  '1';
                                                reg_in_src  <=  '1';
                                                alu_src     <=  '0';
                                                add_sub     <=  '0';    -- add
                                                data_write  <=  '0';
                                                logic_func  <=  "00";
                                                func        <=  "10";
                                                branch_type <=  "00";
                                                pc_sel      <=  "00";
                                
                                -- sub
                                when "100010" =>
                                                reg_write   <=  '1';
                                                reg_dst     <=  '1';
                                                reg_in_src  <=  '1';
                                                alu_src     <=  '0';
                                                add_sub     <=  '1';    -- sub
                                                data_write  <=  '0';
                                                logic_func  <=  "00";
                                                func        <=  "10";
                                                branch_type <=  "00";
                                                pc_sel      <=  "00";
                                
                                -- slt
                                when "101010" =>
                                                reg_write   <=  '1';
                                                reg_dst     <=  '1';
                                                reg_in_src  <=  '1';
                                                alu_src     <=  '0';
                                                add_sub     <=  '1';
                                                data_write  <=  '0';
                                                logic_func  <=  "00";
                                                func        <=  "01";
                                                branch_type <=  "00";
                                                pc_sel      <=  "00";
                                
                                -- and
                                when "100100" =>
                                                reg_write   <=  '1';
                                                reg_dst     <=  '1';
                                                reg_in_src  <=  '1';
                                                alu_src     <=  '0';
                                                add_sub     <=  '1';
                                                data_write  <=  '0';
                                                logic_func  <=  "00";
                                                func        <=  "11";
                                                branch_type <=  "00";
                                                pc_sel      <=  "00";

                                -- or
                                when "100101" =>
                                                reg_write   <=  '1';
                                                reg_dst     <=  '1';
                                                reg_in_src  <=  '1';
                                                alu_src     <=  '0';
                                                add_sub     <=  '1';
                                                data_write  <=  '0';
                                                logic_func  <=  "01";
                                                func        <=  "11";
                                                branch_type <=  "00";
                                                pc_sel      <=  "00"; 

                                -- xor
                                when "100110" =>
                                                reg_write   <=  '1';
                                                reg_dst     <=  '1';
                                                reg_in_src  <=  '1';
                                                alu_src     <=  '0';
                                                add_sub     <=  '1';
                                                data_write  <=  '0';
                                                logic_func  <=  "10";
                                                func        <=  "11";
                                                branch_type <=  "00";
                                                pc_sel      <=  "00";
                                
                                -- nor
                                when "100111" =>
                                                reg_write   <=  '1';
                                                reg_dst     <=  '1';
                                                reg_in_src  <=  '1';
                                                alu_src     <=  '0';
                                                add_sub     <=  '1';
                                                data_write  <=  '0';
                                                logic_func  <=  "11";
                                                func        <=  "11";
                                                branch_type <=  "00";
                                                pc_sel      <=  "00";

                                -- jr
                                when "001000" =>
                                                reg_write   <=  '0';
                                                reg_dst     <=  '0';
                                                reg_in_src  <=  '0';
                                                alu_src     <=  '0';
                                                add_sub     <=  '0';
                                                data_write  <=  '0';
                                                logic_func  <=  "00";
                                                func        <=  "00";
                                                branch_type <=  "00";
                                                pc_sel      <=  "10"; -- jump register 
                            
                                when others =>
                                                reg_write   <=  '0';
                                                reg_dst     <=  '0';
                                                reg_in_src  <=  '0';
                                                alu_src     <=  '0';
                                                add_sub     <=  '0';
                                                data_write  <=  '0';
                                                logic_func  <=  "00";
                                                func        <=  "00";
                                                branch_type <=  "00";
                                                pc_sel      <=  "00";
        
                            end case ;

            -- addi
            when "001000" =>
                            reg_write   <=  '1';
                            reg_dst     <=  '0';
                            reg_in_src  <=  '1';
                            alu_src     <=  '1';
                            add_sub     <=  '0';
                            data_write  <=  '0';
                            logic_func  <=  "00";
                            func        <=  "10";
                            branch_type <=  "00";
                            pc_sel      <=  "00";

            -- slti
            when "001010" =>
                            reg_write   <=  '1';
                            reg_dst     <=  '0';
                            reg_in_src  <=  '1';
                            alu_src     <=  '1';
                            add_sub     <=  '1';
                            data_write  <=  '0';
                            logic_func  <=  "00";
                            func        <=  "01";
                            branch_type <=  "00";
                            pc_sel      <=  "00";
            
            -- andi
            when "001100" =>
                            reg_write   <=  '1';
                            reg_dst     <=  '0';
                            reg_in_src  <=  '1';
                            alu_src     <=  '1';
                            add_sub     <=  '1';
                            data_write  <=  '0';
                            logic_func  <=  "00";
                            func        <=  "11";
                            branch_type <=  "00";
                            pc_sel      <=  "00";
            -- ori
            when "001101" =>
                            reg_write   <=  '1';
                            reg_dst     <=  '0';
                            reg_in_src  <=  '1';
                            alu_src     <=  '1';
                            add_sub     <=  '1';
                            data_write  <=  '0';
                            logic_func  <=  "01";
                            func        <=  "11";
                            branch_type <=  "00";
                            pc_sel      <=  "00";
            -- xori
            when "001110" =>
                            reg_write   <=  '1';
                            reg_dst     <=  '0';
                            reg_in_src  <=  '1';
                            alu_src     <=  '1';
                            add_sub     <=  '1';
                            data_write  <=  '0';
                            logic_func  <=  "10";
                            func        <=  "11";
                            branch_type <=  "00";
                            pc_sel      <=  "00";

            -- lw
            when "100011" =>
                        reg_write   <=  '1';
                        reg_dst     <=  '0';
                        reg_in_src  <=  '0';
                        alu_src     <=  '1';
                        add_sub     <=  '0';
                        data_write  <=  '0';
                        logic_func  <=  "10";
                        func        <=  "10";
                        branch_type <=  "00";
                        pc_sel      <=  "00";
            
            -- sw
            when "101011" =>
                        reg_write   <=  '0';
                        reg_dst     <=  '0';
                        reg_in_src  <=  '0';
                        alu_src     <=  '1';
                        add_sub     <=  '0';
                        data_write  <=  '1';
                        logic_func  <=  "00";
                        func        <=  "10";
                        branch_type <=  "00";
                        pc_sel      <=  "00";

            -- j
            when "000010" =>
                reg_write   <=  '0';
                reg_dst     <=  '0';
                reg_in_src  <=  '0';
                alu_src     <=  '0';
                add_sub     <=  '0';
                data_write  <=  '0';
                logic_func  <=  "00";
                func        <=  "00";
                branch_type <=  "00";
                pc_sel      <=  "01";


            -- bltz
            when "000001" =>
                reg_write   <=  '0';
                reg_dst     <=  '0';
                reg_in_src  <=  '0';
                alu_src     <=  '0';
                add_sub     <=  '0';
                data_write  <=  '0';
                logic_func  <=  "00";
                func        <=  "00";
                branch_type <=  "11";
                pc_sel      <=  "00";

            -- beq
            when "000100" =>
                reg_write   <=  '0';
                reg_dst     <=  '0';
                reg_in_src  <=  '0';
                alu_src     <=  '0';
                add_sub     <=  '0';
                data_write  <=  '0';
                logic_func  <=  "00";
                func        <=  "00";
                branch_type <=  "01";
                pc_sel      <=  "00"; 

            -- bne
            when "000101" =>
                reg_write   <=  '0';
                reg_dst     <=  '0';
                reg_in_src  <=  '0';
                alu_src     <=  '0';
                add_sub     <=  '0';
                data_write  <=  '0';
                logic_func  <=  "00";
                func        <=  "00";
                branch_type <=  "10";
                pc_sel      <=  "00";

            when others =>
        
        end case ;
    end process ; -- cases
    --------------------------------------------------------------------------------------------------

end sequential ;