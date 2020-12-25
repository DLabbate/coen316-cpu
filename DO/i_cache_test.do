#   Testing the i_cache with a few sample opcodes

#   In particular, we will test the following opcodes which should result in a particular instruction:
#   "00000"     ->      "00100000000000110000000000000000"; -- addi r3, r0, 0
#   "00001"     ->      "00100000000000010000000000000000"; -- addi r1, r0, 0
#   "00110"     ->      "00001000000000000000000000000011"; -- jump 3  (LOOP)

#   Test Case 1
force address_input "00000"
run 2
examine instruction_out

#   Test Case 2
force address_input "00001"
run 2
examine instruction_out

#   Test Case 3
force address_input "00110"
run 2
examine instruction_out