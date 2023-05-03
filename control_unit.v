`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2023 19:09:00
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [6:0] funct7,
    input [6:0] opcode,
    input [2:0] funct3,
    output pc_select,
    output reg [3:0] alu_control,
    output reg reg_write_X,
    output reg reg_write_V,
    output reg data_write
    );
    
    // funct3 code (bits 14:12):
    parameter add_sub = 3'b000;
    parameter xorl = 3'b100;
    parameter andl = 3'b111;
    parameter orl = 3'b110;
    parameter slt = 3'b010;
    parameter srl = 3'b101;
    parameter sll = 3'b001;

    parameter lw = 3'b010;
    parameter sw = 3'b010;
    
    parameter beq = 3'b000; 
    parameter bne = 3'b001;
    
    //instruction format of Integer opcode
    parameter X_R = 7'd51;
    parameter X_I_load = 7'd3;
    parameter X_J = 7'd111;
    parameter X_I = 7'd19;
    parameter X_I_Jump = 7'd103;
    parameter X_B = 7'd99;
    parameter X_S = 7'd35;
    
    //instruction format for Vector opcode
    parameter V_R = 7'd24;
    parameter V_I = 7'd39;
    parameter V_S = 7'd67;
    parameter V_I_load = 7'd44;
    
    always @( funct7 or funct3 or opcode )
    begin
    
    case(opcode)
    
    X_R:begin
    
        case(funct3)
        add_sub : alu_control = (funct7 == 7'b000000)? 4'b0010 : 4'b0011 ;
        andl : alu_control=4'b0000;
        orl : alu_control=4'b0001;
        xorl : alu_control=4'b0111;
        slt : alu_control=4'b0100;
        sll : alu_control=4'b0101;
        srl : alu_control=4'b0110;
        endcase
        
        end
        
    X_I:begin
        
        case(funct3)
        
        endcase
        
        end        
        
    
    endcase
    end
    
endmodule
