`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2025 15:42:13
// Design Name: 
// Module Name: tb_matrix_multiplier
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


`timescale 1ns / 1ps
// ===========================================================
// Testbench for Matrix Multiplication Accelerator
// ===========================================================

module tb_matrix_multiplier;

    reg clk;
    reg [8*16-1:0] A_flat;
    reg [8*16-1:0] B_flat;
    wire [16*16-1:0] C_flat;

    integer i, j;

    // Instantiate the top module
    matrix_multiplier uut (
        .clk(clk),
        .A_flat(A_flat),
        .B_flat(B_flat),
        .C_flat(C_flat)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialize matrices A and B (4x4)
        // A matrix
        A_flat[0*8 +: 8]  = 1;  A_flat[1*8 +: 8]  = 2;  A_flat[2*8 +: 8]  = 3;  A_flat[3*8 +: 8]  = 4;
        A_flat[4*8 +: 8]  = 5;  A_flat[5*8 +: 8]  = 6;  A_flat[6*8 +: 8]  = 7;  A_flat[7*8 +: 8]  = 8;
        A_flat[8*8 +: 8]  = 9;  A_flat[9*8 +: 8]  = 10; A_flat[10*8 +: 8] = 11; A_flat[11*8 +: 8] = 12;
        A_flat[12*8 +: 8] = 13; A_flat[13*8 +: 8] = 14; A_flat[14*8 +: 8] = 15; A_flat[15*8 +: 8] = 16;

        // B matrix
        B_flat[0*8 +: 8]  = 1;  B_flat[1*8 +: 8]  = 2;  B_flat[2*8 +: 8]  = 3;  B_flat[3*8 +: 8]  = 4;
        B_flat[4*8 +: 8]  = 5;  B_flat[5*8 +: 8]  = 6;  B_flat[6*8 +: 8]  = 7;  B_flat[7*8 +: 8]  = 8;
        B_flat[8*8 +: 8]  = 9;  B_flat[9*8 +: 8]  = 10; B_flat[10*8 +: 8] = 11; B_flat[11*8 +: 8] = 12;
        B_flat[12*8 +: 8] = 13; B_flat[13*8 +: 8] = 14; B_flat[14*8 +: 8] = 15; B_flat[15*8 +: 8] = 16;

        // Wait for computation
        #20;

        // Display output matrix C
        $display("===============================================");
        $display("Matrix Multiplication Accelerator Simulation");
        $display("===============================================");
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                $write("%0d ", C_flat[(i*4 + j)*16 +: 16]);
            end
            $write("\n");
        end

        #20;
        $finish;
    end

endmodule
