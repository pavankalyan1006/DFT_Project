module bit_5_lfsr (out, enb, clk, reset);

    output reg [4:0] out;
    input enb, clk, reset;

    wire feed_back, feed_back2, feed_back3, temp;


    // assign feed_back = (out[4] ^ out[1]);

    always @(posedge clk or negedge reset)
    begin
        if (!reset)
        begin
            out <= 5'b00001 ;
        end
        else if (enb)
        begin
            out <= {out[3],out[2], out[1], out[0], out[4]};
        end
    end
endmodule


