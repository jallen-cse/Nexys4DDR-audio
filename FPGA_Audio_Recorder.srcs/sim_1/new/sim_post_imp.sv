`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2020 11:45:40 AM
// Design Name: 
// Module Name: top_tb
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


module top_tb();
    logic clock, reset, record, play, clk_1MHz, pdm_clk_o, timer_en, timer_done, pdm_lrsel_o, pdm_data_i, deserializer_en;
    logic deserializer_done;
    logic [15:0] deserializer_data_out;
    logic mem1_en, mem1_wen;
    logic [16:0] mem_addr;
    logic serializer_en;
    logic [15:0] serializer_data_in;
    logic serializer_done;
    logic pdm_audio_o, pdm_sdaudio_o;
  
    always
        #5 clock = ~clock;
        
    top top1(
        .clock(clock),
        .reset(reset),
        .record(record),
        .play(play),
        .record_mem_sel(1'b0),
        .play_mem_sel(1'b0),
        .pdm_clk_o(pdm_clk_o),
        .pdm_lrsel_o(pdm_lrsel_o),
        .pdm_data_i(pdm_data_i),
        .pdm_audio_o(pdm_audio_o),
        .pdm_sdaudio_o(pdm_sdaudio_o)
        );
        
    /*always @ (negedge pdm_clk_o) begin
        pdm_data_i = ~pdm_data_i;
    end*/
    
    always_comb begin
        mem_addr = top1.controller1.address;
        //controller_state = top1.controller1.state;
        //deserializer_en = top1.controller1.deserializer_en;
        //serializer_en = top1.controller1.serializer_en;
        //mem1_en = top1.controller1.mem1_en;
        //mem1_wen = top1.controller1.mem1_wen;
        //mem2_en = top1.controller1.mem2_en;
        //mem2_wen = top1.controller1.mem2_wen;
        timer_en = top1.controller1.timer_en;
        
        //deserializer_internal_data = top1.deserializer1.data;
        deserializer_data_out = top1.deserializer_data;
        //serializer_data_in = top1.serializer_data;
        //serializer_internal_data = top1.serializer1.data;
        clk_1MHz = pdm_clk_o;
       
        //timer_done = top1.timer_done;
        //timer_internal_count = top1.timer1.internal_count;
        deserializer_done = top1.deserializer_done;
        serializer_done = top1.serializer_done;
        
        
    end
        
        
    initial begin
        pdm_data_i = 0;        
        clock = 0;
        
        #200
        
        
        reset = 1;
        #20
        reset = 0;
        
        #20
        //record_mem_sel = 0;
        //play_mem_sel = 0;
        record = 1;
        #10
        record = 0;
        
        pdm_data_i = 0;
        #1000
        pdm_data_i = 1;
        #1000
        pdm_data_i = 0;
        #1000
        pdm_data_i = 1;
        #1000
        pdm_data_i = 0;
        #1000
        pdm_data_i = 1;
        #1000
        pdm_data_i = 0;
        #1000
        pdm_data_i = 1;
        #1000
        pdm_data_i = 0;
        #1000
        pdm_data_i = 1;
        #1000
        pdm_data_i = 0;
        #1000
        pdm_data_i = 1;
        #1000
        pdm_data_i = 0;
        #1000
        pdm_data_i = 1;
        #1000
        pdm_data_i = 0;
        #1000
        pdm_data_i = 1;
        
        #30000
        reset = 1;
        #10
        reset = 0;
        #10
        play = 1;
        #10
        play = 0;
        
        
        
        
    
    end
endmodule
