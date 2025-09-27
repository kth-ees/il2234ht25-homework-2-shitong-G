`timescale 1ns/1ps

module LFSR_6bit_tb;
    // Inputs
    logic clk;
    logic rst_n;
    logic sel;
    logic [5:0] parallel_in;
    
    // Outputs
    logic [5:0] parallel_out;
    
    LFSR_6bit uut (
        .clk(clk),
        .rst_n(rst_n),
        .sel(sel),
        .parallel_in(parallel_in),
        .parallel_out(parallel_out)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        rst_n = 0;
        sel = 0;
        parallel_in = 6'b0;
        
        #20;
        rst_n = 1;
        #10;
        
        $display("=== LFSR 6-bit Testbench ===");
        $display("Time | sel | parallel_in | parallel_out");
        $display("-----|-----|-------------|-------------");
        
        // Test 1: Parallel load mode (sel=0)
        $display("Test 1: Parallel Load Mode");
        sel = 0;
        parallel_in = 6'b101010;
        #10;
        $display("%4t |  %1b  |    %06b   |    %06b", $time, sel, parallel_in, parallel_out);
        
        parallel_in = 6'b111000;
        #10;
        $display("%4t |  %1b  |    %06b   |    %06b", $time, sel, parallel_in, parallel_out);
        
        // Test 2: LFSR mode (sel=1)
        $display("\nTest 2: LFSR Shift Mode");
        sel = 1;
        parallel_in = 6'b000000;  // Input ignored in LFSR mode
        
        // Run LFSR for 10 cycles to see the sequence
        repeat(10) begin
            #10;
            $display("%4t |  %1b  |    %06b   |    %06b", $time, sel, parallel_in, parallel_out);
        end
        
        // Test 3: Switch back to parallel mode
        $display("\nTest 3: Switch back to Parallel Mode");
        sel = 0;
        parallel_in = 6'b010101;
        #10;
        $display("%4t |  %1b  |    %06b   |    %06b", $time, sel, parallel_in, parallel_out);
        
        // Test 4: Switch to LFSR mode with new seed
        $display("\nTest 4: LFSR with new seed");
        sel = 1;
        #50;  // Run for 5 cycles
        $display("%4t |  %1b  |    %06b   |    %06b", $time, sel, parallel_in, parallel_out);
        
        // Test 5: Reset test
        $display("\nTest 5: Reset Test");
        rst_n = 0;
        #10;
        $display("%4t |  %1b  |    %06b   |    %06b (after reset)", $time, sel, parallel_in, parallel_out);
        
        rst_n = 1;
        #10;
        
        $display("\n=== Simulation Complete ===");
        $finish;
    end
    
    // Simple monitor
    initial begin
        $monitor("At time %0t: parallel_out = %06b", $time, parallel_out);
    end
endmodule