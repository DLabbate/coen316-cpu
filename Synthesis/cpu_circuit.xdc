# cpu_circuit.xdc
# XDC file for cpu.vhd

set_property  IOSTANDARD LVCMOS33  [ get_ports { reset_cpu }  ] ;
set_property  IOSTANDARD LVCMOS33  [ get_ports { clk_cpu }  ] ;
set_property  IOSTANDARD LVCMOS33  [ get_ports { rs_out }  ] ;
set_property  IOSTANDARD LVCMOS33  [ get_ports { rt_out }  ] ;
set_property  IOSTANDARD LVCMOS33  [ get_ports { pc_out }  ] ;
set_property  IOSTANDARD LVCMOS33  [ get_ports { overflow_cpu }  ] ;
set_property  IOSTANDARD LVCMOS33  [ get_ports { zero_cpu }  ] ;