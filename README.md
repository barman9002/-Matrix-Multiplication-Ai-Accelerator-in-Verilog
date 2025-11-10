# 🧮 Matrix Multiplication Accelerator in Verilog

This project demonstrates a simple **Matrix Multiplication Accelerator** designed in **Verilog HDL**.  
It performs multiplication of two 2x2 matrices using basic Verilog constructs and simulates the concept of how AI accelerators handle **matrix operations** — the building blocks of neural networks.

---

## 🚀 Overview

Matrix multiplication is one of the most common operations in **AI chips** and **deep learning accelerators**.  
This project simulates that concept at a small scale by multiplying two 2x2 matrices using sequential logic in Verilog.

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

✅ Performs **2x2 matrix multiplication**  
✅ Uses **sequential logic** with clock and reset  
✅ Displays results in simulation console  
✅ Designed and simulated using **Xilinx Vivado**  
✅ Conceptually similar to **MAC (Multiply and Accumulate)** units used in AI chips  

---

## 🏗️ Module: `matrix_multiplier.v`

### 📘 Code

```verilog
module matrix_multiplier(
    input clk,
    input rst,
    input [7:0] A00, A01, A10, A11,   // Matrix A elements
    input [7:0] B00, B01, B10, B11,   // Matrix B elements
    output reg [15:0] C00, C01, C10, C11  // Result matrix C elements
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            C00 <= 0; C01 <= 0;
            C10 <= 0; C11 <= 0;
        end else begin
            // Matrix Multiplication Logic
            C00 <= (A00 * B00) + (A01 * B10);
            C01 <= (A00 * B01) + (A01 * B11);
            C10 <= (A10 * B00) + (A11 * B10);
            C11 <= (A10 * B01) + (A11 * B11);
        end
    end
endmodule
```

---

## 🧪 Testbench: `tb_matrix_multiplier.v`

```verilog
`timescale 1ns/1ps
module tb_matrix_multiplier;
    reg clk, rst;
    reg [7:0] A00, A01, A10, A11;
    reg [7:0] B00, B01, B10, B11;
    wire [15:0] C00, C01, C10, C11;

    matrix_multiplier uut (
        .clk(clk),
        .rst(rst),
        .A00(A00), .A01(A01), .A10(A10), .A11(A11),
        .B00(B00), .B01(B01), .B10(B10), .B11(B11),
        .C00(C00), .C01(C01), .C10(C10), .C11(C11)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $display("=== Matrix Multiplication Accelerator Simulation ===");
        clk = 0;
        rst = 1;
        #10 rst = 0;

        // Initialize Matrices
        A00 = 1; A01 = 2;
        A10 = 3; A11 = 4;

        B00 = 5; B01 = 6;
        B10 = 7; B11 = 8;

        #10;
        $display("Matrix A:");
        $display("[%d %d]", A00, A01);
        $display("[%d %d]", A10, A11);

        $display("Matrix B:");
        $display("[%d %d]", B00, B01);
        $display("[%d %d]", B10, B11);

        #10;
        $display("Result Matrix C = A x B:");
        $display("[%d %d]", C00, C01);
        $display("[%d %d]", C10, C11);

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

- Expand to **4x4 or 8x8 matrices**
- Add **MAC (Multiply-Accumulate) units** as submodules
- Implement **pipelined or parallel processing**
- Extend to **fixed-point or floating-point operations**

---

## 🧑‍💻 Author

**Abhisekh Barman**  
💻 Developer & AI Enthusiast  
📧 [Email](mailto:abhisekhbarman@example.com)  
🌐 [GitHub](https://github.com/yourusername)

---

## ⭐ Support

If you like this project, give it a ⭐ on GitHub and share it with others learning Verilog or AI hardware concepts!
