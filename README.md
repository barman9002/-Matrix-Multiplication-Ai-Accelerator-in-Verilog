# 🧮 Matrix Multiplication AI Accelerator in Verilog

This project demonstrates a simple **Matrix Multiplication Accelerator** designed in **Verilog HDL**.  
It performs multiplication of two 4x4 matrices using basic Verilog constructs and simulates the concept of how AI accelerators handle **matrix operations** — the building blocks of neural networks.

---

## 🚀 Overview

Matrix multiplication is one of the most common operations in **AI chips** and **deep learning accelerators**.  
This project simulates that concept at a small scale by multiplying two 4x4 matrices using sequential logic in Verilog.

---

## 🧠 Concept

If we have two matrices:

```
A = [a00  a01]
    [a10  a11]

B = [b00  b01]
    [b10  b11]
```

The output matrix **C = A × B** is:

```
C00 = a00*b00 + a01*b10
C01 = a00*b01 + a01*b11
C10 = a10*b00 + a11*b10
C11 = a10*b01 + a11*b11
```

This project automates this logic in Verilog hardware.

---

## ⚙️ Features

✅ Performs **4x4 matrix multiplication**  
✅ Uses **sequential logic** with clock and reset  
✅ Displays results in simulation console  
✅ Designed and simulated using **Xilinx Vivado**  
✅ Conceptually similar to **MAC (Multiply and Accumulate)** units used in AI chips  

---

## 🏗️ Module: `matrix_multiplier.v`

### 📘 Code

```verilog
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

```

---

## 🧪 Testbench: `tb_matrix_multiplier.v`

```verilog

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

```

---

## 🧾 Simulation Output Example

When simulated in **Vivado**, you’ll see output like this in the console:

```
=== Matrix Multiplication Accelerator Simulation ===
Matrix A:
[1 2]
[3 4]

Matrix B:
[5 6]
[7 8]

Result Matrix C = A x B:
[19 22]
[43 50]
```

---

## 🧩 File Structure

```
Matrix_Multiplication_Accelerator/
│
├── matrix_multiplier.v        # Main design file (Top Module)
├── tb_matrix_multiplier.v     # Testbench file
└── README.md                  # Documentation
```

---

## 🧰 Tools Used

- **Xilinx Vivado** (for simulation and synthesis)
- **Verilog HDL**

---

## 💡 Future Improvements

- Add **MAC (Multiply-Accumulate) units** as submodules
- Implement **pipelined or parallel processing**
- Extend to **fixed-point or floating-point operations**

---

## 🧑‍💻 Author

**Abhisekh Barman**  
💻 Developer & AI Enthusiast  
📧 [Email](mailto:abhisekhbarman688@gmail.com)  
🌐 [GitHub](https://github.com/barman9002)

---

## ⭐ Support

If you like this project, give it a ⭐ on GitHub and share it with others learning Verilog or AI hardware concepts!
