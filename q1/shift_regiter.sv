module shift_register #(parameter N=4) 
                      (input logic clk, 
                       input logic rst_n, 
                       input logic serial_parallel, 
                       input logic load_enable, 
                       input logic serial_in, 
                       input logic [N-1:0] parallel_in, 
                       output logic [N-1:0] parallel_out, 
                       output logic serial_out); 
 
//complete here 
    logic [N-1:0] regs;
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            regs <= 'b0;
        else begin
            if(load_enable) begin
                if(serial_parallel)
                    regs <= parallel_in;
                else
                    regs <= {regs[N-2:0], serial_in};
            end
        end
        
    end
    assign parallel_out = regs;
    assign serial_out = regs[N-1];
endmodule 