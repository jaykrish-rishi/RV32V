`timescale 1ns / 1ps

module VLSU(
    input reg_w , stg_en , clk , activate ,
    input [3:0] value ,
    input [31:0] imm_const ,
    output reg status ,
    output reg [3:0] ele_indx ,
    output reg [31:0] ls_addr
    );
    
reg [3:0] x , y ; 
 
 initial
 begin 
 x=4'd0;
 y = 4'd0; 
 end 
 
 always@(posedge clk ) 
 begin 
 if( stg_en == 1 )
 begin
 status <= 1'b0; 
 
 if ( y <= x & activate == 1'b1 ) 
  y <= y + 4'd1 ;
  
 if( activate == 1'b1 )
   begin
   ele_indx = (y>0)? y - 1'd1 : y ;
   ls_addr = imm_const + {28'd0,ele_indx} ;
   end
  
 if ( y == x & activate == 1'b1 )
  begin
   y <= 4'd0 ;
   status <= 1'b1; 
  end  

 if ( reg_w == 1'b1) 
 x <= value ;
 end 
 end

endmodule