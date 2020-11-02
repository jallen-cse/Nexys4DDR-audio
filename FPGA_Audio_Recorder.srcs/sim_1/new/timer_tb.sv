`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2020 08:33:12 PM
// Design Name: 
// Module Name: timer_tb
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


module timer_tb();

    logic enable, reset, deserializer_done_o, serializer_done_o, timer_done;
    logic [16:0] timer_internal_count;
    
    Timer dut(.enable(enable), .reset(reset), .deserializer_done_o(deserializer_done_o), .serializer_done_o(serializer_done_o), .timer_done(timer_done));
    
    //always #5 deserializer_done_o = ~deserializer_done_o; //treats this like a clock
    always #1 serializer_done_o = ~serializer_done_o;
    
    always_comb begin
        timer_internal_count = dut.internal_count;
    end
    
    initial begin
        enable = 1;
        serializer_done_o = 1;
        
    
    end

endmodule
