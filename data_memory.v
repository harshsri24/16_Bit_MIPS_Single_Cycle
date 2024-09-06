module data_memory(mem_access_addr,mem_write_data,clk,mem_read,mem_write_en,mem_read_data);

	input [15:0] mem_access_addr, mem_write_data;
	input clk,mem_write_en,mem_read;
	output [15:0] mem_read_data;

	reg [15:0] mem[255:0];
	integer i;
	wire [7:0] mem_addr = mem_access_addr[8:1];

	initial begin
		for(i=0;i<256;i=i+1)
		begin
			mem[i] <= 16'd0;
		end 
	end

	always @ (posedge clk)
	begin
		if(mem_write_en)
		mem[mem_addr] <= mem_write_data;
	end

	assign mem_read_data = (mem_read==1'b1)?mem[mem_addr]:16'd0;

endmodule