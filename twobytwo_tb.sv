
`define MATRIX_SIZE 2;

class Matrix_Mul;

    rand logic [31:0] matrixElement;

    constraint range { 0 <= matrixElement <= 20; }

    function logic [31:0] writeInput();
        return matrixElement;
    endfunction;

endclass

module twobytwo_tb();

    logic [31:0] x [0:MATRIX_SIZE-1][0:MATRIX_SIZE-1];
    logic [31:0] y [0:MATRIX_SIZE-1][0:MATRIX_SIZE-1];
    logic [31:0] out [0:MATRIX_SIZE-1][0:MATRIX_SIZE-1];
    logic clk, rst, done;

    MatrixMul #(.SIZE(MATRIX_SIZE)) twobytwo_i (.x(x),
                                                .y(y),
                                                .out(out),
                                                .clk(clk),
                                                .rst(rst),
                                                .done(done));

    Matrix_Mul cls = new();

    always begin
        #5;
        clk = ~clk;
    end

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        for(int i = 0; i < MATRIX_SIZE; i++) begin
            for(int j = 0; j < MATRIX_SIZE; j++) begin
                cls.randomize();
                x[i][j] = cls.writeInput();
            end
        end
        for(int i = 0; i < MATRIX_SIZE; i++) begin
            for(int j = 0; j < MATRIX_SIZE; j++) begin
                cls.randomize();
                y[i][j] = cls.writeInput();
            end
        end
        #15;
        rst = 1'b0;
        #1000;
    end
    
endmodule



