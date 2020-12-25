#   Testing the control_unit
#   The values should correspond with the control signals table in the lab report

#   Test Case 1 - lui
force op "001111"
run 2
examine reg_write reg_dst reg_in_src alu_src add_sub data_write logic_func func branch_type pc_sel

#   Test Case 2 - and
force op "000000"
force fn "100100"
run 2
examine reg_write reg_dst reg_in_src alu_src add_sub data_write logic_func func branch_type pc_sel