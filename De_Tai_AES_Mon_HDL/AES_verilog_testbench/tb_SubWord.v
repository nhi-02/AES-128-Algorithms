module SubWord_tb;

  // Inputs
  reg [7:0] S0_in, S1_in, S2_in, S3_in;

  // Outputs
  wire [7:0] D0_out, D1_out, D2_out, D3_out;

  // Instantiate the Unit Under Test (UUT)
  SubWord uut (
    .S0_in(S0_in),
    .S1_in(S1_in),
    .S2_in(S2_in),
    .S3_in(S3_in),
    .D0_out(D0_out),
    .D1_out(D1_out),
    .D2_out(D2_out),
    .D3_out(D3_out)
  );

  initial begin
    // Test case
    S0_in = 8'h20;
    S1_in = 8'h46;
    S2_in = 8'h75;
    S3_in = 8'h67;

    #10;

    // Display inputs and outputs
    $display("Input:   %h %h %h %h", S0_in, S1_in, S2_in, S3_in);
    $display("S-boxed: %h %h %h %h", D0_out, D1_out, D2_out, D3_out);

    // Optional check
    if ({D0_out, D1_out, D2_out, D3_out} !== 32'hb75a9d85)
      $display("FAIL");
    else
      $display("PASS");

    $finish;
  end

endmodule
