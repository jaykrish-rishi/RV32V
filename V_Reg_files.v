`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2023 12:27:07
// Design Name: 
// Module Name: V_Reg_files
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


module V_Reg_files(
    input clk , vreg_w , 
    input [4:0] vd , vs1 , vs2 , ele_index ,
    input [31:0] vw_data ,
    output reg [31:0] vs1_data , vs2_data
    );
    
    reg [31:0] vreg_mem [0:31][0:9];
    integer i , j ;
    
    initial
    begin
        vs1_data = 32'd0;
        vs2_data = 32'd0;
        for( i=0; i<32 ; i=i+1)
            for( j=0 ; i<10 ; j= j+1)
                vreg_mem[i][j] = 32'd0;
    end
    
    always@(posedge clk)
    begin
        if(vreg_w == 1'b1)
            vreg_mem[vd][ele_index] <= vw_data ;
        
        vs1_data <= vreg_mem[vs1][ele_index];
        vs2_data <= vreg_mem[vs2][ele_index];
    end

endmodule
