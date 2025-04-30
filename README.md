# ⚙️ VHDL Multiplier

This repository contains the implementation of **Combinational** and **Sequential (Serial)** multipliers in VHDL.

---

## 🧾 Project Overview

The multiplier module accepts two 16-bit **unsigned integers** as input—designated as the **multiplier** and the **multiplicand** and computes the corresponding **product**, represented as a 32-bit unsigned integer.

Two architectural approaches have been developed:

- ✅ **Combinational** implementation  
- 🔄 **Sequential (Serial)** implementation

---

## ⚡ Combinational Multiplier

The **combinational multiplier** performs the product in a **single clock cycle**, leveraging the `IEEE.numeric_std.all` library for arithmetic operations.

### 📊 Performance Metrics

- **Latency**: 1 clock cycle
- **Throughput**: `1 / Tclock` ⏱️

---

## 🔄 Serial Multiplier

The **serial multiplier** computes a 32-bit product by performing a **shift-and-add** algorithm over **16 clock cycles**, driven by a simple three-state FSM and a single 17-bit adder.

### 📊 Performance Metrics

- **Latency**: 16 clock cycles  
- **Throughput**: `1 / (16 * Tclock)` ⏱️
