`timescale 1ns / 1ps

// status = done 

module data_mem(
    input clk , stg_en ,
    // address input, shared by read and write port
    input [31:0] mem_addr,
    // write port
    input [31:0] mem_write_data,
    input mem_write_en,
    // read port
    output reg [31:0] mem_data
    );
    
    reg [31:0] memory [0:120];
    integer i = 0 ;
    
    initial
    begin
        /*memory[0] = 32'h0;
        memory[1] = 32'h1;
        memory[2] = 32'h2;
        memory[3] = 32'h3;
        memory[4] = 32'h4;
        memory[5] = 32'h5;*/
        
        for( i=32'd0 ; i<32'd100 ; i=i+32'd1 )
          memory[i] = 32'd10; 
        
        for( i=32'd100 ; i<32'd200 ; i=i+32'd1 )
          memory[i] = 32'd15;
          
        for( i=32'd200 ; i<32'd300 ; i=i+32'd1 )
          memory[i] = 32'd15;
    end
    
    always @(posedge clk) 
    begin
    if(stg_en == 1)begin
    if (mem_write_en)
        memory[mem_addr] <= mem_write_data;
    end
    mem_data <= memory[mem_addr];
    end
endmodule