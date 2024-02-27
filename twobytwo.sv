
module twobytwo(x, y, out, clk, rst, done);

    input [31:0] x [0:1][0:1];
    input [31:0] y [0:1][0:1];
    input clk, rst;
    output logic [31:0] out [0:1][0:1];
    output logic done;

    always_ff @(posedge clk) begin : Matrix_mul
        if(rst) begin
            done <= 1'b0;
        end
        else if(!rst && !done) begin
            out[0][0] <= (x[0][0]*y[0][0]) + (x[0][1]*y[1][0]);
            out[0][1] <= (x[0][0]*y[0][1]) + (x[0][1]*y[1][1]);
            out[1][0] <= (x[1][0]*y[0][0]) + (x[1][0]*y[1][0]);
            out[1][1] <= (x[1][0]*y[0][1]) + (x[1][0]*y[1][1]);
            done <= 1'b1;
        end
    end

endmodule



