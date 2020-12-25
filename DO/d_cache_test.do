#   Testing the d_cache
#   We will test the reset, writing to the file, and reading

#   Test Case 1 - reset
force din x"ABCDABCD"
force reset 1
force clk 0
force write 1
force address "00000"
run 2
examine -radix hex reg_array(0) -radix hex d_out

#   Test Case 2 - write
#   hex "ABCDABCD" should be written to reg(0)
#   Note that we create a rising edge!
force clk 0
run 2
force din x"ABCDABCD"
force reset 0
force clk 1
force write 1
force address "00000"
run 2
examine -radix hex reg_array(0) -radix hex d_out

#   Test Case 3 - read
#   d_out should be zero because we will examine reg(1) which has never been written to
#   write = '0' (so it will not be written to)
#   Note that we create a rising edge!
force clk 0
run 2
force din x"ABCDABCD"
force reset 0
force clk 1
force write 0
force address "00001"
run 2
examine -radix hex reg_array(1) -radix hex d_out
