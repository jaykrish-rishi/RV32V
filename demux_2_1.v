`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2023 14:09:45
// Design Name: 
// Module Name: demux_2_1
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


module demux_31_in(
    input [31:0] res ,
    input select ,
    output reg [31:0] a , b
    );
    
    always@(*)
    begin
    
    if( select == 1'b1)
        b = res ;
     else
        a = res ;  
    
    end

endmodule
