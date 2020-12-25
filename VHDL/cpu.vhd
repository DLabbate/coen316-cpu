library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
entity cpu is
port(reset_cpu : in std_logic;
 clk_cpu : in std_logic;
 rs_out, rt_out : out std_logic_vector(31 downto 0);
 -- output ports from register file
 pc_out : out std_logic_vector(31 downto 0); -- pc reg
 overflow_cpu, zero_cpu : out std_logic);
end cpu;

architecture rtl of cpu is

    ---------------Components-----------------------------------------------------------------------------------
    component next_address
        port(rt, rs : in std_logic_vector(31 downto 0);
         -- two register inputs
         pc : in std_logic_vector(31 downto 0);
         target_address : in std_logic_vector(25 downto 0);
         branch_type : in std_logic_vector(1 downto 0);
         pc_sel : in std_logic_vector(1 downto 0);
         next_pc : out std_logic_vector(31 downto 0));
    end component ;

    component pc
        port (
          din : in std_logic_vector(31 downto 0) := (others => '0');
          reset : in std_logic;
          clk : in std_logic;
          q: out std_logic_vector(31 downto 0) := (others => '0')
        ) ;
    end component;

    component i_cache
        port( 
         address_input : in std_logic_vector(4 downto 0);
         instruction_out : out std_logic_vector(31 downto 0));
    end component ;

    component regfile
        port( din : in std_logic_vector(31 downto 0);
         reset : in std_logic;
         clk : in std_logic;
         write : in std_logic;
         read_a : in std_logic_vector(4 downto 0);
         read_b : in std_logic_vector(4 downto 0);
         write_address : in std_logic_vector(4 downto 0);
         out_a : out std_logic_vector(31 downto 0);
         out_b : out std_logic_vector(31 downto 0));
    end component ;

    component alu
        port(x, y : in std_logic_vector(31 downto 0);
         -- two input operands
         add_sub : in std_logic ; -- 0 = add , 1 = sub
         logic_func : in std_logic_vector(1 downto 0 ) ;
         -- 00 = AND, 01 = OR , 10 = XOR , 11 = NOR
         func : in std_logic_vector(1 downto 0 ) ;
         -- 00 = lui, 01 = setless , 10 = arith , 11 = logic
         output : out std_logic_vector(31 downto 0) ;
         overflow : out std_logic ;
         zero : out std_logic);
    end component ;

    component d_cache
        port( din : in std_logic_vector(31 downto 0);
         reset : in std_logic;
         clk : in std_logic;
         write : in std_logic;
         address : in std_logic_vector(4 downto 0);
         d_out : out std_logic_vector(31 downto 0));
    end component ;

    component sign_extender
        port (
          sign_extender_in    : in std_logic_vector (15 downto 0); -- (16-bit)
          sign_extender_func  : in std_logic_vector (1 downto 0);  -- func
          sign_extender_out   : out std_logic_vector (31 downto 0)
        ) ;
    end component;

    component control_unit
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
    end component;
    ------------------------------------------------------------------------------------------------------------



    -- Signals for connection of components
    ------------------------------------------------------------------------------------------------------------

    -- Signals for Next Address
    signal sig_next_pc     : std_logic_vector(31 downto 0);
    signal sig_pc_q        : std_logic_vector(31 downto 0);         -- output 'q' of pc

    signal sig_instruction_out :   std_logic_vector(31 downto 0);   -- output of instruction cache

    signal sig_din          : std_logic_vector(31 downto 0);        -- din to register file
    signal sig_reg_address  : std_logic_vector(4 downto 0);         -- register address for register file

    signal sig_out_a        : std_logic_vector(31 downto 0); 
    signal sig_out_b        : std_logic_vector(31 downto 0); 

    signal sig_alusrc_out   : std_logic_vector(31 downto 0);        -- 2nd input to alu
    signal sig_alu_output   : std_logic_vector(31 downto 0);        -- alu output

    signal sig_d_out        : std_logic_vector(31 downto 0);        -- d_cache output

    signal sig_extender_out    : std_logic_vector(31 downto 0);     -- sign_extender output

    signal sig_reg_in_src_out   : std_logic_vector(31 downto 0);    -- d_cache MUX output

    -- Control Signals
    signal sig_op: std_logic_vector(5 downto 0);
    signal sig_fn: std_logic_vector(5 downto 0);
    signal sig_reg_write :  std_logic;
    signal sig_reg_dst :  std_logic;
    signal sig_reg_in_src :  std_logic;
    signal sig_alu_src :  std_logic;
    signal sig_add_sub :  std_logic;
    signal sig_logic_func :  std_logic_vector(1 downto 0);
    signal sig_func :  std_logic_vector(1 downto 0); -- specifying the type of sign extension to be performed
    signal sig_data_write :  std_logic;
    signal sig_branch_type :  std_logic_vector(1 downto 0);
    signal sig_pc_sel :  std_logic_vector(1 downto 0);
    ------------------------------------------------------------------------------------------------------------


begin


    -- Port Mapping
    -----------------------------------------------------------------------------------------------------------


    program_counter :   pc          port map(   din     =>  sig_next_pc,
                                                reset   =>  reset_cpu,
                                                clk     =>  clk_cpu,
                                                q       =>  sig_pc_q);

    instructions    :   i_cache     port map(   address_input   => sig_pc_q(4 downto 0),
                                                instruction_out => sig_instruction_out);

    registers_f     :   regfile     port map(   din     => sig_reg_in_src_out,
                                                reset   => reset_cpu,
                                                clk     => clk_cpu,
                                                write   => sig_reg_write,
                                                read_a  => sig_instruction_out(25 downto 21), --rs address
                                                read_b  => sig_instruction_out(20 downto 16), --rt address
                                                write_address   => sig_reg_address,
                                                out_a   => sig_out_a,
                                                out_b   => sig_out_b);

    alu_comp        :   alu         port map(   x       => sig_out_a,
                                                y       => sig_alusrc_out,
                                                add_sub => sig_add_sub,
                                                logic_func  => sig_logic_func,
                                                func        => sig_func,
                                                output      => sig_alu_output,
                                                overflow    => overflow_cpu,
                                                zero        => zero_cpu);

    datacache       :   d_cache     port map(   din     => sig_out_b,
                                                reset   => reset_cpu,
                                                clk     => clk_cpu,
                                                write   => sig_data_write,
                                                address => sig_alu_output(4 downto 0),
                                                d_out   => sig_d_out);

    sign            :   sign_extender   port map(   sign_extender_in    => sig_instruction_out(15 downto 0),
                                                    sign_extender_func  => sig_func,
                                                    sign_extender_out   => sig_extender_out);
    
    next_pc         :   next_address    port map(   rt  => sig_out_b,
                                                    rs  => sig_out_a,
                                                    pc  => sig_pc_q,
                                                    target_address  => sig_instruction_out(25 downto 0),
                                                    branch_type     => sig_branch_type,
                                                    pc_sel          => sig_pc_sel,
                                                    next_pc         => sig_next_pc);

    controller      :   control_unit    port map(   op          => sig_instruction_out(31 downto 26),
                                                    fn          => sig_instruction_out(5 downto 0),
                                                    reg_write   => sig_reg_write,
                                                    reg_dst     => sig_reg_dst,
                                                    reg_in_src  => sig_reg_in_src,
                                                    alu_src     => sig_alu_src,
                                                    add_sub     => sig_add_sub,
                                                    logic_func  => sig_logic_func,
                                                    func        => sig_func,
                                                    data_write  => sig_data_write,
                                                    branch_type => sig_branch_type,
                                                    pc_sel      => sig_pc_sel);

    
    -----------------------------------------------------------------------------------------------------------

    -- MUX
    -----------------------------------------------------------------------------------------------------------
    sig_reg_address     <=  sig_instruction_out(20 downto 16) when (sig_reg_dst = '0') else
                            sig_instruction_out(15 downto 11) when (sig_reg_dst = '1');

    sig_alusrc_out      <=  sig_out_b           when (sig_alu_src = '0') else
                            sig_extender_out    when (sig_alu_src = '1');

    sig_reg_in_src_out  <=  sig_d_out           when (sig_reg_in_src = '0') else
                            sig_alu_output      when (sig_reg_in_src = '1');
    -----------------------------------------------------------------------------------------------------------

    rs_out  <= sig_out_a; --rs
    rt_out  <= sig_out_b; --rt
    pc_out  <= sig_pc_q;

end rtl ; -- rtl