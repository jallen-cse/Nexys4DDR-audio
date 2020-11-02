`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2020 07:48:30 PM
// Design Name: 
// Module Name: Deserializer
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
module Deserializer(
    input clock_i, // 100 Mhz system clock
    input enable_i, // Enable the 1MHz clock to the microphone to read audio data
    //output signals
    output logic done_o, //Indicates that data is ready for being written into memory
    output logic [15:0] data_o, //Output 16-bit Word
    //PDM Microphone related signals    
    output logic pdm_clk_o, //1MHz clock (pin J5)
    input pdm_data_i //audio input bitstream(pin H5)
    //output pdm_lrsel_o //select L/R channel(pin F5)
    );
    logic clock_1MHz = 0;
    logic [6:0] count_clock_i = 0;
    logic [4:0] count_clock_1MHz = 0;
    logic [15:0] data = 0;
//    logic [6:0] count_clock_i = 7'b000_0000;
//    logic [4:0] count_clock_1MHz = 5'b0_0000;
//    logic [15:0] data = 16'b0000_0000_0000_0000;
    assign pdm_clk_o = clock_1MHz;
    always_ff @ (posedge clock_i) begin
        if(count_clock_i == 49) begin //Every 50th clock_i cycle
            clock_1MHz <= ~clock_1MHz;
            count_clock_i <= 0;
        end
        else begin
            count_clock_i <= count_clock_i + 1'b1;
        end
    end    
    always_ff @ (posedge clock_1MHz) begin
        if(enable_i == 1'b1) begin
            if(count_clock_1MHz == 16) begin //Every 17th clock_1MHz cycle
                //Send collected data 
                data_o <= data;
                done_o <= 1;
                //Restart count/collection
                count_clock_1MHz <= 0;
                //data <= 0;
            end else begin
                //Collect 1-bit data every clock_1MHz cycle
                //  shifted in at LSB
                //data <= {data[14:0], pdm_data_i};
                data <= {pdm_data_i, data[15:1]};
                //data[count_clock_1MHz] <= pdm_data_i;
                done_o <= 0;
                //data_o <= 0;
                count_clock_1MHz <= count_clock_1MHz + 1'b1;
            end
        end    
    end
endmodule