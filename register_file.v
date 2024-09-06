module reg_file(clk,rst,reg_read1,reg_read2,write_reg,write_data,write_en,reg_read_data1,reg_read_data2);

	input [2:0] reg_read1,reg_read2,write_reg;
	input [15:0] write_data;
	input clk,rst,write_en;
	output [15:0] reg_read_data1,reg_read_data2;

	reg [15:0] regf[7:0];
	integer i;

	always@(posedge clk or posedge rst)
	begin 
		if(rst)
		begin
			for(i=0;i<8;i=i+1)
			begin
				regf[i]<=16'd0;
			end
		end
		else
		begin
			if(write_en)
			begin
				regf[write_reg]<=write_data;
			end
		end
	end

	assign reg_read_data1=(reg_read1==3'd0)?16'd0:regf[reg_read1];
	assign reg_read_data2=(reg_read2==3'd0)?16'd0:regf[reg_read2];

endmodule