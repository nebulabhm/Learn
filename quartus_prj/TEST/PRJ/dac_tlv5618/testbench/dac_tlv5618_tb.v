`timescale 1ns/1ns
`define clock_period 20

module dac_tlv5618_tb;

    reg Clk;
    reg Rst_n;
    reg Start;
    reg [15:0]Dac_data;

    wire Set_done;
    wire CS_N;
    wire DIN;
    wire SCLK;

    dac_tlv5618 dac_tlv5618(
        .Clk(Clk),   // clock 50MHz
        .Rst_n(Rst_n), // module reset

        .Start(Start),
        .Dac_data(Dac_data),
        .Set_done(Set_done),

        .CS_N(CS_N),  // TLV5618 chip select
        .DIN(DIN),   // data in
        .SCLK(SCLK),  // serial clock
        .DAC_STATE()
        );

    initial Clk = 1;
    always#(`clock_period/2) Clk = ~Clk;

    initial begin
        Rst_n = 0;
        Start = 0;
        Dac_data = 0;

        #201;
        Rst_n = 1;

        #200;
        Dac_data = 16'hC_AAA;
        Start = 1;

        #20;
        Start = 0;

        #200;
        wait(Set_done);

        #20000;
        Dac_data = 16'h4_555;
        Start = 1;

        #20
        Start = 0;

        #200;
        wait(Set_done);
        $stop;

    end
endmodule
