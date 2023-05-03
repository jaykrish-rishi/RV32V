`timescale 1ns / 1ps

module data_mem(
    input clk,
    // address input, shared by read and write port
    input [31:0] mem_addr,
    // write port
    input [31:0] mem_write_data,
    input mem_write_en,
    input mem_read,
    // read port
    output [31:0] mem_read_data
    );
    
    reg [31:0] memory [0:120];
    
    initial
    begin
        memory[0] = 32'h0;
        memory[1] = 32'h1;
        memory[2] = 32'h2;
        memory[3] = 32'h3;
        memory[4] = 32'h4;
        memory[5] = 32'h5;        
    end
    
    always @(posedge clk) 
    begin
    if (mem_write_en)
        memory[mem_addr] <= mem_write_data;
    end

    assign mem_read_data = (mem_read==1'b1) ? memory[mem_addr]: 32'dZ;
    
endmodule