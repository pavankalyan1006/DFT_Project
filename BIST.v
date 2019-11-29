module BIST (signature, lfsrclk1, lfsrclk2, misrclk, rst, enb, fault_control, fault_places, cutinp);

    output [4:0] signature;
    output [9:0] cutinp;
    input lfsrclk1, lfsrclk2, misrclk, enb, rst;
    input [50:0] fault_control, fault_places;
    
    wire [9:0] inp, multout;
    wire [4:0] misrinput, sig;
    reg flag;
    reg [3:0] state;
    reg [4:0] misrinp;

    initial begin
        flag <= 1'b1;
        state <= 1'b0;
    end

    assign misrinput = misrinp;
    assign cutinp = inp;

    // LFSR
    bit_5_lfsr L1(.out(inp[4:0]), .enb(enb), .clk(lfsrclk1), .reset(rst));
    bit_5_lfsr L2(.out(inp[9:5]), .enb(enb), .clk(lfsrclk2), .reset(rst));

    // CUT
    mult5 C1(.A(inp[4:0]), .B(inp[9:5]), .out(multout), .fault_control(fault_control), .fault_places(fault_places));

    //MISR
    bit_10to5_misr M1(.out(signature), .M(misrinput), .enb(enb), .clk(misrclk), .reset(rst));

    always @(posedge misrclk)
    begin
        if (flag==1'b1)
	    begin
	        misrinp <= multout[9:5];
	        flag <= 1'b0;
        end
        else
        begin
            misrinp <= multout[4:0];
           flag <= 1'b1;
        end
    end

endmodule
