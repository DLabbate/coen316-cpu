#   Testing the sign_extender
#   4 cases of "func"
#   (00)    -->     load upper immediate (pad with 16 0s at least significant postions)
#   (01)    -->     set less immediate (pad high order with copy of immediate sign bit i15)
#   (10)    -->     arithmetic (pad high order with copy of immediate sign bit i15)
#   (11)    -->     logical (high order 16 bits padded with 0s)

#   Test Case 1 - (load upper immediate)
force sign_extender_in "1000000000000001"
force sign_extender_func "00"
run 2
examine sign_extender_out

#   Test Case 2 - (set less immediate)
force sign_extender_in "1000000000000001"
force sign_extender_func "01"
run 2
examine sign_extender_out

#   Test Case 3 - (arithmetic)
force sign_extender_in "1000000000000001"
force sign_extender_func "10"
run 2
examine sign_extender_out

#    Test Case 4 - (logical)
force sign_extender_in "1000000000000001"
force sign_extender_func "11"
run 2
examine sign_extender_out