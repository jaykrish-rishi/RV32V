`timescale 1ns / 1ps

module X_Reg_file(
    input clk , reg_w , stg_en ,
    input [4:0] rd , rs1 , rs2 ,
    input [31:0] w_data ,
    output reg [31:0] rs1_data , rs2_data
    );
    
    reg [31:0] reg_mem [0:31];
    integer i ;
    
    initial
    begin
        rs1_data = 32'd0;
        rs2_data = 32'd0;
        for( i=0; i<32 ; i=i+1)
            reg_mem[i] = 32'd0;
            
        reg_mem [1] = 32'h000000AA;
       reg_mem [2] = 32'h000000AA;
       // reg_mem [2] = 32'h000000AC;
    end
    
    
    always@(posedge clk)
    begin
    if (stg_en == 1 )
    begin
        rs1_data <= reg_mem[rs1];
        rs2_data <= reg_mem[rs2];
        
        if(reg_w == 1'b1)
            reg_mem[rd] <= w_data ;
    end
    end
endmodule
