//`include "controller.sv"

module controller_tb();
    logic clock, reset, record, play, record_mem_sel, play_mem_sel, timer_done, deserializer_done, serializer_done;
    logic deserializer_en, serializer_en, mem1_en, mem1_wen, mem2_en, mem2_wen, timer_en, recording_now, playing_now;
    logic [16:0] mem_address;
    logic [2:0] controller_state;

    controller dut(
        .clock(clock),
        .reset(reset),
        .record(record),
        .play(play),
        .record_mem_sel(record_mem_sel),
        .play_mem_sel(play_mem_sel),
        .timer_done(timer_done),
        .deserializer_done(deserializer_done),
        .serializer_done(serializer_done),
        .deserializer_en(deserializer_en),
        .serializer_en(serializer_en),
        .mem1_en(mem1_en),
        .mem1_wen(mem1_wen),
        .mem2_en(mem2_en),
        .mem2_wen(mem2_wen),
        .timer_en(timer_en),
        .recording_now(recording_now),
        .playing_now(playing_now)
        );

    always
        #5 clock = ~clock;
        
    assign controller_state = dut.state;
    assign mem_address = dut.address;

    initial begin
        clock = 0;
        reset = 0;
        record = 0;
        play = 0;
        record_mem_sel = 0;
        play_mem_sel = 0;
        timer_done = 0;
        deserializer_done = 0;
        serializer_done = 0;
        
        //pause in idle state
        #100
        
        //record to mem block 1
        record_mem_sel = 0;
        record = 1;
        #10
        record = 0;
        #50
        deserializer_done = 1;
        #10
        deserializer_done = 0;
        timer_done = 1;
        #10
        timer_done = 0;
        record_mem_sel = 0;
        #100
        
        //record to mem block 2
        record_mem_sel = 1;
        record = 1;
        #10
        record = 0;
        #50
        deserializer_done = 1;
        #10
        deserializer_done = 0;
        timer_done = 1;
        #10
        timer_done = 0;
        record_mem_sel = 0;
        #100
        
        //play from mem block 1
        play_mem_sel = 0;
        play = 1;
        #10
        play = 0;
        #50
        serializer_done = 1;
        #10
        serializer_done = 0;
        timer_done = 1;
        #10
        timer_done = 0;
        play_mem_sel = 0;
        #100
        
        //play from mem block 1
        play_mem_sel = 1;
        play = 1;
        #10
        play = 0;
        #50
        serializer_done = 1;
        #10
        serializer_done = 0;
        timer_done = 1;
        #10
        timer_done = 0;
        play_mem_sel = 0;
    end
endmodule