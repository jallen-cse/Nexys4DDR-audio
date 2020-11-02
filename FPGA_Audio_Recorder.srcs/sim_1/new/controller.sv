module controller(
        input logic clock, reset, record, play, mem_sel, timer_done,
        output logic deserializer_en, serializer_en, mem1_en, mem2_en, timer_en
        );

    logic [2:0] state, next_state;

    parameter IDLE = 3'b000;
    parameter RECORD_1 = 3'b001;
    parameter RECORD_2 = 3'b010;
    parameter PLAY_1 = 3'b011;
    parameter PLAY_2 = 3'b100;

    always_comb begin                                   //next state logic
        case (state)
            IDLE:       if(record && !mem_sel) next_state = RECORD_1;
                        else if(record && mem_sel) next_state = RECORD_2;
                        else if(play && !mem_sel) next_state = PLAY_1;
                        else if(play && mem_sel) next_state = PLAY_2;
                        else next_state = IDLE;

            RECORD_1:   if(timer_done) next_state = IDLE;
                        else next_state = RECORD_1;

            RECORD_2:   if(timer_done) next_state = IDLE;
                        else next_state = RECORD_2;

            PLAY_1:     if(timer_done) next_state = IDLE;
                        else next_state = PLAY_1;

            PLAY_2:     if(timer_done) next_state = IDLE;
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
                        mem2_en = 0;
                        timer_en = 0;
                        end
            RECORD_1:   begin
                        deserializer_en = 1;
                        serializer_en = 0;
                        mem1_en = 1;
                        mem2_en = 0;
                        timer_en = 1;
                        end
            RECORD_2:   begin
                        deserializer_en = 1;
                        serializer_en = 0;
                        mem1_en = 0;
                        mem2_en = 1;
                        timer_en = 1;
                        end
            PLAY_1:     begin
                        deserializer_en = 0;
                        serializer_en = 1;
                        mem1_en = 1;
                        mem2_en = 0;
                        timer_en = 1;
                        end
            PLAY_2:     begin
                        deserializer_en = 0;
                        serializer_en = 1;
                        mem1_en = 0;
                        mem2_en = 1;
                        timer_en = 1;
                        end
            default:    begin
                        deserializer_en = 0;
                        serializer_en = 0;
                        mem1_en = 0;
                        mem2_en = 0;
                        timer_en = 0;
                        end
        endcase
    end    
endmodule
