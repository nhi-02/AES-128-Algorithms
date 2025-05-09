// File này có 2 lỗi

module RotWord(
	input wire [7:0] S0_in,
	input wire [7:0] S1_in,
	input wire [7:0] S2_in,
	input wire [7:0] S3_in,
	output wire [7:0] D0_out,
	output wire [7:0] D1_out,
	output wire [7:0] D2_out,
	output wire [7:0] D3_out	
	);
	
	assign D0_out = S0_in;
	assign D1_out = S2_in;
	assign D2_out = S3_in;
	assign D3_out = S1_in;
	
endmodule