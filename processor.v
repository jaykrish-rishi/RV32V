`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2023 21:17:38
// Design Name: 
// Module Name: processor
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

`define opcode instr[6:0]
`define sr1 instr[19:15]
`define sr2 instr[24:20]
`define rd instr[11:7]
`define funct3 instr[14:12]
`define funct7 instr[31:25]
`define imm_J instr[31:12]
`define imm_I instr[31:20]

module processor(
    input clock,
    input reset,
    output zero
    );
    
    wire [11:0] imm_S ;
    wire [31:0] instr ;
    
    assign imm_S = {instr[31:25],instr[11:7]};
    
    
endmodule
