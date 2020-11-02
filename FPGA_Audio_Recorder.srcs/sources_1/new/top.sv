`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2020 11:34:36 AM
// Design Name: 
// Module Name: top
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


module top(
    input logic clock, reset, record, play, record_mem_sel, play_mem_sel,
    output logic [7:0] LED_anode,
    output logic [6:0] LED_cathode, 
    output logic idle_state,
    output logic pdm_clk_o, pdm_lrsel_o, input logic pdm_data_i,    //Deserializer
    output logic pdm_audio_o, pdm_sdaudio_o,                        //Serializer
    output logic recording_now, playing_now                         //LEDs -> not 7-seg display
    //output logic temp_led_out
    );
    
    logic deserializer_done, serializer_done; logic [15:0] serializer_data, mem1_dout, mem2_dout, deserializer_data;      //deserializer and serializer
    logic deserializer_en, serializer_en;                                                           //controller to deserializer and serializer
    logic mem1_en, mem2_en, mem1_wen, mem2_wen; logic [16:0] address;                               //controller to mem blocks
    logic timer_en;                                                                                 //controller to timer
    logic timer_done;                                                               
    logic play_sync, record_sync, record_sel_sync, play_sel_sync;                                   //synchronizer to controller
    logic timer_reset;
    
    
    memory_block mem1 (
        .clka(clock),    // input wire clka
        .ena(mem1_en),      // input wire ena
        .wea(mem1_wen),      // input wire [0 : 0] wea
        .addra(address),  // input wire [16 : 0] addra
        .dina(deserializer_data),    // input wire [15 : 0] dina
        .douta(mem1_dout)  // output wire [15 : 0] douta
        );
        
    memory_block mem2 (
        .clka(clock),    // input wire clka
        .ena(mem2_en),   // input wire ena
        .wea(mem2_wen),      // input wire [0 : 0] wea
        .addra(address),  // input wire [16 : 0] addra
        .dina(deserializer_data),    // input wire [15 : 0] dina
        .douta(mem2_dout)  // output wire [15 : 0] douta
        );
        
    controller controller1 (
        .clock(clock),
        .reset(reset),
        .record(record_sync),
        .play(play_sync),
        .recording_now(recording_now),
        .playing_now(playing_now),
        .record_mem_sel(record_sel_sync),
        .play_mem_sel(play_sel_sync),
        .timer1_done(timer1_done),
        .timer2_done(timer2_done),
        .deserializer_done(deserializer_done),
        .serializer_done(serializer_done),
        .deserializer_en(deserializer_en),
        .serializer_en(serializer_en),
        .mem1_en(mem1_en),
        .mem1_wen(mem1_wen),
        .mem2_en(mem2_en),
        .mem2_wen(mem2_wen),
        .mem_address(address),
        .timer_en(timer_en),
        .timer_reset(timer_reset)
        );
        
    Serializer serializer1(
        .clock_i(clock),
        .enable_i(serializer_en),
        .done_o(serializer_done),
        .data_i(serializer_data),
        .pdm_audio_o(pdm_audio_o)
        //.pdm_sdaudio_o(pdm_sdaudio_o)
        //.temp_out(temp_led_out)
        );
        
    Deserializer deserializer1(
        .clock_i(clock),
        .enable_i(deserializer_en),
        .done_o(deserializer_done),
        .data_o(deserializer_data),
        .pdm_clk_o(pdm_clk_o),
        .pdm_data_i(pdm_data_i)
        //.pdm_lrsel_o(pdm_lrsel_o)
        );
    
    Synchronizer synchronizer1 (
        .clock(clock),
        .record_in(record),
        .play_in(play),
        .record_mem_sel_in(record_mem_sel),
        .play_mem_sel_in(play_mem_sel),
        .record(record_sync),
        .play(play_sync),
        .record_mem_sel(record_sel_sync),
        .play_mem_sel(play_sel_sync)
        );
    
    Timer timer1 (
        .enable(timer_en),
        .reset(reset | timer_reset),
        .done(deserializer_done),
        //.serializer_done_o(serializer_done),
        .timer_done(timer1_done)
        );
        
    Timer timer2 (
        .enable(timer_en),
        .reset(reset | timer_reset),
        //.deserializer_done_o(deserializer_done),
        .done(serializer_done),
        .timer_done(timer2_done)
        );
    
    LED_decoder decoder1(
        .clock(clock),
        .record_sel(record_sel_sync), 
        .play_sel(play_sel_sync), 
        .A0(LED_anode[0]),
        .A1(LED_anode[1]),
        .A2(LED_anode[2]),
        .A3(LED_anode[3]),
        .A4(LED_anode[4]),
        .A5(LED_anode[5]),
        .A6(LED_anode[6]),
        .A7(LED_anode[7]),
        .common_cathode(LED_cathode)
        );
    
    always_comb begin
        if(mem1_en) serializer_data = mem1_dout;
        else serializer_data = mem2_dout;
    end
    
    always_comb begin
        //serializer_data = mem1_dout | mem2_dout;
        pdm_lrsel_o = 1'b0;
        pdm_sdaudio_o = 1'b1;
        
        idle_state = (!controller1.state);              //if state = S0
    end    
endmodule
