`timescale 1ns / 1ps


module alu_in_mux(
    input stg_en ,
    input [31:0] r_a , r_b , v_a , v_b , imm , ls_addr ,
    input [2:0] select,
    output reg [31:0] ans1 , ans2
    );
    
    always@(*)
    begin
    
    if (stg_en == 1'b1)
    begin
    ans1 = (select[1]) ? v_a : r_a ;
    
    ans2 = (select[0]) ? ((select[2])? ls_addr : imm )  : ((select[1]) ?  v_b : r_b) ;
    end
    
    end

endmodule
