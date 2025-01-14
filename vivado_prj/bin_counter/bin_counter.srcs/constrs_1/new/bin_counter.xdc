set_property PACKAGE_PIN U18 [get_ports clk]
set_property PACKAGE_PIN G17 [get_ports led]
set_property PACKAGE_PIN F20 [get_ports reset_n]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports reset_n]

create_clock -period 20.000 -name clk -waveform {0.000 10.000} [get_ports clk]
