`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2020 07:48:30 PM
// Design Name: 
// Module Name: Serializer
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


module Serializer(
    input clock_i, // 100 Mhz system clock
    input enable_i, //Enable the bitstream output to the audio filter input
    //output signals
    output logic done_o, //Enable to load the next 16-bit audio data
    input logic [15:0] data_i, //16-bit audio data input from memories
    // PDM
    output logic pdm_audio_o // bitstream output to the audio filter input (pin A11)
    //output pdm_sdaudio_o // Audio enable (pin D12), tie high
    //output logic temp_out //Temp LED used in 500Hz test
    );
    
    logic clock_1MHz = 0;
    logic [6:0] count_clock_i = 0;
    logic [4:0] count_clock_1MHz = 0;
    logic [15:0] data = 0;
    
    logic temp = 1;
    
    always_ff @ (posedge clock_i) begin
        if(count_clock_i == 49) begin //Every 100th clock_i cycle
            clock_1MHz <= ~clock_1MHz;
            count_clock_i <= 0;
        end else begin
            count_clock_i <= count_clock_i + 1'b1;
        end
    end
    
    always_ff @ (posedge clock_1MHz) begin
        if(enable_i) begin
            //Attempt to use 500Hz alternating square wave to hear audio... failed!
//            if(!(count_clock_1MHz % 2000)) begin
//                temp = ~temp; 
//            end    
            if(count_clock_1MHz == 0)
                data <= data_i; //initial data grab
                
            if(count_clock_1MHz == 16) begin //Every 17th clock_1MHz cycle
                //Get data from memories 
                data <= data_i;
                done_o <= 1;
                
                //Restart count
                count_clock_1MHz <= 0;
            end else begin
                //Output 1-bit of data every clock_1MHz cycle
                //  from LSB to MSB
                if(data[count_clock_1MHz]) pdm_audio_o <= 1'bz;
                else pdm_audio_o <= 1'b0;
                //pdm_audio_o = data[count_clock_1MHz];
                done_o <= 0;
                count_clock_1MHz <= count_clock_1MHz + 1'b1;
            end
        end    
    end
    
    // Used to cycle square wave in 500Hz test
//    always_comb begin
//        if(temp) pdm_audio_o = 1'bz;
//        else pdm_audio_o = 1'b0;
        
//        //pdm_audio_o = 1'bz;
        
//        temp_out = temp;
//    end
    
endmodule
