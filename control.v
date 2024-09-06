 module control( input[2:0] opcode,  
                           input reset,  
                           output reg[1:0] alu_op,  
                           output reg reg_dst,mem_to_reg,jump,branch,mem_read,mem_write,alu_src,reg_write                      
   );  
 always @(*)  
 begin  
      if(reset == 1'b1) begin  
                reg_dst = 1'b0;  
                mem_to_reg = 1'b0;  
                alu_op = 2'b00;  
                jump = 1'b0;  
                branch = 1'b0;  
                mem_read = 1'b0;  
                mem_write = 1'b0;  
                alu_src = 1'b0;  
                reg_write = 1'b0;  
                //sign_or_zero = 1'b1;  
      end  
      else begin  
      case(opcode)   
      3'b000: begin // add  
                reg_dst = 1'b1;  
                mem_to_reg = 1'b0;  
                alu_op = 2'b00;  
                jump = 1'b0;  
                branch = 1'b0;  
                mem_read = 1'b0;  
                mem_write = 1'b0;  
                alu_src = 1'b0;  
                reg_write = 1'b1;  
                //sign_or_zero = 1'b1;  
                end  
      3'b001: begin // sli  
                reg_dst = 1'b0;  
                mem_to_reg = 1'b0;  
                alu_op = 2'b10;  
                jump = 1'b0;  
                branch = 1'b0;  
                mem_read = 1'b0;  
                mem_write = 1'b0;  
                alu_src = 1'b1;  
                reg_write = 1'b1;  
                //sign_or_zero = 1'b0;  
                end  
      3'b010: begin // j  
                reg_dst = 1'b0;  
                mem_to_reg = 1'b0;  
                alu_op = 2'b00;  
                jump = 1'b1;  
                branch = 1'b0;  
                mem_read = 1'b0;  
                mem_write = 1'b0;  
                alu_src = 1'b0;  
                reg_write = 1'b0;  
                //sign_or_zero = 1'b1;  
                end  
      3'b011: begin // jal  
                reg_dst = 1'b0;  
                mem_to_reg = 1'b0;  
                alu_op = 2'b00;  
                jump = 1'b1;  
                branch = 1'b0;  
                mem_read = 1'b0;  
                mem_write = 1'b0;  
                alu_src = 1'b0;  
                reg_write = 1'b1;  
                //sign_or_zero = 1'b1;  
                end  
      3'b100: begin // lw  
                reg_dst = 1'b0;  
                mem_to_reg = 1'b1;  
                alu_op = 2'b11;  
                jump = 1'b0;  
                branch = 1'b0;  
                mem_read = 1'b1;  
                mem_write = 1'b0;  
                alu_src = 1'b1;  
                reg_write = 1'b1;  
                //sign_or_zero = 1'b1;  
                end  
      3'b101: begin // sw  
                reg_dst = 1'b0;  
                mem_to_reg = 1'b0;  
                alu_op = 2'b11;  
                jump = 1'b0;  
                branch = 1'b0;  
                mem_read = 1'b0;  
                mem_write = 1'b1;  
                alu_src = 1'b1;  
                reg_write = 1'b0;  
                //sign_or_zero = 1'b1;  
                end  
      3'b110: begin // beq  
                reg_dst = 1'b0;  
                mem_to_reg = 1'b0;  
                alu_op = 2'b01;  
                jump = 1'b0;  
                branch = 1'b1;  
                mem_read = 1'b0;  
                mem_write = 1'b0;  
                alu_src = 1'b0;  
                reg_write = 1'b0;  
                //sign_or_zero = 1'b1;  
                end  
      3'b111: begin // addi  
                reg_dst = 1'b0;  
                mem_to_reg = 1'b0;  
                alu_op = 2'b11;  
                jump = 1'b0;  
                branch = 1'b0;  
                mem_read = 1'b0;  
                mem_write = 1'b0;  
                alu_src = 1'b1;  
                reg_write = 1'b1;  
                //sign_or_zero = 1'b1;  
                end  
      default: begin  
                reg_dst = 1'b1;  
                mem_to_reg = 1'b0;  
                alu_op = 2'b00;  
                jump = 1'b0;  
                branch = 1'b0;  
                mem_read = 1'b0;  
                mem_write = 1'b0;  
                alu_src = 1'b0;  
                reg_write = 1'b1;  
                //sign_or_zero = 1'b1;  
                end  
      endcase  
      end  
 end  
 endmodule 