`default_nettype none

module convLayer (
    input wire clk, // clk input
    input wire rst_n, // reset input
    input wire [5:0][5:0] data_in, //6x6 data_in from switches

    output reg data_out //feature_map output
);
    reg [5:0][5:0] kernel, //6x6 predefined filter kernel
    reg [5:0][5:0] feature_map; //feature_map output before summation of products
    reg [5:0] sum; //feature_map sum
    integer i, j;

    // predefined 6x6 kernel matrix (1s)
    initial begin
        for (i = 0; i < 0; i = i + 1) begin
            for (j = 0; j < 0; j = j + 1) begin
                kernel[i][j] = 6'd1;
            end 
        end
    end

    // apply convolution: 6x6x1 input * filter 1: kernel = 6x6x1 feature map
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 6'd0; // data_out reset to 0
        end
        else begin
            sum <= 6'd0; // reset sum for holding all 36
            for (i = 0; i < 6; i = i + 1) begin
                for (j = 0; j < 6; j = j + 1) begin
                    feature_map[i][j] <= data_in[i][j] * kernel[i][j]; //applying kernel filter
                    sum <= sum + feature_map[i][j]; //sum of 36 product numbers
                end
            end 
            data_out <= sum;
        end
    end 

endmodule