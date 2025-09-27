`timescale 1ns/1ps

module shift_registe_tb;
    parameter N = 4;
    
    logic clk, rst_n, serial_parallel, load_enable, serial_in;
    logic [N-1:0] parallel_in, parallel_out;
    logic serial_out;
    
    shift_register #(.N(N)) uut (.*);
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0; rst_n = 0;
        #20; rst_n = 1;
        
        // Test serial mode
        serial_parallel = 0; load_enable = 1;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        
        // Test parallel mode
        serial_parallel = 1;
        parallel_in = 4'b1100; #10;
        
        // Test load enable
        load_enable = 0;
        parallel_in = 4'b1111; #10;
        
        #50;
        $finish;
    end
endmodule