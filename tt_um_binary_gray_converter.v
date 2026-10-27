
module tt_um_binary_gray_converter (
    input  wire [7:0] ui_in,
    input  wire [7:0] uio_in,
    output wire [7:0] uo_out,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe
);

    wire [7:0] binary_to_gray;
    wire [7:0] gray_to_binary;

    // Binary to Gray
    assign binary_to_gray[7] = ui_in[7];

    genvar i;
    generate
        for (i = 0; i < 7; i = i + 1) begin : GEN_B2G
            assign binary_to_gray[i] = ui_in[i+1] ^ ui_in[i];
        end
    endgenerate

    // Gray to Binary
    assign gray_to_binary[7] = ui_in[7];

    generate
        for (i = 0; i < 7; i = i + 1) begin : GEN_G2B
            assign gray_to_binary[i] =
                gray_to_binary[i+1] ^ ui_in[i];
        end
    endgenerate

    // uio_in[0] selects conversion direction
    assign uo_out = (uio_in[0] == 1'b0)
                  ? binary_to_gray
                  : gray_to_binary;

    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

endmodule

