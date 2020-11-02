`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2020 11:06:42 AM
// Design Name: 
// Module Name: Serializer_tb
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


module Serializer_tb();
    logic enable_i = 0;
    logic clock_i = 0;
    logic [6:0] count_clock_i = 0;
    logic clock_1MHz = 0;
    logic [4:0] count_clock_1MHz = 0;    
    logic [15:0] data_i = 16'b1100_1010_0011_0101;
    logic [15:0] data;
    logic done_o;
    logic pdm_audio_o;
    
    
    Serializer dut(
        .clock_i(clock_i),
        .enable_i(enable_i),  
        .done_o(done_o),
        .data_i(data_i),        
        .pdm_audio_o(pdm_audio_o)
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
        #5000 //quick change on data_i to see if TRMT still works
        
        data_i = 16'b1111_0000_1010_0101;
        
        #65000 $finish;
    end

endmodule
