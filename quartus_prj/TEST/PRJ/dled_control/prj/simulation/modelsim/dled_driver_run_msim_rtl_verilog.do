transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl {H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl/crystal_1KHz.v}
vlog -vlog01compat -work work +incdir+H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl {H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl/loop_shifter_8b.v}
vlog -vlog01compat -work work +incdir+H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl {H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl/dled_decoder.v}
vlog -vlog01compat -work work +incdir+H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl {H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl/dled_disp_data_decoder.v}
vlog -vlog01compat -work work +incdir+H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl {H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl/dled_module_enable.v}
vlog -vlog01compat -work work +incdir+H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl {H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl/dled_hex8.v}
vlog -vlog01compat -work work +incdir+H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl {H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl/HC595_Driver.v}
vlog -vlog01compat -work work +incdir+H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl {H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/rtl/HXE_top.v}
vlib hex_data
vmap hex_data hex_data
vlog -vlog01compat -work hex_data +incdir+h:/my_workshop/learn_fpga/exercises/test/prj/dled_control/prj/db/ip/hex_data {h:/my_workshop/learn_fpga/exercises/test/prj/dled_control/prj/db/ip/hex_data/hex_data.v}
vlog -vlog01compat -work hex_data +incdir+h:/my_workshop/learn_fpga/exercises/test/prj/dled_control/prj/db/ip/hex_data/submodules {h:/my_workshop/learn_fpga/exercises/test/prj/dled_control/prj/db/ip/hex_data/submodules/altsource_probe_top.v}

vlog -vlog01compat -work work +incdir+H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/prj/../testbench {H:/my_workshop/learn_fpga/Exercises/TEST/PRJ/dled_control/prj/../testbench/dled_hex8_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L hex_data -voptargs="+acc"  dled_hex8_tb

add wave *
view structure
view signals
run -all