module mips(clk,rst,pc_out,alu_out);

	input clk,rst;
	output [15:0] pc_out,alu_out;

	reg[15:0] pc_current;  
 	wire signed[15:0] pc_next,pc2;  
 	wire [15:0] instr;  
 	wire[1:0] alu_op; 
 	wire reg_dst,mem_to_reg;
 	wire jump,branch,mem_read,mem_write,alu_src,reg_write;  
 	wire     [2:0]     reg_write_dest;  
 	wire     [15:0] reg_write_data;  
 	wire     [2:0]     reg_read_addr1;  
 	wire     [15:0] reg_read_data1;  
 	wire     [2:0]     reg_read_addr2;  
 	wire     [15:0] reg_read_data2;  
 	wire [15:0] sign_ext_im,read_data2;  
 	wire JRControl;  
 	wire [2:0] ALU_Control;  
 	wire [15:0] ALU_out;  
 	wire zero_flag;  
 	wire signed [15:0] im_shift_1, PC_j, PC_4beq,PC_4beqj,PC_jr;  
 	wire beq_control;  
 	wire [14:0] jump_shift_1;  
	wire [15:0]mem_read_data;  
 	//wire [15:0] no_sign_ext;  
 	//wire sign_or_zero;  

 		always @ (posedge clk or posedge rst)
 		begin
 			if(rst) 
 				pc_current<=16'd0;
 			else
 				pc_current<=pc_next;
 		end

 		assign pc2=pc_current+16'd2;

 		instruction_mem i1 (.pc(pc_current),.instruction(instr));

 		assign jump_shift_1={instr[12:0],1'b0};


 		control c1 (.opcode(instr[15:13]),.reset(rst),.reg_dst(reg_dst),.mem_to_reg(mem_to_reg),.alu_op(alu_op),  
                           .jump(jump),.branch(branch),.mem_read(mem_read),.mem_write(mem_write),.alu_src(alu_src),.reg_write(reg_write)); 

        assign reg_write_dest=(reg_dst==1'b1)?instr[6:4]:instr[9:7];

        assign reg_read_addr1=instr[12:10];
        assign reg_read_addr2=instr[9:7];

        reg_file r1 (.clk(clk),.rst(rst),.reg_read1(reg_read_addr1),.reg_read2(reg_read_addr2),.write_reg(reg_write_dest),.write_en(reg_write),.reg_read_data1(reg_read_data1),.reg_read_data2(reg_read_data2),.write_data(reg_write_data));

        assign sign_ext_im={{9{instr[6]}},instr[6:0]};

        jr_control j1 (.alu_op(alu_op),.func(instr[3:0]),.out(JRControl));
        alu_control a1 (.alu_op(alu_op),.alu_fn(instr[3:0]),.alu_cntrl(ALU_Control));

        assign read_data2=(alu_src==1'b1)?sign_ext_im:reg_read_data2;

        alu a2 (.a(reg_read_data1),.b(read_data2),.alu_cntrl(ALU_Control),.result(ALU_out),.zero(zero_flag));

        assign im_shift_1 = {sign_ext_im[14:0],1'b0};

        assign beq_control=branch & zero_flag;
        assign PC_4beq=(beq_control==1'b1)?(pc2+im_shift_1):pc2;

        assign PC_j={pc2[15:14],jump_shift_1};
        assign PC_4beqj=(jump==1'b1)?PC_j:PC_4beq;

        assign PC_jr = reg_read_data1;    
 		assign pc_next = (JRControl==1'b1) ? PC_jr : PC_4beqj; 

 		data_memory d1 (.mem_access_addr(ALU_out),.mem_write_data(reg_read_data2),.clk(clk),.mem_read(mem_read),.mem_write_en(mem_write),.mem_read_data(mem_read_data));

 		assign reg_write_data=(mem_to_reg==1'b1)?mem_read_data:ALU_out;

 		assign pc_out=pc_current;
 		assign alu_out=ALU_out;

endmodule