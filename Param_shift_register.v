module Param_shift_register #(parameter WIDTH = 8 ) 
( 
// Entradas 
input clk, reset, load, shift, done,
input [(WIDTH-1):0] data_in,
//-----------------------------------------------------------------------
// Saídas 
output reg [(WIDTH-1):0] data_out
); 
  
// Sinais Internos 
reg [(WIDTH-1):0] data;
  
/*-----------------------------------------------------------------------
                 ESTRUTURA DO REGISTRADOR DE DESLOCAMENTO: 
-----------------------------------------------------------------------
                        FSM de carregamento de dados
-----------------------------------------------------------------------*/
  
always @(posedge clk or negedge reset) 
begin 
//-----------------------------------------------------------------------
    //Operação de reset assincrono:
  if (!reset) data <= 0; 
   
        //Operação de carregamento de dados:
        else if (load) 
            data <= data_in;
    
        //Operação de deslocamento:
        else if (shift) 
            data <= data << 1;

        //Operação de envio de dados para os pinos de saída
        else if (done) 
            data_out <= data;
  
        else 
            data_out <= 0;       
end
endmodule
