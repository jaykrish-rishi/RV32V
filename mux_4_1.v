`timescale 1ns / 1ps

module mux_4_1(
    input [31:0] a , b , c , d ,
    input [1:0] select ,
    output reg [31:0] res
);
    always@(*)
    begin
    
    res = (select[1])?  ((select[0])?  d : c ) : ((select[0])?  b : a );
    
    end 
    
endmodule