`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2020 03:24:40 PM
// Design Name: 
// Module Name: Synchronizer_tb
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


module Synchronizer_tb();
    logic clock, record_in, play_in, record_mem_sel_in, play_mem_sel_in;
    logic record_sync, play_sync, record_mem_sel_sync, play_mem_sel_sync;

    always #10 clock = ~clock;
    
    Synchronizer dut(.clock(clock), .record_in(record_in), .play_in(play_in), .record_mem_sel_in(record_mem_sel_in), .play_mem_sel_in(play_mem_sel_in), .record(record_sync), .play(play_sync), .record_mem_sel(record_mem_sel_sync), .play_mem_sel(play_mem_sel_sync));
    
    initial begin
        clock = 0;
        #2
        record_in = 0;
        play_in = 0;
        record_mem_sel_in = 0;
        play_mem_sel_in = 0;
        
        #30
        record_in = 1;
        play_in = 1;
        record_mem_sel_in = 1;
        play_mem_sel_in = 1;
    end
endmodule
