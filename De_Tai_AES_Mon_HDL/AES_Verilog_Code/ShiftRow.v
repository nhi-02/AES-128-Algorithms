// Có 2 lỗi trong file này (đã sửa lại logic)

module ShiftRow(
	input wire [31:0] S0_in,
	input wire [31:0] S1_in,
	input wire [31:0] S2_in,
	input wire [31:0] S3_in,
	output wire [31:0] D0_out,
	output wire [31:0] D1_out,
	output wire [31:0] D2_out,
	output wire [31:0] D3_out	
	);
	wire [7:0] bytes [0:15];
	wire [7:0] temp [0:15];
	
	assign bytes[0] = S0_in[31:24];
	assign bytes[1] = S0_in[23:16];
	assign bytes[2] = S0_in[15:8];
	assign bytes[3] = S0_in[7:0];

	assign bytes[4] = S1_in[31:24];
	assign bytes[5] = S1_in[23:16];
	assign bytes[6] = S1_in[15:8];
	assign bytes[7] = S1_in[7:0];

	assign bytes[8] = S2_in[31:24];
	assign bytes[9] = S2_in[23:16];
	assign bytes[10] = S2_in[15:8];
	assign bytes[11] = S2_in[7:0];

	assign bytes[12] = S3_in[31:24];
	assign bytes[13] = S3_in[23:16];
	assign bytes[14] = S3_in[15:8];
	assign bytes[15] = S3_in[7:0];
	
	
    assign temp[0]  = bytes[0];  // State[0][0]
    assign temp[1]  = bytes[4];  // State[0][1]
    assign temp[2]  = bytes[8];  // State[0][2]
    assign temp[3]  = bytes[12]; // State[0][3]

    assign temp[4]  = bytes[5];  // State[1][1]
    assign temp[5]  = bytes[9];  // State[1][2]
    assign temp[6]  = bytes[13]; // State[1][3]
    assign temp[7]  = bytes[1];  // State[1][0]

    assign temp[8]  = bytes[10]; // State[2][2]
    assign temp[9]  = bytes[14]; // State[2][3]
    assign temp[10] = bytes[2];  // State[2][0]
    assign temp[11] = bytes[6];  // State[2][1]

    assign temp[12] = bytes[15]; // State[3][3]
    assign temp[13] = bytes[3];  // State[3][0]
    assign temp[14] = bytes[7];  // State[3][1]
    assign temp[15] = bytes[11]; // State[3][2]

    assign D0_out = {temp[0], temp[4], temp[8], temp[12]};
    assign D1_out = {temp[1], temp[5], temp[9], temp[13]};
    assign D2_out = {temp[2], temp[6], temp[10], temp[14]};
    assign D3_out = {temp[3], temp[7], temp[11], temp[15]};
	
endmodule
