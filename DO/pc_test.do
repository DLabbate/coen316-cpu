#   Testing the pc

#   Test Case 1 - reset
#   The output 'q' should be zero
force reset 1
force din x"ABCDABCD"
run 2
examine -radix hex q

#   Test Case 2 - normal operation with rising edge
#   The output 'q' should be hex"ABCDABCD"
force clk 0
run 2
force reset 0
force din x"ABCDABCD"
force clk 1
run 2
examine -radix hex q