module controller(
        input logic clock, reset, record, play, record_mem_sel, play_mem_sel, timer1_done, timer2_done, deserializer_done, serializer_done,
        output logic deserializer_en, serializer_en, mem1_en, mem1_wen, mem2_en, mem2_wen, timer_en, recording_now, playing_now, timer_reset,
        output logic [16:0] mem_address
        );
    logic [2:0] state, next_state;
    logic [16:0] address;
    //logic done_once;
    parameter IDLE = 3'b000;
    parameter RECORD_1 = 3'b001;
    parameter RECORD_2 = 3'b010;
    parameter PLAY_1 = 3'b011;
    parameter PLAY_2 = 3'b100;
    always_ff @(posedge reset, posedge record, posedge play, posedge deserializer_done, posedge serializer_done) begin
        if(reset) begin
            address <= 0;
            //done_once <= 0;
        end
        else if(record) begin
            address <= 0;
            //done_once <= 0;
        end
        else if(play) begin
            address <= 0;
            //done_once <= 0;
        end
        else if(deserializer_done) begin
            address <= address + 1'b1;
            //done_once <= done_once;
        end
        else if(serializer_done) begin
            address <= address + 1'b1;
            //done_once <= done_once;
        end
        else begin 
            address <= address;
            //done_once <= 1'b1;
        end
    end
    assign mem_address = address;
    always_comb begin                                   //next state logic
        case (state)
            IDLE:       if(record && !record_mem_sel) next_state = RECORD_1;
                        else if(record && record_mem_sel) next_state = RECORD_2;
                        else if(play && !play_mem_sel) next_state = PLAY_1;
                        else if(play && play_mem_sel) next_state = PLAY_2;
                        else next_state = IDLE;
            RECORD_1:   if(timer1_done) next_state = IDLE;
                        else next_state = RECORD_1;
            RECORD_2:   if(timer1_done) next_state = IDLE;
                        else next_state = RECORD_2;
            PLAY_1:     if(timer2_done) next_state = IDLE;
                        else next_state = PLAY_1;
            PLAY_2:     if(timer2_done) next_state = IDLE;
                        else next_state = PLAY_2;
            default:    next_state = IDLE;
        endcase
    end
    always_ff @(posedge clock, posedge reset) begin     //state transition
        if(reset) state <= IDLE;
        else state <= next_state;
    end
    always_comb begin                                   //output logic
        case (state)
            IDLE:       begin
                        deserializer_en = 0;
                        serializer_en = 0;
                        mem1_en = 0;
                        mem1_wen = 0;
                        mem2_en = 0;
                        mem2_wen = 0;
                        timer_en = 0;
                        recording_now = 0;
                        playing_now = 0;
                        timer_reset = 1;
                        end
            RECORD_1:   begin
                        deserializer_en = 1;
                        serializer_en = 0;
                        mem1_en = 1;
                        if(deserializer_done) mem1_wen = 1;
                        else mem1_wen = 0;
                        mem2_en = 0;
                        mem2_wen = 0;
                        timer_en = 1;
                        recording_now = 1;
                        playing_now = 0;
                        timer_reset = 0;
                        end
            RECORD_2:   begin
                        deserializer_en = 1;
                        serializer_en = 0;
                        mem1_en = 0;
                        mem1_wen = 0;
                        mem2_en = 1;
                        if(deserializer_done) mem2_wen = 1;
                        else mem2_wen = 0;
                        timer_en = 1;
                        recording_now = 1;
                        playing_now = 0;
                        timer_reset = 0;
                        end
            PLAY_1:     begin
                        deserializer_en = 0;
                        serializer_en = 1;
                        mem1_en = 1;
                        mem1_wen = 0;
                        mem2_en = 0;
                        mem2_wen = 0;
                        timer_en = 1;
                        recording_now = 0;
                        playing_now = 1;
                        timer_reset = 0;
                        end
            PLAY_2:     begin
                        deserializer_en = 0;
                        serializer_en = 1;
                        mem1_en = 0;
                        mem1_wen = 0;
                        mem2_en = 1;
                        mem2_wen = 0;
                        timer_en = 1;
                        recording_now = 0;
                        playing_now = 1;
                        timer_reset = 0;
                        end
            default:    begin
                        deserializer_en = 0;
                        serializer_en = 0;
                        mem1_en = 0;
                        mem1_wen = 0;
                        mem2_en = 0;
                        mem2_wen = 0;
                        timer_en = 0;
                        recording_now = 0;
                        playing_now = 0;
                        timer_reset = 0;
                        end
        endcase
    end    
endmodule