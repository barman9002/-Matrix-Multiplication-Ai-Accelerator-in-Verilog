`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2025 15:41:47
// Design Name: 
// Module Name: matrix_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// ===========================================================
// Matrix Multiplication Accelerator (4x4) - Synthesizable Version
// Designed by: Abhisekh Barman
// ===========================================================

module matrix_multiplier (
    input  wire clk,
    input  wire [8*16-1:0] A_flat,  // 16 elements × 8 bits each
    input  wire [8*16-1:0] B_flat,  // 16 elements × 8 bits each
    output reg  [16*16-1:0] C_flat  // 16 elements × 16 bits each
);

    integer i, j, k;
    reg [7:0]  A [0:3][0:3];
    reg [7:0]  B [0:3][0:3];
    reg [15:0] C [0:3][0:3];
    reg [15:0] temp;

    // ------------------------------
    // Unpack 1D input buses into 2D matrices
    // ------------------------------
    always @(*) begin
        for (i = 0; i < 4; i = i + 1)
            for (j = 0; j < 4; j = j + 1) begin
                A[i][j] = A_flat[(i*4 + j)*8 +: 8];
                B[i][j] = B_flat[(i*4 + j)*8 +: 8];
            end
    end

    // ------------------------------
    // Main matrix multiplication logic
    // ------------------------------
    always @(posedge clk) begin
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                temp = 0;
                for (k = 0; k < 4; k = k + 1) begin
                    temp = temp + (A[i][k] * B[k][j]);
                end
                C[i][j] <= temp;
            end
        end
    end

    // ------------------------------
    // Pack 2D result back into flat output
    // ------------------------------
    always @(*) begin
        for (i = 0; i < 4; i = i + 1)
            for (j = 0; j < 4; j = j + 1)
                C_flat[(i*4 + j)*16 +: 16] = C[i][j];
    end

endmodule


