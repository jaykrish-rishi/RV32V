`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2023 09:38:46
// Design Name: 
// Module Name: mux_4_1
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


module mux_4_1(
    input [31:0] a , b , c , d ,
    input [1:0] select,
    output reg [31:0] ans
    );
    
    always@(*)
    ans = (select[1]) ? ((select[0])? d : c) : ((select[0])? b : a) ;
    
endmodule
