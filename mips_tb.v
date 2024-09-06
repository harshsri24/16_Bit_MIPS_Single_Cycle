 module tb_mips16;  
      // Inputs  
      reg clk;  
      reg reset;  
      // Outputs  
      wire [15:0] pc_out;  
      wire [15:0] alu_result;//,reg3,reg4;  
      // Instantiate the Unit Under Test (UUT)  
      mips uut (  
           .clk(clk),   
           .rst(reset),   
           .pc_out(pc_out),   
           .alu_out(alu_result)  
           //.reg3(reg3),  
          // .reg4(reg4)  
      );  

      initial  #200 $finish;
      initial begin  
           clk = 0;  
           forever #5 clk = ~clk;  
      end  
      initial begin  
      $dumpfile("dumpfile1.vcd");
      $dumpvars(0,tb_mips16);
           // Initialize Inputs  
             
           reset = 1;  
           // Wait 100 ns for global reset to finish  
           #100;  
     reset = 0;  
           // Add stimulus here  
      end  
      initial
      $monitor(alu_result);
 endmodule  