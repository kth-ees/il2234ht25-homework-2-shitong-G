module registerfile (input logic clk, 
                     input logic rst_n, 
                     input logic write_en, 
                     input logic [3:0] write_addr, 
                     input logic [7:0] data_in, 
                     input logic [3:0] read_addr1, 
                     input logic [3:0] read_addr2, 
                     output logic [7:0] data_out1, 
                     output logic [7:0] data_out2 
                     ); 
    // complete here 
    logic [7:0] regs [16];
    assign data_out1 = chip_en ? regs[read_addr1] : '0;
    assign data_out2 = chip_en ? regs[read_addr2] : '0;
    
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            for(int i=0;i<16;i++) begin
                regs[i] <= 0;
            end
        end
        else if (!write_en_n && chip_en) begin
            regs[write_addr] <= data_in;
        end
        else begin
            for(int i=0;i<16;i++) begin
                regs[i] <= regs[i];
            end
        end
    end
endmodule 