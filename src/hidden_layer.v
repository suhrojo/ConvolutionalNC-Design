`default_nettype 

module HiddenLayer(
    input wire [15:0] data_in,
    input wire [15:0] weights,
    input wire [15:0] bias,
    input wire clk,
    input wire rst_n,

    output reg [15:0] data_out
);
    reg [31:0] weighted_sum; // 32 bit register to store weighted sum

    always(@posedge) begin
        if (!rsn_n) begin //
            data_out <= 16'b0;
        end
        else begin
            weighted_sum <= (data_in * weights) + bias;
endmodule