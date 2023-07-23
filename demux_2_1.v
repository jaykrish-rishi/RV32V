`timescale 1ns / 1ps


module demux_2_1(
    input [31:0] res ,
    input select ,
    output reg [31:0] a , b
    );
    
    always@(*)
    begin
    a = (select == 1'b0)? res : 32'dZ ;
    b = (select == 1'b1)? res : 32'dZ ;   
    end

endmodule
