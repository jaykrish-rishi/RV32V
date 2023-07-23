`timescale 1ns / 1ps


module V_Reg_files(
    input [31:0] vw_data ,
    input [4:0] vs1 , vs2 , v_d ,
    input [3:0] ele_index , 
    input clk , stg_en , v_write ,
    output reg [31:0] vs1_data , vs2_data
    );
    
    reg [31:0] vreg_mem [0:31][0:9] ;
    integer i , j ;
    
    initial begin
    
    for(i=0;i<32;i=i+1)begin
    for(j=0;j<10;j=j+1) begin
    vreg_mem[i][j] = 32'd0;
    end 
    end
    
    vreg_mem[3][0] = 32'd10;
    vreg_mem[3][1] = 32'd10;
    vreg_mem[3][2] = 32'd10;
    vreg_mem[3][3] = 32'd10;
    vreg_mem[3][4] = 32'd10;
    vreg_mem[3][5] = 32'd10;
    vreg_mem[3][6] = 32'd10;
    vreg_mem[3][7] = 32'd10;
    vreg_mem[3][8] = 32'd10;
    vreg_mem[3][9] = 32'd10;

    vreg_mem[4][0] = 32'd15;
    vreg_mem[4][1] = 32'd15;
    vreg_mem[4][2] = 32'd15;
    vreg_mem[4][3] = 32'd15;
    vreg_mem[4][4] = 32'd15;
    vreg_mem[4][5] = 32'd15;
    vreg_mem[4][6] = 32'd15;
    vreg_mem[4][7] = 32'd15;
    vreg_mem[4][8] = 32'd15;
    vreg_mem[4][9] = 32'd15;
    
    vreg_mem[5][0] = 32'd0;
    vreg_mem[5][1] = 32'd0;
    vreg_mem[5][2] = 32'd0;
    vreg_mem[5][3] = 32'd0;
    vreg_mem[5][4] = 32'd0;
    vreg_mem[5][5] = 32'd0;
    vreg_mem[5][6] = 32'd0;
    vreg_mem[5][7] = 32'd0;
    vreg_mem[5][8] = 32'd0;
    vreg_mem[5][9] = 32'd0;
        
    end 
    
    always @(posedge clk)
    begin
    if(stg_en ==1 )
     begin
       vs1_data <= vreg_mem[vs1][ele_index];
       vs2_data <= vreg_mem[vs2][ele_index];
    
    if(v_write == 1'b1)
    vreg_mem[v_d][ele_index] <= vw_data ;
    end
    end
    
endmodule
