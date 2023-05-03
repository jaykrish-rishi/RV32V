`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2023 09:34:42
// Design Name: 
// Module Name: 2_1mux
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


module mux_2_1(
    input [31:0] a , b ,
    input select ,
    output reg [31:0] ans
    );
    
    always@(*)
    ans = (select)? b : a ;
    
endmodule
