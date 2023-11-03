`default_nettype none

module convLayer (
    input wire clk,
    input wire rst_n, 
    input wire [5:0][5:0] data_in,
    input wire [5:0][5:0] kernel,

    output reg data_out
);
    reg feature_map;

    // apply convolution: 6x6x1 input * filter 1: kernel = 1x1x1 feature map
    always @(posedge clk) begin
        if (!rst_n) begin
            data_out <= 0;
            feature_map <= 0;
        end
        else begin
            int sum = 0;
            for (int i = 0; i < 6; i++) begin
                for (int j = 0; j < 6; j++) begin
                    sum = sum + (data_in[i][j] * kernel[i][j]);
                end
            end
            feature_map <= sum;
        end
    end 

    assign data_out = feature_map


endmodule

