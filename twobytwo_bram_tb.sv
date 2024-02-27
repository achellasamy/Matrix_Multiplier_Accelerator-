class twobytwo_bram_class;

    rand logic [32:0] x;

    constraint range  { 0 <= x <= 20; }
                       
    function logic [63:0] matrix_data();
        return x;
    endfunction

endclass

module twobytwo_bram_tb();

    logic clk;
    logic rst;
    logic [12:0] BRAM_addr;
    logic BRAM_clk;
    logic [31:0] BRAM_din;
    logic [31:0] BRAM_dout;
    logic BRAM_en;
    logic BRAM_we;

    logic [12:0]BRAM_PORTB_0_addr;
    logic BRAM_PORTB_0_clk;
    logic [31:0]BRAM_PORTB_0_din;
    logic [31:0]BRAM_PORTB_0_dout;
    logic BRAM_PORTB_0_en;
    logic [0:0]BRAM_PORTB_0_we;

    twobytwo_bram_class cls = new();

    twobytwo_bram twobytwo_bram_i (.clk(clk),
                                   .rst(rst),
                                   .BRAM_addr(BRAM_PORTB_0_addr),
                                   .BRAM_clk(BRAM_PORTB_0_clk),
                                   .BRAM_din(BRAM_PORTB_0_din),
                                   .BRAM_dout(BRAM_PORTB_0_dout),
                                   .BRAM_we(BRAM_PORTB_0_we),
                                   .BRAM_en(BRAM_PORTB_0_en));
                         
    twobytwo_BRAM_test_wrapper twobytwo_BRAM_test_wrapper_i (.BRAM_PORTA_0_addr(BRAM_addr),
                                                             .BRAM_PORTA_0_clk(clk),
                                                             .BRAM_PORTA_0_din(BRAM_din),
                                                             .BRAM_PORTA_0_dout(BRAM_dout),
                                                             .BRAM_PORTA_0_en(BRAM_en),
                                                             .BRAM_PORTA_0_we(BRAM_we),
                                                             .BRAM_PORTB_0_addr(BRAM_PORTB_0_addr),
                                                             .BRAM_PORTB_0_clk(BRAM_PORTB_0_clk),
                                                             .BRAM_PORTB_0_din(BRAM_PORTB_0_din),
                                                             .BRAM_PORTB_0_dout(BRAM_PORTB_0_dout),
                                                             .BRAM_PORTB_0_en(BRAM_PORTB_0_en),
                                                             .BRAM_PORTB_0_we(BRAM_PORTB_0_we));

    always begin
        clk = ~clk;
        BRAM_clk = clk;
        #5;
    end

    initial begin
        $display("-----Begin twobytwo_BRAM Test-----");
        rst = 1'b1;
        clk = 1'b0;
        BRAM_en = 1'b1;

        #20;
        fillBRAM(0);
        #20;
        fillBRAM(4);
        #5;
        rst = 1'b0;
        #700;

        rst = 1'b1;
        #20;
        fillBRAM(0);
        #20;
        fillBRAM(4);
        #5;
        rst = 1'b0;
        #700;

        
        $finish;
    end

    task fillBRAM(input [32:0] start_addr);
        BRAM_we = 1'b1;
        BRAM_addr = start_addr;
        #20
        for(int i = 0; i < 4; i++) begin
            cls.randomize();
            BRAM_din = cls.matrix_data();
            BRAM_addr = BRAM_addr + 1;
            #20;
        end
        BRAM_we = 1'b0;
    endtask

endmodule

