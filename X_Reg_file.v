`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2023 11:59:34
// Design Name: 
// Module Name: X_Reg_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module X_Reg_file(
    input clk , reg_w , 
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
    end
    
    always@(posedge clk)
    begin
        if(reg_w == 1'b1)
            reg_mem[rd] <= w_data ;
        
        rs1_data <= reg_mem[rs1];
        rs2_data <= reg_mem[rs2];
    end
endmodule
