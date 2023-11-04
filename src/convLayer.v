`default_nettype none

// module convLayer (
//     input wire clk, // clk input
//     input wire rst_n_n, // rst_n_n input
//     input wire [5:0][5:0] data_in, //6x6 data_in from switches

//     output reg [5:0][5:0] data_out //feature_map with summation output
// );
//     reg [5:0][5:0] kernel; //6x6 predefined filter kernel
//     reg [5:0][5:0] feature_map; //feature_map output before summation of products
//     reg [11:0] sum; //feature_map sum
//     integer i, j, a, b;

//     // predefined 6x6 kernel matrix (1s)
//     initial begin
//         for (i = 0; i < 6; i = i + 1) begin
//             for (j = 0; j < 6; j = j + 1) begin
//                 kernel[i][j] = 6'd1;
//             end 
//         end
//     end

//     // kernel [i][j]
//     //   [1 1 1]
//     //   [1 1 1]
//     //   [1 1 1]

//     // apply convolution: 6x6 matrix * 6x6 kernel of 1s = 6x6 feature map
//     always @(posedge clk or negedge rst_n_n) begin
//         if (!rst_n_n) begin
//             data_out <= 12'd0; // data_out rst_n_n to 0
//             sum <= 12'd0; // rst_n_n sum to 0
//         end
//         else begin
//             sum <= 12'd0; // rst_n_n sum for holding all 36
//             for (a = 0; a < 6; a = a + 1) begin
//                 for (b = 0; b < 6; b = b + 1) begin
//                     feature_map[i][j] <= data_in[a][b] * kernel[i][j]; //applying kernel filter
//                     sum <= sum + feature_map[i][j]; //sum of 36 product numbers
//                 end
//             end
//             data_out <= sum;
//         end
//     end 

// endmodule


///////////////////////////////////////// NEW CODE //////////////////////////////////

module convLayer(
    input wire [7:0] ui_in,  // 8 buttons, ui_in[7] is ui_in[6]
    input wire clk,        // Clock input
    input wire rst_n,        // Reset input
    output wire [35:0] data_out  // Output data_out as a 36-bit number
);

    reg [5:0] matrix [5:0][5:0];  // 6x6 matrix to hold 1s and 0s
    reg [35:0] data_register [5:0];  // Register to store the 6x6 matrix data
    reg [35:0] output_register;     // Register to store the element-wise multiplication data_out
    reg [35:0] sum_register;        // Register to store the sum of element-wise multiplication

    reg [2:0] row;   // Current row
    reg loading;     // Loading state

    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            row <= 0;
            loading <= 0;
            output_register <= 0;
            sum_register <= 0;
            for (int i = 0; i < 6; i = i + 1) begin
                data_register[i] <= 0;
                for (int j = 0; j < 6; j = j + 1) begin
                    matrix[i][j] <= 0;
                end
            end
        end else begin
            if (ui_in[6]) begin
                if (row < 6) begin
                    loading <= 1;
                    data_register[row] <= ui_in[5:0];
                    row <= row + 1;
                end else begin
                    loading <= 0;
                    row <= 0;
                end
            end

            if (ui_in[7]) begin
                output_register <= 0;
                sum_register <= 0;
                for (int i = 0; i < 6; i = i + 1) begin
                    for (int j = 0; j < 6; j = j + 1) begin
                        matrix[i][j] = 1;
                        output_register[i * 6 + j] = data_register[i] & matrix[i][j];
                        sum_register <= sum_register + output_register[i * 6 + j];
                    end
                end
            end
        end
    end

assign data_out = sum_register;

endmodule
