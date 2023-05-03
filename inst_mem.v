`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2023 13:57:27
// Design Name: 
// Module Name: inst_mem
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


module inst_mem(
    input [31:0] PC,
    input reset,
    output [31:0] Instruction_Code
    );
    
    reg [31:0] memory [0:99] ;
    assign Instruction_Code = memory[PC];
    
    always@(reset)
    begin
    
    if(reset==1'b1)
    begin
    memory[0] = 32'h09 ;
    memory[1] = 32'h0 ;
    end
    
    end
endmodule
