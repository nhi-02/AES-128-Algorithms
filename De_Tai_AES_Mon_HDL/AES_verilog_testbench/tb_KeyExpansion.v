module tb_KeyExpansion;
  reg CLK, RST, start_in;
  reg [31:0] key0_in, key1_in, key2_in, key3_in;
  wire [31:0] key0_out, key1_out, key2_out, key3_out;
  wire [1:0] state_out;

  KeyExpansion uut (
    .CLK(CLK), .RST(RST), .start_in(start_in),
    .key0_in(key0_in), .key1_in(key1_in), .key2_in(key2_in), .key3_in(key3_in),
    .key0_out(key0_out), .key1_out(key1_out), .key2_out(key2_out), .key3_out(key3_out),
    .state_out(state_out)
  );

  // Clock generator
  always #5 CLK = ~CLK;

  initial begin
    // Initial signals
    CLK = 0; RST = 0; start_in = 0;
    key0_in = 32'h54686174;
    key1_in = 32'h73206d79;
    key2_in = 32'h204b756e;
    key3_in = 32'h67204675;

    // Reset pulse
    #10 RST = 1;
    #10 start_in = 1;
    #10 start_in = 0;

    // Run for a few cycles
    $display("Masterkey: %h %h %h %h", key0_in, key1_in, key2_in, key3_in);
    repeat (15) begin
      #10;
      $display("Key out %h : %h %h %h %h | State: %h",uut.round_r, key0_out, key1_out, key2_out, key3_out, state_out);
    end
    #5 start_in = 1;  // Time now is 145ns
    #10 start_in = 0;
    
    repeat (5) begin
      #10;
      $display("Key out %h : %h %h %h %h | State: %h", uut.round_r, key0_out, key1_out, key2_out, key3_out, state_out);
    end
    
    $finish;
  end
endmodule
