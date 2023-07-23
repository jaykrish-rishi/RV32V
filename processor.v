`timescale 1ns / 1ps

// status = add wires  

`define opcode instr[6:0]
`define sr1 instr[19:15]
`define sr2 instr[24:20]
`define rd instr[11:7]
`define funct3 instr[14:12]
`define funct7 instr[31:25]
`define imm_J instr[31:12]
`define imm_I instr[31:20]

module processor(
    input wire clock,
    input wire reset,
    output zero
    );
    
    wire [11:0] imm_S ;
    wire [31:0] instr , pc , alu_ina_wire , alu_inb_wire , alu_res_w , imm_out_wire ,
                rs1_d_w , rs2_d_w, vs1_d_w, vs2_d_w , rwd_w , vwd_w , mux_out , 
                demux_a_out , demux_b_out , data_mem_out , data_write_d_w , ls_addr_w ;
                
    wire [3:0] alu_cnt_wire , ele_ind_wire ;
    wire [2:0] alu_mux_s_w ;
    wire [1:0] pc_s_w ;
    wire r_reg_w_wire , v_reg_w_wire , csr_w , demux_select_w , mux1_select_w , mux2_select_w , v_st_reg_w , data_write_w ;
    
    reg [2:0] state , n_state ;
    reg stage_0 , stage_1 , stage_2 , stage_3 , activate_reg , v_st_reg ;
    reg [31:0] n_pc , n_pc_ans ;
    
    assign imm_S = ( instr[6:0] == 32'd35 | instr[6:0] == 32'd99 )? {instr[32:25],instr[11:7]} : instr[31:20] ;
    
    //assign imm_S = ( instr[6:0] == 32'd99 )? {instr[32:25],instr[11:7]} : instr[31:20] ;
    
    //mux_4_1 br_j_mux( .a() , .b() , .c() , .d() , .select(pc_s_w) , .res(pc) );
    
    inst_mem inst_file( .PC(n_pc) , .reset(reset) , .clk(clock), .stg_en(stage_0) , .Instruction_Code(instr) );
    
    control_unit CU( .funct7(instr[31:25]) , .opcode(instr[6:0]) , .funct3(instr[14:12]) , .pc_select(pc_s_w) , 
                     .alu_mux_sel(alu_mux_s_w) , .alu_control(alu_cnt_wire) , .reg_write_X(r_reg_w_wire) , 
                     .reg_write_V(v_reg_w_wire) , .data_write(data_write_w) , .demux_select(demux_select_w) , .mux1_select(mux1_select_w) ,
                      .mux2_select(mux2_select_w) , .vlsu_write(csr_w) );
    
    mux_2_1 m1( .a(alu_res_w) , .b(data_mem_out) , .select(mux1_select_w) , .ans(mux_out) );
    mux_2_1 m2( .a(rs2_d_w) , .b(vs2_d_w) , .select(mux2_select_w) , .ans(data_write_d_w) );
    //mux_2_1 m3( .a() , .b() , .select() , .ans() );
    //mux_2_1 m4( .a() , .b() , .select() , .ans() );
    
    demux_2_1 d1( .res(mux_out) , .select(demux_select_w) , .a(demux_a_out) , .b(demux_b_out) );
    
    X_Reg_file r_file( .clk(clock) , .reg_w(r_reg_w_wire) , .stg_en(stage_2) , .rd(instr[11:7]) , .rs1(instr[19:15]) , 
                       .rs2(instr[24:20]) , .w_data(demux_a_out) , .rs1_data(rs1_d_w) , .rs2_data(rs2_d_w) );
    
    V_Reg_files v_file( .clk(clock) , .v_write(v_reg_w_wire) , .stg_en(stage_2) , .v_d(instr[11:7]) , .vs1(instr[19:15]) ,
                        .vs2(instr[24:20]) , .ele_index(ele_ind_wire) , .vw_data(demux_b_out) , .vs1_data(vs1_d_w) , .vs2_data(vs2_d_w) );
    
    VLSU vlsu_unit( .reg_w(csr_w) , .stg_en(stage_2) , .clk(clock) , .activate(activate_reg) , .value(instr[10:7]) , .imm_const(imm_out_wire) ,
                    .status(v_st_reg_w) , .ele_indx(ele_ind_wire) , .ls_addr(ls_addr_w) );
    
    imm_con imm_block( .in_cons(imm_S) , .out_cons(imm_out_wire) );
    
    alu_in_mux ALU_input_mux(  .stg_en(stage_2) , .r_a(rs1_d_w) , .r_b(rs2_d_w) , .v_a(vs1_d_w) , .v_b(vs2_d_w) , .imm(imm_out_wire) ,
                              .ls_addr(ls_addr_w) , .select(alu_mux_s_w) , .ans1(alu_ina_wire) , .ans2(alu_inb_wire) );
    // done ,
    
    alu alu_ins(  .stg_en(stage_2) , .in1(alu_ina_wire) , .in2(alu_inb_wire) , .alu_control(alu_cnt_wire) , .alu_result(alu_res_w) , .zero_flag(zero) );
    //done ,
    
    data_mem data_file( .clk(clock) , .stg_en(stage_2) , .mem_addr(alu_res_w) , .mem_write_data(data_write_d_w) ,
                        .mem_write_en(data_write_w) , .mem_data(data_mem_out) );
    
    initial
    begin
    state = 3'd0;
    n_state = 3'd0;
    n_pc = 32'd0;
    n_pc_ans = 32'd0 ;
    
    { stage_0 , stage_1 , stage_2 , stage_3 } = 4'd0 ;

    end 
    
    always@(posedge clock)
    begin
     //{ stage_0 , stage_1 , stage_2 , stage_3 } = 4'd0 ;
     //stage_0 = 1'b0 ;
     //stage_2 = 1'b0 ;
     //stage_3 = 1'b0 ;
     
     //assign imm_S = ( instr[6:0] == 32'd35 | instr[6:0] == 32'd99 )? {instr[32:25],instr[11:7]} : instr[31:20] ;
     
     state = n_state ;
     activate_reg = 1'b0 ;
     v_st_reg = v_st_reg_w ;
    case(state)
      3'd0 : begin 
             n_state = 3'd1;
             stage_0 = 1'b1 ; 
             n_pc =  n_pc_ans + 1'b1 ;
             end
      3'd1 : begin
             n_state = 3'd2;
             stage_1 = 1'b1 ;
      
             end 
      3'd2 : begin 
             stage_2 = 1'b1 ;
             activate_reg = 1'b1 ;
             if ( instr[6:0] == 7'd24 | instr[6:0] == 7'd39 | instr[6:0] == 7'd67 | instr[6:0] == 7'd44 )
             begin
             if(v_st_reg == 1'b0 )
                n_state = 3'd2;
             else
                n_state = 3'd3;       
             end
             else
                n_state = 3'd3;
             end
      
      3'd3 : begin
             stage_3 = 1'b1 ;
             if(instr[6:0] == 7'd99 ) 
             begin 
             if( (instr[14:12] == 3'd0 && alu_res_w == 32'h1)|(instr[14:12] == 3'd1 && alu_res_w == 32'h0) ) 
               n_pc_ans = n_pc + imm_out_wire ;
             else
               n_pc_ans = n_pc ;
             end  
             else
             n_pc_ans = n_pc ; 
             
             n_state = 3'd0;
          end    
    endcase
    end
    
endmodule
