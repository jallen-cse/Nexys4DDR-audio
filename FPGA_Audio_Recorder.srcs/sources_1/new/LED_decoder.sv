`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2020 12:01:28 PM
// Design Name: 
// Module Name: LED_decoder
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


module LED_decoder(input clock, record_sel, play_sel, output logic A0, A1, A2, A3, A4, A5, A6, A7, output logic [6:0] common_cathode);
    
    logic [23:0] clock_count = 0;
    logic clock_sig;
    logic [2:0] count = 3'b000;
    
    always_ff @(posedge clock) begin
        clock_count <= clock_count + 1;
    end
    
    assign clock_sig = clock_count[17];
    
    always_ff @(posedge clock_sig) begin
        count <= count + 1;
    end
    
    always @(count) begin
        A0 <= 1'b1;
        A1 <= 1'b1;
        A2 <= 1'b1;
        A3 <= 1'b1;
        A4 <= 1'b1;
        A5 <= 1'b1;
        A6 <= 1'b1;
        A7 <= 1'b1;
        
        case(count)
        0:
        begin
            A0 <= 1'b0;
            if(~record_sel) common_cathode <= 7'b1001111;
            else common_cathode <= 7'b0010010;
        end
        
        1:
        begin
            A1 <= 1'b0;
            if(~play_sel) common_cathode <= 7'b1001111;
            else common_cathode <= 7'b0010010;
        end
        
        2:
        begin
            A2 <= 1'b0;
            common_cathode <= 7'b1111111;
        end
        
        3:
        begin
            A3 <= 1'b0;
            common_cathode <= 7'b1111111;
        end
       
        4:
        begin
            A4 <= 1'b0;
            common_cathode <= 7'b1111111;
        end
       
        5:
        begin
            A5 <= 1'b0;
            common_cathode <= 7'b1111111;
        end
       
        6:
        begin
            A6 <= 1'b0;
            common_cathode <= 7'b1111111;
        end
       
        7:
        begin
            A7 <= 1'b0;
            common_cathode <= 7'b1111111;
        end
    endcase
    end
endmodule