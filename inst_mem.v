`timescale 1ns / 1ps
// status = done 
    // pp_enable status = added  

/*

*/
module inst_mem(
    input [31:0] PC,
    input reset, stg_en, clk ,
    output reg [31:0] Instruction_Code
    );
    
    reg [31:0] memory [0:99] ;
    
    always@(posedge clk )
    begin
    
    if(reset==1'b1)
    begin
    memory[0] = 32'h00000000 ;
     // R - type
    memory[1] = 32'h002081b3 ;
    memory[2] = 32'h0020B1B3 ;
    memory[3] = 32'h002091B3 ;
    memory[4] = 32'h0020A1B3 ;
    memory[5] = 32'h0020B1B3 ;
    memory[6] = 32'h0020C1B3 ;
    memory[7] = 32'h0020D1B3 ;
    memory[8] = 32'h0020E1B3 ;
    memory[9] = 32'h0020F1B3 ;
    
    //memory[10] = 32'h00000262 ; // vlen = 4 
    memory[10] = 32'h00000562 ; // vlen = 10 
    memory[11] = 32'h00418298 ;
    memory[12] = 32'h00419298 ;
    memory[13] = 32'h0041A298 ;
    memory[14] = 32'h0041B298 ;
    memory[15] = 32'h0041C298 ;
    memory[16] = 32'h0041D298 ;
    memory[17] = 32'h0041E298 ;
    memory[18] = 32'h0041F298 ;
   
    
    /* I - type  
    memory[1] = 32'h04D08193;
    memory[2] = 32'h04D0B193;
    memory[3] = 32'h04D0A193;
    memory[4] = 32'h04D0F193;
    memory[5] = 32'h04D0C193;
    memory[6] = 32'h04D0D193;
    memory[7] = 32'h04D0E193;

    memory[8] = 32'h00000262 ; // vlen = 4
    memory[9] = 32'h04D182A7;
    memory[10] = 32'h04D192A7;
    memory[11] = 32'h04D1A2A7;
    memory[12] = 32'h04D1C2A7;
    memory[13] = 32'h04D1D2A7;
    memory[14] = 32'h04D1E2A7;
    memory[15] = 32'h04D1F2A7;  */
    
    /* load type
    memory[1] = 32'h0000A283; // scalar load  
   
    memory[2] = 32'h00000262 ; // vlen = 4
    memory[3] = 32'h0000A2AC ; */
    
     /*store type
    memory[1] = 32'h0020A023; // scalar store 
   
    memory[2] = 32'h00000262 ; // vlen = 4
    memory[3] = 32'h0020A043 ;  */  
    
    /* branch type
    memory[0] = 32'hdddddddd ;
    memory[1] = 32'hcccccccc ;
    memory[2] = 32'hbbbbbbbb ;
    memory[3] = 32'haaaaaaaa ;
    memory[4] = 32'hFE208F63 ; // be
    memory[4] = 32'hFE209F63 ; // bne  */
    
    
   /* // scalar - performance
    memory[1] = 32'h00027213 ;
    memory[2] = 32'h0002F293 ;
    memory[3] = 32'h06428293 ;
    memory[4] = 32'h00022083 ;
    memory[5] = 32'h06422103 ;
    memory[6] = 32'h002081B3 ;
    memory[7] = 32'h0C322423 ;
    memory[8] = 32'h00120213 ;
    memory[9] = 32'hFE521D63 ; */
    
   /* // vector - performance
    memory[1] = 32'h00027213 ;
    memory[2] = 32'h0002F293 ;
    memory[3] = 32'h06428293 ;
    memory[4] = 32'h00000562 ;
    memory[5] = 32'h000220AC ;
    memory[6] = 32'h0642212C ;
    memory[7] = 32'h00208198 ;
    memory[8] = 32'h0C322443 ;
    memory[9] = 32'h00A20213 ;
    memory[10] = 32'hFE521D63 ;  */
    
    end


    
    Instruction_Code = (stg_en == 1 )? memory[PC] : 32'hzzzzzzzz ;
    
    end
endmodule
