# Testing the cpu with the provided machine code in the i_cache

# NOTES
# pc_out --> output of the pc (I display all 32-bits, but only the low order 5 bits are important)
# sig_instruction_out --> this is the instruction
# sig_reg_in_src_out --> this is the MUX output of the d_cache (so we can see what data goes to the destination register!)

# We add enough clock cycles so that the program can finish execution

force reset_cpu 1
force clk_cpu 0
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out

force reset_cpu 0
force clk_cpu 0
run 2
force clk_cpu 1
run 2
examine pc_out sig_instruction_out sig_reg_in_src_out