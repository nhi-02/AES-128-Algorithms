`timescale 1ns / 1ps

module tb_ShiftRow;

    // Inputs
    reg [31:0] tb_S0_in;
    reg [31:0] tb_S1_in;
    reg [31:0] tb_S2_in;
    reg [31:0] tb_S3_in;

    // Outputs
    wire [31:0] tb_D0_out;
    wire [31:0] tb_D1_out;
    wire [31:0] tb_D2_out;
    wire [31:0] tb_D3_out;

    // Instantiate the Unit Under Test (UUT)
    ShiftRow uut (
        .S0_in(tb_S0_in),
        .S1_in(tb_S1_in),
        .S2_in(tb_S2_in),
        .S3_in(tb_S3_in),
        .D0_out(tb_D0_out),
        .D1_out(tb_D1_out),
        .D2_out(tb_D2_out),
        .D3_out(tb_D3_out)
    );

    initial begin
        // Initialize Inputs
        $display("Starting ShiftRow testbench...");

        // Input Matrix:
        // ( 63 EB 9F A0 )
        // ( C0 2F 93 92 )
        // ( AB 30 AF C7 )
        // ( 20 CB 2B A2 )

        // Module inputs (columns):
        tb_S0_in = 32'h63C0AB20; // Col 0: {63, C0, AB, 20}
        tb_S1_in = 32'hEB2F30CB; // Col 1: {EB, 2F, 30, CB}
        tb_S2_in = 32'h9F93AF2B; // Col 2: {9F, 93, AF, 2B}
        tb_S3_in = 32'hA092C7A2; // Col 3: {A0, 92, C7, A2}

        #10;

        // Display inputs and outputs
        $display("Inputs to ShiftRow module:");
        $display("S0_in = %h", tb_S0_in);
        $display("S1_in = %h", tb_S1_in);
        $display("S2_in = %h", tb_S2_in);
        $display("S3_in = %h", tb_S3_in);
        $display("____");
        $display("Outputs from UUT:");
        $display("D0_out = %h", tb_D0_out);
        $display("D1_out = %h", tb_D1_out);
        $display("D2_out = %h", tb_D2_out);
        $display("D3_out = %h", tb_D3_out);
        $display("____");

        $finish;
    end

endmodule