module bit_10to5_misr (out, M, enb, clk, reset);

    output reg[4:0] out;
    input enb, clk, reset;
    input [4:0] M;

    wire feed_back1, feed_back2, feed_back3, feed_back4, feed_back5;


    assign feed_back1 = (out[4] ^ M[0]);
    assign feed_back2 = (out[0] ^ M[1]);
    assign feed_back3 = (out[1] ^ out[4] ^ M[2]);
    assign feed_back4 = (out[2] ^ out[4] ^ M[3]);
    assign feed_back5 = (out[3] ^ M[4]);

    always @(posedge clk or negedge reset) 
    begin
        if (!reset)
        begin
            out <= 5'b0 ;
        end
        else if (enb)
        begin
            out <= {feed_back5,feed_back4,feed_back3,feed_back2,feed_back1};
        end
   
    end
     
endmodule

