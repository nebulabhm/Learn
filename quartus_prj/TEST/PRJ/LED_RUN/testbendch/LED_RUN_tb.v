`timescale 1ns/1ps

module LED_RUN_tb;

//激励信号定义，对应连接到待测试模块的输入端口
	reg signal_a;
	reg signal_b;
	reg signal_c;
	
//待检测信号定义，对应连接到待测试模块的输出端口
	wire led;
	
//例化待测试模块
	LED_RUN led_run0(
		.a(signal_a),
		.b(signal_b),
		.key_in(signal_c),
		.led_out(led)
	);
	
//产生激励
	initial begin
		signal_a = 0;
		signal_b = 0;
		signal_c = 0;
		#100;	// delay 100 ns
		signal_a = 0;
		signal_b = 0;
		signal_c = 1;
		#100;
		signal_a = 0;
		signal_b = 1;
		signal_c = 0;
		#100;		
		signal_a = 0;
		signal_b = 1;
		signal_c = 1;
		#100;	// delay 100 ns
		signal_a = 1;
		signal_b = 0;
		signal_c = 0;
		#100;
		signal_a = 1;
		signal_b = 0;
		signal_c = 1;
		#100;		
		signal_a = 1;
		signal_b = 1;
		signal_c = 0;
		#100;	// delay 100 ns
		signal_a = 1;
		signal_b = 1;
		signal_c = 1;
		#200;
		
		$stop;
	end
	
endmodule
