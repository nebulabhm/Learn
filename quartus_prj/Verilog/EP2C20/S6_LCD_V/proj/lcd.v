module lcd(clk,rst,lcd_e,lcd_rw,lcd_rs,data);
	input clk,rst;
	output lcd_e,lcd_rw,lcd_rs;
	output [7:0] data;
	reg lcd_e,lcd_rw,lcd_rs;
	reg [7:0] data;
	
	reg [10:0] state;
	reg flag;
	reg [5:0] address;
	
	
	parameter IDLE		=11'b00000000000;
	parameter CLEAR		=11'b00000000001;		//����
	
	parameter RETURNCURSOR	=11'b00000000010;	//��homeλ
	
	parameter SETMODE	=11'b00000000100;		
	//���뷽ʽ���ã���д���ݺ�ram��ַ��/��1�����涯/����
	
	parameter SWITCHMODE	=11'b00000001000;	
	//��ʾ״̬���ã���ʾ��/�أ���꿪/�أ���˸��/��
	
	parameter SHIFT		=11'b00000010000;		
	//��껭����� ����/���ƽ��һλ����/��ƽ��һλ
	
	parameter SETFUNCTION	=11'b00000100000;	
	//������ʽ���� 1��8/1��4λ���ݽӿڣ�����/һ����ʾ��5x10/5x7����
	
	parameter SETCGRAM	=11'b00001000000;		//����CGRAM
	parameter SETDDRAM	=11'b00010000000;		//����DDRAM
	parameter READFLAG	=11'b00100000000;		//
	parameter WRITERAM	=11'b01000000000;		//дRAM
	parameter READRAM	=11'b10000000000;		//��RAM

	parameter cur_inc      	=1;
	parameter cur_dec      	=0;
	parameter cur_shift    	=1;
	parameter cur_noshift  	=0;
	parameter open_display 	=1;
	parameter open_cur     	=0;
	parameter blank_cur    	=0;
	parameter shift_display	=1;
	parameter shift_cur    	=0;
	parameter right_shift  	=1;
	parameter left_shift   	=0;
	parameter datawidth8   	=1;
	parameter datawidth4   	=0;
	parameter twoline      	=1;
	parameter oneline      	=0;
	parameter font5x10     	=1;
	parameter font5x7      	=0;

	function [7:0] ddram;
		input [5:0] n;
		begin
			case(n)
			6'b000_000:ddram=8'b0100_1100;//L
			6'b000_001:ddram=8'b0100_1100;//L
			6'b000_010:ddram=8'b0100_1100;//L
			6'b000_011:ddram=8'b0100_1100;//L
			6'b000_100:ddram=8'b0100_1100;//L
			6'b000_101:ddram=8'b0100_1100;//L
			endcase
		end
	endfunction
	
	reg [15:0] clkcnt;
	
	always @ (posedge clk)
	if(!rst)
	clkcnt<=16'b0000_0000_0000_0000;
	else
	begin
		if(clkcnt==16'b1001_1100_0100_0000)
			clkcnt<=16'b0000_0000_0000_0000;
		else 
			clkcnt<=clkcnt+1;
	end
	
	wire tc_clkcnt;
	assign tc_clkcnt=(clkcnt==16'b1001_1100_0100_0000)?1:0;
	
	reg clkdiv;
	always @ (posedge tc_clkcnt)
	if(!rst)
		clkdiv<=0;
	else
		clkdiv<=~clkdiv;
	
	reg clk_int;
	always @ (posedge clkdiv)
	if(rst==0)
		clk_int<=0;
	else
		clk_int<=~clk_int;
		
	always @ (negedge clkdiv)
	if(rst==0)
		lcd_e<=0;
	else
		lcd_e<=~lcd_e;
		
		
	always @ (posedge clk_int or negedge rst)
		if(!rst)
		begin
			state<=IDLE;
			address<=6'b000_000;
			flag<=0;
		end
		else
		begin
			case(state)
			IDLE		:begin 
							data<=8'bzzzz_zzzz;
							if(flag==0)
							begin
								state<=SETFUNCTION;
								flag<=1;
							end
							else
								state<=SHIFT;
						 end
			CLEAR			:begin lcd_rs<=0;lcd_rw<=0;data<=8'b0000_0001;
									state<=SETMODE;end   
			SETMODE			:begin lcd_rs<=0;lcd_rw<=0;data[7:2]<=6'b000001;data[1]<=cur_inc;data[0]<=cur_noshift;
									state<=WRITERAM;end
			RETURNCURSOR	:begin lcd_rs<=0;lcd_rw<=0;data<=8'b00000010;
									state<=WRITERAM;end
			SWITCHMODE 		:begin lcd_rs<=0;lcd_rw<=0;data[7:3]<=5'b00001;data[2]<=open_display;data[1]<=open_cur;data[0]<=blank_cur;
								state<=CLEAR;end
			SHIFT			:begin lcd_rs<=0;lcd_rw<=0;data[7:4]<=4'b0001;data[3]<=shift_cur;data[2]<=left_shift;data[1:0]<=2'b00;
								state<=IDLE;end
			SETFUNCTION		:begin lcd_rs<=0;lcd_rw<=0;data[7:5]<=3'b001;data[4]<=datawidth8;data[3]<=twoline;data[2]<=font5x10;data[1:0]<=2'b00;
								state<=SWITCHMODE;end
			SETCGRAM		:begin lcd_rs<=0;lcd_rw<=0;data<=8'b01000000;state<=IDLE;end
			SETDDRAM		:begin lcd_rs<=0;lcd_rw<=0;data<=8'b10000000;state<=WRITERAM;end
			WRITERAM		:begin
							if(address<=6'b000_101)
							begin
								lcd_rs<=1;
								lcd_rw<=0;
								data<=ddram(address);
								address<=address+1;
								state<=WRITERAM;
							end
							else
							begin
								lcd_rs<=0;
								lcd_rw<=0;
								state<=SHIFT;
								address<=6'b000_000;
							end
							end
			endcase
		end
endmodule
							
			
			
		
		
