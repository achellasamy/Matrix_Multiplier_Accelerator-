
module twobytwo_top();

    logic clk, rst;
    logic [12:0] BRAM_addr;
    logic BRAM_clk;
    logic [31:0] BRAM_din;
    logic [31:0] BRAM_dout;
    logic BRAM_en;
    logic BRAM_we;
    
    logic rstn;
    assign rst = ~rstn;

    twobytwo_bram twobytwo_bram_i
        (
            .clk(clk),
            .rst(rst),
            .BRAM_addr(BRAM_addr),
            .BRAM_clk(BRAM_clk),
            .BRAM_din(BRAM_din),
            .BRAM_dout(BRAM_dout),
            .BRAM_en(BRAM_en),
            .BRAM_we(BRAM_we)
        );

    ZYNQ_BRAM_wrapper ZYNQ_BRAM_wrapper_i
        (
            .BRAM_PORTB_0_addr(BRAM_addr),
            .BRAM_PORTB_0_clk(BRAM_clk),
            .BRAM_PORTB_0_din(BRAM_din),
            .BRAM_PORTB_0_dout(BRAM_dout),
            .BRAM_PORTB_0_en(BRAM_en),
            .BRAM_PORTB_0_we(BRAM_we),
            .peripheral_aresetn_0(rstn),
            .pl_clk0(clk)
        );

endmodule