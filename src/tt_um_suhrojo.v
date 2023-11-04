`default_nettype none

module tt_um_suhrojo(
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    assign uo_out = 8'b0;
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

    // reg [5:0] row[5:0]; // array of reg to store each row
    // integer row_index; // keep track of current row index
    // reg data_load, set_row; 
    // reg [5:0] data_out[5:0][5:0]; // stores output from convLayer kernel filter  
    // reg [5:0] data_in[5:0][5:0]; // stores the 6x6 matrix created from the 6 rows of switch inputs

    // // Logic for storing ui_in[5:0] switch inputs into arrays of rows
    // always @(posedge clk or negedge rst_n) begin 
    //     if (!rst_n) begin
    //         data_load <= 1'b0;
    //         set_row <= 1'b0;
    //         row_index <= 0;
    //     end
    //     else begin
    //         data_load <= ui_in[7];
    //         if (ui_in[6] && set_row) begin //if set_row is high then we can store a new row
    //             row[row_index] <= ui_in[5:0]; // stores current row of switches in row array
    //             row_index <= row_index + 1;
    //             set_row <= 1'b0;
    //         end 
    //         else begin
    //             set_row <= ui_in[6]; //sets the set_row based on ui_in[6] switch
    //         end 
    //     end 
    // end 

    // // Assign the rows to a 6x6 matrix
    // always @(*) begin
    //     if (data_load) begin
    //         for (row_index = 0; row_index < 6; row_index = row_index + 1) begin
    //             data_in[row_index] <= row[row_index];
    //         end
    //     end
    // end

    // convLayer Conv1(
    //     .clk(clk),
    //     .rst_n(rst_n),
    //     .data_in(data_in),
    //     .data_out(data_out)
    // );

    /////////////////////////////NEW CODE/////////////////////////////////////////////////
    reg [35:0] data_out;
    convLayer Conv1(
        .clk(clk),
        .rst_n(rst_n),
        .ui_in(ui_in),
        .data_out(data_out)
    );

endmodule
