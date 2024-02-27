
module twobytwo_bram
    (
        input clk,
        input rst,
        output [12:0] BRAM_addr,
        output BRAM_clk,
        output logic [31:0] BRAM_din,
        input [31:0] BRAM_dout,
        output BRAM_en,
        output BRAM_we
    );

    logic [31:0] x [0:1][0:1];
    logic [31:0] y [0:1][0:1];
    logic [31:0] out [0:1][0:1];
    logic [31:0] address;
    logic [7:0] rowi, coli;
    logic done, readX, readY, writeOut, read, twobytwo_rst;

    twobytwo twobytwo_d (.x(x),
                         .y(y),
                         .out(out),
                         .clk(clk),
                         .rst(twobytwo_rst),
                         .done(done));

    always_ff @( posedge clk ) begin : Data_Read
        if(rst) begin
            address <= 0;
            rowi <= 0;
            coli <= 0;
            readX <= 1'b1;
            readY <= 1'b0;
            read <= 1'b1;
            writeOut <= 1'b1;
            twobytwo_rst <= 1'b1;
        end
        else if(done) begin
            if(writeOut) begin
                BRAM_din <= out[rowi][coli];
                writeOut <= 1'b0;
            end
            else begin
                if(rowi < 2) begin
                    rowi <= rowi + 1;
                end
                else if(coli < 2) begin
                    rowi <= 0;
                    coli <= coli + 1;
                end
                writeOut <= 1'b1;
                address <= address + 1;
            end
        end
        else if(!done && readX) begin
            if(!read) begin
                if(coli < 1) begin
                    coli <= coli + 1;
                    read <= 1'b1;
                    address <= address + 1;
                end
                else if(rowi < 1) begin
                    coli <= 0;
                    rowi <= rowi + 1;
                    read <= 1'b1;
                    address <= address + 1;
                end
                else if(rowi >= 1) begin
                    coli <= 0;
                    rowi <= 0;
                    readX <= 1'b0;
                    readY <= 1'b1;
                    read <= 1'b1;
                end
            end
            else begin
                x[rowi][coli] <= BRAM_dout;
                read <= 1'b0;
            end
        end
        else if(!done && readY) begin
            if(!read) begin
                if(rowi < 2) begin
                    rowi <= rowi + 1;
                    read <= 1'b1;
                    address <= address + 1;
                end
                else if(coli < 2) begin
                    rowi <= 0;
                    coli <= coli + 1;
                    read <= 1'b1;
                    address <= address + 1;
                end
                else if(coli >= 2) begin
                    rowi <= 0;
                    coli <= 0;
                    readY <= 1'b0;
                    address <= 8;
                    twobytwo_rst <= 1'b0;
                end
            end
            else begin
                y[rowi][coli] = BRAM_dout;
                read <= 1'b0;
            end
        end
    end

    assign BRAM_addr = address;
    assign BRAM_clk = clk;
    assign BRAM_en = 1'b1;
    assign BRAM_we = done;

endmodule
