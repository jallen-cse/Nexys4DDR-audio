`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2020 03:12:13 PM
// Design Name: 
// Module Name: LED_tb
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


module LED_tb();
    logic clock, record_sel, play_sel, A0, A1, A2, A3, A4, A5, A6, A7;
    logic [6:0] cathode;
    
    LED_decoder dut(.clock(clock), .record_sel(record_sel), .play_sel(play_sel), .A0(A0), .A1(A1), .A2(A2), .A3(A3), .A4(A4), .A5(A5), .A6(A6), .A7(A7), .common_cathode(cathode));
    
    always #1 clock = ~clock;
    
    initial begin
        clock = 0;
        
        record_sel = 0;
        play_sel = 0;
        #1000
        record_sel = 1;
        play_sel = 1;
        
    end
    
endmodule
