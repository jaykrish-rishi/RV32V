`timescale 1ns / 1ps
// status = not done 

module imm_con(
    input [11:0] in_cons ,
    output reg [31:0] out_cons
    );
    
    always@(*)
    out_cons = (in_cons[11] == 1'b1) ? {20'hFFFFF , in_cons} : {20'd0 , in_cons} ;
    
endmodule
