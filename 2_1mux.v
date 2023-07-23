`timescale 1ns / 1ps


module mux_2_1(
    input [31:0] a , b ,
    input select ,
    output reg [31:0] ans
    );
    
    always@(*)
    ans = (select)? b : a ;
    
endmodule
