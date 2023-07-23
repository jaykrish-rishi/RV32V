`timescale 1ns / 1ps

module control_unit(
    input [6:0] funct7,
    input [6:0] opcode,
    input [2:0] funct3,
    output pc_select,
    output reg [3:0] alu_control,
    output reg [2:0] alu_mux_sel,
    output reg reg_write_X,
    output reg reg_write_V,
    output reg data_write ,
    output reg v_len_write ,
    output reg demux_select ,
    output reg mux1_select , // to choose between alu result or data mem to be written back to any reg files
    output reg mux2_select , // to choose between xreg or vec reg data to be written to data mem
    output reg vlsu_write
    );
    
    // funct3 code (bits 14:12):
    parameter add = 3'b000;
    parameter sub = 3'b011;
    parameter xorl = 3'b100;
    parameter andl = 3'b111;
    parameter orl = 3'b110;
    parameter sle = 3'b010;
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
    parameter V_config = 7'd98;
    parameter V_I_load = 7'd44;
    
    always @(*)begin
    
    alu_control = 4'dz ; data_write = 1'b0 ;
    reg_write_X = 1'b0 ; reg_write_V = 1'b0 ; vlsu_write = 1'b0 ;
    case(opcode)
    
    X_R:begin
            alu_control = for_alu_control( funct3 );
            alu_mux_sel = 3'b000;
            
            reg_write_X = 1'b1 ;
            reg_write_V = 1'b0 ;
            v_len_write = 1'b0 ;
            mux1_select = 1'b0 ; // alu_res = 0 & data_mem = 1
            mux2_select = 1'b0 ; // reg = 0 & vec = 1 
            demux_select = 1'b0 ; // reg = 0 & vec = 1
        end
        
    X_I_load:begin
            v_len_write = 1'b0;
            reg_write_X = 1'b1 ;
            reg_write_V = 1'b0 ;
            alu_control = 4'b0010;
            alu_mux_sel = 3'd1;
            
            mux1_select = 1'b1 ; // alu_res = 0 & data_mem = 1
            mux2_select = 1'b0 ; // reg = 0 & vec = 1 
            demux_select = 1'b0 ; // reg = 0 & vec = 1
             end
        
            
    X_J :begin
           v_len_write = 1'b0;
            mux1_select = 1'b0 ; // alu_res = 0 & data_mem = 1
            mux2_select = 1'b0 ; // reg = 0 & vec = 1 
            demux_select = 1'b0 ; // reg = 0 & vec = 1
         end
    
    X_I :begin
            alu_control = for_alu_control( funct3 );
            alu_mux_sel = 3'd1;

            reg_write_X = 1'b1 ;
            reg_write_V = 1'b0 ;            
            v_len_write = 1'b0;
            mux1_select = 1'b0 ; // alu_res = 0 & data_mem = 1
            mux2_select = 1'b0 ; // reg = 0 & vec = 1 
            demux_select = 1'b0 ; // reg = 0 & vec = 1
         end
     
    X_I_Jump :begin
                v_len_write = 1'b0;
                mux1_select = 1'b0 ; // alu_res = 0 & data_mem = 1
                mux2_select = 1'b0 ; // reg = 0 & vec = 1 
                demux_select = 1'b0 ; // reg = 0 & vec = 1
         end
    
    X_B :begin
            v_len_write = 1'b0;
            alu_mux_sel = 3'd0;
            alu_control=4'b0100;
            
            mux1_select = 1'b0 ; // alu_res = 0 & data_mem = 1
            mux2_select = 1'b0 ; // reg = 0 & vec = 1 
            demux_select = 1'b0 ; // reg = 0 & vec = 1
         end
    
    X_S :begin
            v_len_write = 1'b0;
            reg_write_X = 1'b0 ;
            reg_write_V = 1'b0 ;
            data_write = 1'b1 ;
            
            alu_control = 4'b0010;
            alu_mux_sel = 3'd1;
            
          //  mux1_select = 1'b0 ; // alu_res = 0 & data_mem = 1
            mux2_select = 1'b0 ; // reg = 0 & vec = 1 
            demux_select = 1'b0 ; // reg = 0 & vec = 1
         end
         
    V_R :begin
            alu_control = for_alu_control(funct3 );
            alu_mux_sel = 3'd2;

            reg_write_X = 1'b0 ;
            reg_write_V = 1'b1 ;            
            v_len_write = 1'b0;
            
            mux1_select = 1'b0 ; // alu_res = 0 & data_mem = 1
            mux2_select = 1'b0 ; // reg = 0 & vec = 1 
            demux_select = 1'b1 ; // reg = 0 & vec = 1
         end
    
    V_I :begin
            alu_control = for_alu_control( funct3 );
            alu_mux_sel = 3'd3;
            
            reg_write_X = 1'b0 ;
            reg_write_V = 1'b1 ;
            v_len_write = 1'b0;
            mux1_select = 1'b0 ; // alu_res = 0 & data_mem = 1
            mux2_select = 1'b1 ; // reg = 0 & vec = 1 
            demux_select = 1'b1 ; // reg = 0 & vec = 1
         end
    
    V_S :begin
            reg_write_X = 1'b0 ;
            reg_write_V = 1'b0 ;
           v_len_write = 1'b0;
           data_write = 1'b1 ;
           
           alu_control = 4'b0010;
            alu_mux_sel = 3'd7;
            
           mux1_select = 1'b0 ; // alu_res = 0 & data_mem = 1
            mux2_select = 1'b1 ; // reg = 0 & vec = 1 
            demux_select = 1'b0 ; // reg = 0 & vec = 1
         end
    
    V_I_load :begin
            v_len_write = 1'b0;
            reg_write_X = 1'b0 ;
            reg_write_V = 1'b1 ;
            alu_control = 4'b0010;
            alu_mux_sel = 3'd7;
            
            mux1_select = 1'b1 ; // alu_res = 0 & data_mem = 1
            mux2_select = 1'b1 ; // reg = 0 & vec = 1 
            demux_select = 1'b1 ; // reg = 0 & vec = 1
            
         end
         
    V_config : begin
                reg_write_X = 1'b0 ;
                reg_write_V = 1'b0 ;
                
                v_len_write = 1'b1;
                vlsu_write = 1'b1 ;
                
                mux1_select = 1'b0 ; // alu_res = 0 & data_mem = 1
                mux2_select = 1'b0 ; // reg = 0 & vec = 1 
                demux_select = 1'b0 ; // reg = 0 & vec = 1
               end
    
    endcase
    end
    
    function [3:0] for_alu_control;
    input [2:0] f3 ;
    
        case(f3)
        add : for_alu_control = 4'b0010;
        sub : for_alu_control = 4'b0011 ;
        andl : for_alu_control=4'b0000;
        orl : for_alu_control=4'b0001;
        xorl : for_alu_control=4'b0111;
        sle : for_alu_control=4'b0100;
        sll : for_alu_control=4'b0101;
        srl : for_alu_control=4'b0110;
        endcase
        
    endfunction 
    
endmodule

