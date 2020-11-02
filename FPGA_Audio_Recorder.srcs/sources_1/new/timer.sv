module Timer(
    input logic enable, reset, done,//deserializer_done_o, serializer_done_o,
    output logic timer_done = 0
    );

    logic [16:0] internal_count = 0;
    logic done_sigs;
    
    //always_comb done_sigs = deserializer_done_o | serializer_done_o;
    
    always_ff @(posedge done, posedge reset) begin
        if(reset == 1'b1) internal_count <= 0;
        else if(enable == 1'b1) internal_count <= internal_count + 1'b1;
        else internal_count <= 0;
    end

    always_comb begin
        if(internal_count >= 17'b1_1110_1000_0100_1000) timer_done = 1'b1;
        else timer_done = 1'b0;
    end
endmodule