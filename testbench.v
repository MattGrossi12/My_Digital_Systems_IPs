`timescale 1ns/1ps

module Param_shift_register_tb;

//Parametros de Tamanho:  
localparam WIDTH             = (8);           //Largura real de cada operando        
localparam T_WIDTH           = (WIDTH-1);           //Largura real de cada operando
    
//Sinais:
reg clk_tb, reset_tb, load_tb, shift_tb, done_tb;
reg [T_WIDTH:0] data_in_tb;
reg [T_WIDTH:0] data_out_tb;
    
  //Instanciei o DUT
  Param_shift_register Param_shift_register(
	//Entradas:
    .clk            (clk_tb),                                  
    .reset          (reset_tb),                              
    .load			(load_tb),
    .shift		    (shift_tb),
    .done			(done_tb),
    .data_in		(data_in_tb),
    .data_out		(data_out_tb)
    );

    //-----------------------------
    //Geração do clock
  	initial begin
    clk_tb = 0;
    forever #3 clk_tb = ~clk_tb; // Gera um clock com período de 10ns
  	end
  
  	//Simulação:
    initial 
    begin
    $dumpfile("Dump.vcd"); 
    $dumpvars(0);

      //State - 0: Condições iniciais de operação:
      reset_tb = 1'b0; load_tb = 1'b0; shift_tb = 1'b0; done_tb = 1'b0; data_in_tb = 8'b00000001;
	  #10;
      //State - 1: Liga o bloco:
      reset_tb = 1'b1; load_tb = 1'b0; shift_tb = 1'b0; done_tb = 1'b0;
	  #10;

      //State - 2: Carrega o banco de regs:
      reset_tb = 1'b1; load_tb = 1'b1; shift_tb = 1'b0; done_tb = 1'b0; 
	  #10;
      
      //State - 3: Testa o pino de load:
      reset_tb = 1'b1; load_tb = 1'b1; shift_tb = 1'b0; done_tb = 1'b0; 
	  #10;      
 
      //State - 4: Testa o shift:
      reset_tb = 1'b1; load_tb = 1'b0; shift_tb = 1'b1; done_tb = 1'b0; 
	  #10;    
      
      //State - 5: Testa o done:
      reset_tb = 1'b1; load_tb = 1'b0; shift_tb = 1'b0; done_tb = 1'b1; 
	  #10;

      //State - 6: reseta o banco para iniciar o teste:
      reset_tb = 1'b0; data_in_tb = 8'b00000001;
	  #10;
      $finish;
    end
endmodule