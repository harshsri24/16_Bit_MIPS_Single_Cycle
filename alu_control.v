module alu_control(alu_op,alu_fn,alu_cntrl);

	input [1:0] alu_op;
	input [3:0] alu_fn;
	output reg [2:0] alu_cntrl;

	wire [5:0] alu_cntrl_in;

	assign alu_cntrl_in={alu_op,alu_fn};

	always@(alu_cntrl_in)
	begin
	casex(alu_cntrl_in)
		6'b01xxxx: alu_cntrl=3'b001;
		6'b10xxxx: alu_cntrl=3'b100;
		6'b11xxxx: alu_cntrl=3'b000;
		6'b000000: alu_cntrl=3'b000;
		6'b000001: alu_cntrl=3'b001;
		6'b000010: alu_cntrl=3'b010;
		6'b000011: alu_cntrl=3'b011;
		6'b000100: alu_cntrl=3'b100;
	default: alu_cntrl=3'b000;
	endcase
	end

endmodule