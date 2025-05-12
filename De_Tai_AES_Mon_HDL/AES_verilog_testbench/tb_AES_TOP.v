`timescale 1ns / 1ps

module tb_AES_TOP;

    // Inputs
    reg CLK;
    reg RST;
    reg start_in;
    reg [31:0] plaintext0_in;
    reg [31:0] plaintext1_in;
    reg [31:0] plaintext2_in;
    reg [31:0] plaintext3_in;
    reg [31:0] key0_in;
    reg [31:0] key1_in;
    reg [31:0] key2_in;
    reg [31:0] key3_in;

    // Outputs
    wire [31:0] ciphertext0_out;
    wire [31:0] ciphertext1_out;
    wire [31:0] ciphertext2_out;
    wire [31:0] ciphertext3_out;
    wire        valid_out;

    // Internal signals for capturing final result correctly
    reg [31:0] final_ciphertext0;
    reg [31:0] final_ciphertext1;
    reg [31:0] final_ciphertext2;
    reg [31:0] final_ciphertext3;
    reg final_valid;

    // Instantiate the Unit Under Test (UUT)
    AES_TOP uut (
        .CLK(CLK),
        .RST(RST),
        .start_in(start_in),
        .plaintext0_in(plaintext0_in),
        .plaintext1_in(plaintext1_in),
        .plaintext2_in(plaintext2_in),
        .plaintext3_in(plaintext3_in),
        .key0_in(key0_in),
        .key1_in(key1_in),
        .key2_in(key2_in),
        .key3_in(key3_in),
        .ciphertext0_out(ciphertext0_out),
        .ciphertext1_out(ciphertext1_out),
        .ciphertext2_out(ciphertext2_out),
        .ciphertext3_out(ciphertext3_out),
        .valid_out(valid_out)
    );

    // Clock generator
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK; // T?o xung clock 10ns
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        RST = 1; // B?t ??u ? tr?ng thái reset
        start_in = 0;
        plaintext0_in = 32'h54776f20;
        plaintext1_in = 32'h4f6e6520;
        plaintext2_in = 32'h4e696e65;
        plaintext3_in = 32'h2054776f;
        key0_in       = 32'h54686174;
        key1_in       = 32'h73206d79;
        key2_in       = 32'h204b756e;
        key3_in       = 32'h67204675;
        final_valid   = 0;

        // Apply Reset
        #10 RST = 0; //  reset (active low)
        #20 RST = 1; //  reset

        // Start the operation
        #10 start_in = 1;
        #10 start_in = 0; 

        wait (final_valid == 1);
        #20; 

        $display("####################################");
        $display("Final Captured Ciphertext:");
        $display("  Ciphertext0: %h", final_ciphertext0);
        $display("  Ciphertext1: %h", final_ciphertext1);
        $display("  Ciphertext2: %h", final_ciphertext2);
        $display("  Ciphertext3: %h", final_ciphertext3);
        $display("  Valid: %b", final_valid);
        $display("####################################");

        $finish;
    end

    // *** Phân tích log ***
    always @(posedge CLK) begin
        if (RST == 1 && uut.state_w != uut.keyexpansion.IDLE) begin
            $display("------------------------------------");
            $display("Time: %0t ns", $time);

            if (uut.cipher.state_in == uut.cipher.ROUND0) begin
                $display("--- Processing Round 0 (Initial AddRoundKey) ---");
                $display("  Input State (Plaintext): %h %h %h %h",
                         plaintext0_in, plaintext1_in, plaintext2_in, plaintext3_in);
                $display("  Round Key (Key 0):       %h %h %h %h",
                         uut.cipher.key0_in, uut.cipher.key1_in, uut.cipher.key2_in, uut.cipher.key3_in);
                // kết quả của AddRoundKey vòng 0
                $display("  Output State (Combinational): %h %h %h %h",
                         uut.cipher.D0_ARK_round0_w, uut.cipher.D1_ARK_round0_w,
                         uut.cipher.D2_ARK_round0_w, uut.cipher.D3_ARK_round0_w);
            end else if (uut.cipher.state_in == uut.cipher.ROUND1to9) begin
                $display("--- Processing Round %0d ---", uut.keyexpansion.round_r); // hiển thị round và keyexpansion
                $display("  Input State (From Prev Round): %h %h %h %h",
                         uut.cipher.Ciphertext0_r, uut.cipher.Ciphertext1_r,
                         uut.cipher.Ciphertext2_r, uut.cipher.Ciphertext3_r);
                $display("  Round Key (Key %0d):         %h %h %h %h", uut.keyexpansion.round_r,
                         uut.cipher.key0_in, uut.cipher.key1_in, uut.cipher.key2_in, uut.cipher.key3_in);
                // kết quả của SB->SR->MC->ARK vòng 1-9
                $display("  Output State (Combinational):  %h %h %h %h",
                         uut.cipher.D0_ARK_round1to9_w, uut.cipher.D1_ARK_round1to9_w,
                         uut.cipher.D2_ARK_round1to9_w, uut.cipher.D3_ARK_round1to9_w);
            end else if (uut.cipher.state_in == uut.cipher.ROUND10) begin
                 $display("--- Processing Round 10 (Final SB->SR->ARK) ---");
                 $display("  Input State (From Prev Round): %h %h %h %h",
                         uut.cipher.Ciphertext0_r, uut.cipher.Ciphertext1_r,
                         uut.cipher.Ciphertext2_r, uut.cipher.Ciphertext3_r);
                 $display("  Round Key (Key 10):        %h %h %h %h",
                         uut.cipher.key0_in, uut.cipher.key1_in, uut.cipher.key2_in, uut.cipher.key3_in);
                 // kết quả của SB->SR->ARK vòng 10
                 $display("  Output State (Combinational):  %h %h %h %h",
                         uut.cipher.D0_ARK_round10_w, uut.cipher.D1_ARK_round10_w,
                         uut.cipher.D2_ARK_round10_w, uut.cipher.D3_ARK_round10_w);
            end

            //$display("  Next Internal State (Registered): %h %h %h %h",
                     uut.cipher.Ciphertext0_r, uut.cipher.Ciphertext1_r,
                     uut.cipher.Ciphertext2_r, uut.cipher.Ciphertext3_r);
            $display("  Current Valid Out: %b", valid_out);

            // bắt giá trị cuối cùng của ciphertext
            if (valid_out == 1 && final_valid == 0) begin
                $display(">>> Capturing final result at time %0t ns <<<", $time);
                final_ciphertext0 = uut.cipher.Ciphertext0_r; 
                final_ciphertext1 = uut.cipher.Ciphertext1_r;
                final_ciphertext2 = uut.cipher.Ciphertext2_r;
                final_ciphertext3 = uut.cipher.Ciphertext3_r;
                final_valid = 1;
            end
        end
    end

endmodule