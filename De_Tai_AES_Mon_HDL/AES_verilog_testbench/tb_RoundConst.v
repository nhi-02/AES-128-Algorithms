module tb_RoundConst;
  reg [3:0] round;
  reg [7:0] S0_in, S1_in, S2_in, S3_in;
  wire [7:0] D0_out, D1_out, D2_out, D3_out;

  // Instantiate DUT
  RoundConst uut (
    .round(round),
    .S0_in(S0_in), .S1_in(S1_in), .S2_in(S2_in), .S3_in(S3_in),
    .D0_out(D0_out), .D1_out(D1_out), .D2_out(D2_out), .D3_out(D3_out)
  );

  initial begin
    // Test vector
    round  = 4'h1;
    S0_in  = 8'hb7;
    S1_in  = 8'h5a;
    S2_in  = 8'h9d;
    S3_in  = 8'h85;
    
    #10;
    // Display input and output
    $display("Test 1:");
    $display("Input:   %h %h %h %h", S0_in, S1_in, S2_in, S3_in);
    $display("Rotated: %h %h %h %h", D0_out, D1_out, D2_out, D3_out);
    // Check results
    if (D0_out == 8'hb6 && D1_out == 8'h5a && D2_out == 8'h9d && D3_out == 8'h85)
      $display("PASS");
    else
      $display("FAIL");

    $finish;
  end
endmodule
