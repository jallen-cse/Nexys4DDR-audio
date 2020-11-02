`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2020 07:48:30 PM
// Design Name: 
// Module Name: Synchronizer
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


module Synchronizer(
    input logic clock, record_in, play_in, record_mem_sel_in, play_mem_sel_in,
    output logic record, play, record_mem_sel, play_mem_sel);
    
    always_ff @(posedge clock) begin
        record <= record_in;
        play <= play_in;
        record_mem_sel <= record_mem_sel_in;
        play_mem_sel <= play_mem_sel_in;
    end
endmodule
