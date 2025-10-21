# ⚙️ CPU Pipeline Simulator (MATLAB GUI)

### 🎯 Overview
**CPU Pipeline Simulator** is an interactive MATLAB GUI that visually demonstrates the working of a pipelined CPU architecture — including instruction flow, cache hits/misses, branch prediction, and IPC (Instructions Per Cycle).

This simulator provides a fun, visual way to understand how CPU stages like **IF, ID, EX, MEM, and WB** operate cycle by cycle.

---

### 🧩 Features
✅ Visual 5-stage pipeline (IF → ID → EX → MEM → WB)  
✅ Animated instruction flow  
✅ Cache Hit / Miss indicators (LED style)  
✅ Branch Predictor visualization  
✅ Real-time IPC (Instructions Per Cycle) gauge  
✅ Color-coded instruction tracking  
✅ Built entirely in **MATLAB**

---

### 🚀 How It Works
Each simulation cycle:
- Moves instructions through pipeline stages.
- Randomly generates cache hit/miss conditions.
- Randomly updates branch predictor status.
- Updates the IPC gauge to visualize processor efficiency.

The GUI provides an intuitive real-time visualization of instruction-level parallelism in modern processors.

---

### 🖥️ Demo
![CPU Pipeline GUI Demo](https://github.com/<your-username>/cpu-pipeline-simulator/blob/main/demo.gif)

---

### 🧠 Requirements
- MATLAB R2020 or newer  
- Image Processing Toolbox (optional, for visuals)

---

### ▶️ Run the Project
```matlab
cpu_pipeline_gui
