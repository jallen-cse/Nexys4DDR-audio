`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2020 05:21:33 PM
// Design Name: 
// Module Name: Deserializer_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Deserializer_tb();
    logic enable_i;
    logic clock_i = 0;
    logic [6:0] count_clock_i;
    logic clock_1MHz;
    logic [4:0] count_clock_1MHz;
    logic [15:0] data;
    logic done_o = 0;
    logic [15:0] data_o = 0;
    logic pdm_data_i = 0;
    
    Deserializer dut(
        .clock_i(clock_i),
        .enable_i(enable_i), 
        .done_o(done_o),
        .data_o(data_o),
        .pdm_data_i(pdm_data_i)
        );

    always begin
        #5 clock_i = ~clock_i;
    end
    
    always @ (posedge clock_i) begin
        count_clock_i = dut.count_clock_i;
        clock_1MHz = dut.clock_1MHz;
        count_clock_1MHz = dut.count_clock_1MHz;
        data = dut.data; 
    end
    
    initial begin //70_000ns
        enable_i = 1'b1;
        //Word 1
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 1;
        
        //Word 2
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 0;
        #2000 pdm_data_i = 1;
        #2000 pdm_data_i = 0;
        
        #10000 $finish;
    end

endmodule
