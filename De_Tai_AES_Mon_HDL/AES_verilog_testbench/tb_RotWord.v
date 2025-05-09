module tb_RotWord;

  // Inputs
  reg [7:0] S0_in, S1_in, S2_in, S3_in;

  // Outputs
  wire [7:0] D0_out, D1_out, D2_out, D3_out;

  // Instantiate the Unit Under Test (UUT)
  RotWord uut (
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
    // Test case 1
    S0_in = 8'h67;
    S1_in = 8'h20;
    S2_in = 8'h46;
    S3_in = 8'h75;

    #10;

    // Display
    $display("Input:   %h %h %h %h", S0_in, S1_in, S2_in, S3_in);
    $display("Rotated: %h %h %h %h", D0_out, D1_out, D2_out, D3_out);

    // Check result
    if ({D0_out, D1_out, D2_out, D3_out} !== 32'h20467567) begin
      $display("FAIL");
    end else begin
      $display("PASS");
    end

    $finish;
  end

endmodule
