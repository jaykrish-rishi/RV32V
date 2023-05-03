`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2023 12:11:45
// Design Name: 
// Module Name: alu
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

/*
ALU Control lines | Function
-----------------------------
        0000    Bitwise-AND
        0001    Bitwise-OR
        0010	Add (A+B)
        0011	Subtract (A-B)
        0100	Set on less than
        0101    Shift left logical
        0110    Shift right logical
        0111    Bitwise-XOR
*/

module alu(
    input [31:0] in1,in2, 
    input[3:0] alu_control,
    output reg [31:0] alu_result,
    output reg zero_flag
    );
    
    always@(*)
    begin
    
    case(alu_control)
    
    4'd0 : alu_result = in1 & in2 ;
    4'd1 : alu_result = in1 | in2 ;
    4'd2 : alu_result = in1 + in2 ;
    4'd3 : alu_result = in1 - in2 ;
    4'd4 : alu_result = ( in1 < in2 )? 32'b1 : 32'b0 ;
    4'd3 : alu_result = in1 << in2 ;
    4'd5 : alu_result = in1 >> in2 ;
    4'd7 : alu_result = in1 ^ in2 ;
    
    endcase
    
    // Setting Zero_flag if ALU_result is zero
    if (alu_result == 0)
        zero_flag = 1'b1;
    else
        zero_flag = 1'b0;
    
    
    end
endmodule
