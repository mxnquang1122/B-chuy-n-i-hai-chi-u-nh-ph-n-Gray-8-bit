
`timescale 1ns/1ps

module tb_binary_gray_converter;

    reg  [7:0] ui_in;
    reg  [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    integer i;
    reg [7:0] expected_gray;
    reg [7:0] recovered_binary;

    tt_um_binary_gray_converter dut (
        .ui_in(ui_in),
        .uio_in(uio_in),
        .uo_out(uo_out),
        .ena(1'b1),
        .clk(1'b0),
        .rst_n(1'b1),
        .uio_out(uio_out),
        .uio_oe(uio_oe)
    );

    initial begin
        // Test binary -> Gray -> binary for all 256 values
        uio_in = 8'b0;

        for (i = 0; i < 256; i = i + 1) begin
            ui_in = i;
            uio_in[0] = 1'b0;
            #1;
            expected_gray = ui_in ^ (ui_in >> 1);

            if (uo_out !== expected_gray) begin
                $display("FAIL B2G: input=%h output=%h expected=%h",
                         ui_in, uo_out, expected_gray);
                $fatal;
            end

            ui_in = expected_gray;
            uio_in[0] = 1'b1;
            #1;
            recovered_binary = uo_out;

            if (recovered_binary !== i[7:0]) begin
                $display("FAIL G2B: input=%h output=%h expected=%h",
                         expected_gray, recovered_binary, i[7:0]);
                $fatal;
            end
        end

        $display("PASS: all 256 values passed round-trip test");
        $finish;
    end

endmodule

