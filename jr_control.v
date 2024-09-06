module jr_control(alu_op,func,out);

	input [1:0] alu_op;
	input [3:0] func;
	output out;

	assign out = ({alu_op,func}==6'b001000)?1'b1:1'b0;

endmodule