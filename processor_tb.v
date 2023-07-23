`timescale 1ns / 1ps

module processor_tb();
reg clock ;
reg reset ;
wire zero ;

processor ins(.clock(clock),.reset(reset),.zero(zero));

initial
begin
    reset = 1'b1 ;
    #40 reset = 1'b0 ;
end

initial
begin
#4000 $finish;
end

initial
begin
    clock = 1'b1 ;
    forever #20 clock = ~ clock ;
end


endmodule
