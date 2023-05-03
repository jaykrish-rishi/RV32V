`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2023 21:21:59
// Design Name: 
// Module Name: processor_tb
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


module processor_tb();
reg clock ;
reg reset ;
wire zero ;

processor ins(clock,reset,zero);

initial
begin
    reset = 1'b1 ;
    # 40 reset = 1'b0 ;
end

initial
begin
    clock = 1'b0 ;
    forever clock = ~ clock ;
end

initial
#600 $finish;
endmodule
