
module MatrixMul #(parameter SIZE) (x, y, out, clk, rst, done);

    input [31:0] x [0:SIZE - 1][0:SIZE - 1];
    input [31:0] y [0:SIZE - 1][0:SIZE - 1];
    input clk, rst;
    output logic [31:0] out [0:SIZE - 1][0:SIZE - 1];
    output logic done;

    integer i, j;

    always_ff @( posedge clk ) begin
        if(rst) begin
            done <= 1'b0;
            for(i = 0; i < SIZE; i = i + 1) begin
                for(j = 0; j < SIZE; j = j + 1) begin
                    out[i][j] <= 32'h0000_0000;
                end
            end
        end
        else if(!rst && !done) begin
            for(i = 0; i < SIZE; i = i + 1) begin
                for(j = 0; j < SIZE; j = j + 1) begin
                    out[i][j] <= out[i][j] + (x[i][j]*y[j][i]);
                end
            end
        end
    end

endmodule



